from airflow import DAG
from airflow.operators.postgres_operator import PostgresOperator
from datetime import timedelta, datetime
import pytz

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5)
}
dag = DAG(
    'initialize_etl_environment_COMP5339HD',
    default_args=default_args,
    description='Initialize ETL Environment with Multiple Tables for MIMIC-IV-ECG Data',
    schedule_interval='@once',
    start_date=datetime(2024, 1, 1, 0, 0, 0, 0, pytz.UTC),
    tags=['init'],
    is_paused_upon_creation=False
)

# Creating schemas
# Import: import.patient_info and import.ecg_study for raw data ingestion.
create_schemas_task_dw = PostgresOperator(
    task_id='create_schemas_dw',
    sql=""" 
    Create schema if not exists import; 
    """,
    dag=dag,
    postgres_conn_id='eicu_dw',
    autocommit=True
)

create_patients_table_dw = PostgresOperator(
    task_id='create_patients_table_dw',
    sql="""
    CREATE TABLE IF NOT EXISTS import.patients_dw (
        patient_id SERIAL PRIMARY KEY,
        subject_id INT,
        gender VARCHAR(10),
        age INT,
        anchor_year INT,
        anchor_age INT,
        dod DATE
    );
    """,
    dag=dag,
    postgres_conn_id='eicu_dw',
    autocommit=True
)

create_ecg_recordings_table_dw = PostgresOperator(
    task_id='create_ecg_recordings_table_dw',
    sql="""
    CREATE TABLE IF NOT EXISTS import.ecg_recordings_dw (
        recordings_id SERIAL PRIMARY KEY,
        file_name VARCHAR(1000),
        study_id INT,
        ecg_time TIMESTAMP
    );
    """,
    dag=dag,
    postgres_conn_id='eicu_dw',
    autocommit=True
)

create_hospitals_table_dw = PostgresOperator(
    task_id='create_hospitals_table_dw',
    sql="""
    CREATE TABLE IF NOT EXISTS import.hospitals_dw (
        hospital_id SERIAL PRIMARY KEY,
        ed_stay_id INT,
        ed_hadm_id INT,
        hosp_hadm_id INT
    );
    """,
    dag=dag,
    postgres_conn_id='eicu_dw',
    autocommit=True
)

create_diagnoses_table_dw = PostgresOperator(
    task_id='create_diagnoses_table_dw',
    sql="""
    CREATE TABLE IF NOT EXISTS import.diagnoses_dw (
        diagnosis_id SERIAL PRIMARY KEY,
        ed_stay_id INT,
        ed_diag_ed TEXT,
        ed_diag_hosp TEXT,
        hosp_diag_hosp TEXT,
        all_diag_hosp TEXT,
        all_diag_all TEXT
    );
    """,
    dag=dag,
    postgres_conn_id='eicu_dw',
    autocommit=True
)

create_ecg_metadata_dw = PostgresOperator(
    task_id='create_ecg_metadata_table_dw',
    sql="""
    CREATE TABLE IF NOT EXISTS import.ecg_metadata_dw (
        file_name VARCHAR(1000) Primary key,
        ecg_no_within_stay INT,
        ecg_taken_in_ed BOOLEAN,
        ecg_taken_in_hosp BOOLEAN,
        ecg_taken_in_ed_or_hosp BOOLEAN
    );
    """,
    dag=dag,
    postgres_conn_id='eicu_dw',
    autocommit=True
)

create_fold_assignment_dw = PostgresOperator(
    task_id='create_fold_assignment_table_dw',
    sql="""
    CREATE TABLE IF NOT EXISTS import.fold_assignment_dw (
        file_name VARCHAR(1000),
        fold INT,
        strat_fold INT
    );
    """,
    dag=dag,
    postgres_conn_id='eicu_dw',
    autocommit=True
)

# Defining task dependencies
create_schemas_task_dw >> create_patients_table_dw
create_patients_table_dw >> create_ecg_recordings_table_dw
create_ecg_recordings_table_dw >> create_hospitals_table_dw
create_hospitals_table_dw >> create_diagnoses_table_dw
create_diagnoses_table_dw >> create_ecg_metadata_dw
create_ecg_metadata_dw >> create_fold_assignment_dw
