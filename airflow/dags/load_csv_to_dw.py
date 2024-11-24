from sqlalchemy import inspect
import pytz
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.hooks.postgres_hook import PostgresHook
from datetime import datetime, timedelta
from airflow.sensors.external_task_sensor import ExternalTaskSensor
from airflow.utils.dates import days_ago
import os
import pandas as pd

# Default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5)
}

# Define the DAG
dag = DAG(
    'load_csv_to_dw',
    default_args=default_args,
    description='Load CSV data into DW',
    schedule_interval='@once',
    start_date=days_ago(1),
    is_paused_upon_creation=False
)

# wait_for_init = ExternalTaskSensor(
#     task_id='wait_for_init',
#     external_dag_id='initialize_etl_environment',
#     execution_date_fn = lambda x: datetime(2024, 1, 1, 0, 0, 0, 0, pytz.UTC),
#     timeout=1,
#     dag=dag
# )

# Path to the CSV data file
DATA_PATH = '/import/data.csv'

def load_csv_to_db():
    if not os.path.exists(DATA_PATH):
        raise FileNotFoundError(f"CSV file not found at path: {DATA_PATH}")

    df = pd.read_csv(DATA_PATH)
    df = df.where(pd.notnull(df), None)
    df = df.drop(df.columns[0], axis=1)  # Adjust if necessary

    # Adjusted dw_tables mapping with schema, table names, and columns
    dw_tables = {
        'patients_dw': {
            'schema': 'import',
            'table': 'patients_dw',
            'columns': ['subject_id', 'gender', 'age', 'anchor_year', 'anchor_age', 'dod']
        },
        'ecg_recordings_dw': {
            'schema': 'import',
            'table': 'ecg_recordings_dw',
            'columns': ['file_name', 'study_id','ecg_time']
        },
        'hospitals_dw': {
            'schema': 'import',
            'table': 'hospitals_dw',
            'columns': ['ed_stay_id', 'ed_hadm_id', 'hosp_hadm_id']
        },
        'diagnoses_dw': {
            'schema': 'import',
            'table': 'diagnoses_dw',
            'columns': ['ed_stay_id', 'ed_diag_ed', 'ed_diag_hosp', 'hosp_diag_hosp', 'all_diag_hosp', 'all_diag_all']
        },
        'ecg_metadata_dw': {
            'schema': 'import',
            'table': 'ecg_metadata_dw',
            'columns': ['file_name', 'ecg_no_within_stay', 'ecg_taken_in_ed', 'ecg_taken_in_hosp', 'ecg_taken_in_ed_or_hosp']
        },
        'fold_assignment_dw': {
            'schema': 'import',
            'table': 'fold_assignment_dw',
            'columns': ['file_name', 'fold', 'strat_fold']
        }
    }

    # Insert data into Data Warehouse (DW) Database
    dw_hook = PostgresHook(postgres_conn_id='eicu_dw')
    dw_engine = dw_hook.get_sqlalchemy_engine()

    for table_info in dw_tables.values():
        schema = table_info['schema']
        table_name = table_info['table']
        columns = table_info['columns']

        # Select the relevant columns
        table_df = df[columns].copy()

        try:
            table_df.to_sql(table_name, dw_engine, schema=schema, if_exists='append', index=False)
            print(f"Successfully inserted data into DW table: {schema}.{table_name}")
        except Exception as e:
            print(f"Error inserting data into DW table {schema}.{table_name}: {str(e)}")

    print("Data insertion into DW databases completed successfully.")

# Define the PythonOperator to execute the load_csv_to_db function
load_csv_task = PythonOperator(
    task_id='load_csv_to_db',
    python_callable=load_csv_to_db,
    dag=dag,
)

# wait_for_init >> load_csv_task
load_csv_task