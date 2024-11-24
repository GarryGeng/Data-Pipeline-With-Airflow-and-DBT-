# Import necessary libraries and modules
from datetime import timedelta, datetime
from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.sensors.external_task_sensor import ExternalTaskSensor
from airflow.operators.bash import BashOperator



# Define default arguments for the DAG
default_args = {
  'start_date': days_ago(1),  # Start date for the DAG
  'retries': 1,  # Number of retries
  'retry_delay': timedelta(minutes=5)  # Delay between retries
}

# Define the DAG
with DAG(dag_id='run_dbt_init_tasks', default_args=default_args, schedule_interval='@once', ) as dag:

  # # Task to wait for the completion of 'initialize_tables_etl_environment' DAG
  # wait_for_load_csv_to_dw = ExternalTaskSensor(
  #   task_id='wait_for_load_csv_to_dw',
  #   external_dag_id='load_csv_to_dw',
  #   execution_date_fn=lambda x: days_ago(1),  # Execution date function
  #   timeout=300  # Timeout for the sensor
  # )

  # Task to pull the most recent version of the dependencies listed in packages.yml from git
  dbt_deps = BashOperator(
    task_id='dbt_deps',
    bash_command='cd /usr/local/airflow/dbt && /usr/local/bin/dbt deps --add-package /usr/local/airflow/dbt-utils-main --source local'
  )

  # Task to seed the database with data defined in dbt seed files
  dbt_seed = BashOperator(
    task_id='dbt_seed',
    bash_command='cd /usr/local/airflow/dbt && /usr/local/bin/dbt seed'
  )

  # Define task dependencies
  # wait_for_load_csv_to_dw >> dbt_deps>> dbt_seed
  dbt_deps>> dbt_seed