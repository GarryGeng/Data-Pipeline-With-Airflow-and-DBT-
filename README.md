# Data-Pipeline-With-Airflow-and-DBT-

## Project Structure

The project is organized into the following directories:

* **dbt/**: Contains the dbt project for data transformation.
    * **dbt_comp5339/**: Main dbt project directory.
        * **models/**: Contains SQL models for staging, dimension, and fact tables.
            * **staging/**: SQL scripts for staging tables.
            * **dim/**: SQL scripts for dimension tables.
            * **fact/**: SQL scripts for fact tables.
        * **sources.yml**: Source configuration file.
        * **src/**: Source SQL scripts.
* **airflow/**: Contains Airflow DAGs for ETL orchestration.
    * **dags/**: Contains DAGs and related scripts for Airflow.
        * **initialize_etl_environment_COMP5339HD.py**: Create the necessary database objects.
        * **load_csv_to_dw.py**: Import data from `data.csv` to the Data Warehouse.
        * **run_dbt_init_tasks.py**: Initialize dbt models.
        * **run_dbt_model.py**: Run all the SQL tasks.
* **superset/**: Contains Superset assets for data visualization.
    * **assets/**: Assets for Superset, such as dashboards.
        * **dashboard.json**: JSON file defining a Superset dashboard.

## System Setup

### (1) Setup and Data Generation

* **Setup the Environment:**
    * Install Docker on your system.
    * Download the project repository and navigate to the root folder.
* **Build and Start the Docker Containers:**
    * Run the following command to build and start the Docker containers:
    ```bash
    docker compose up --build
    ```

### (2) ETL Orchestration with Airflow

* **Initialize ETL Environment:**
    * Access the Airflow GUI at `http://localhost:8080`.
    * Use the default credentials (user: airflow, password: airflow) to log in.
    * Trigger the `initialize_etl_environment_COMP5339HD` DAG.
* **Data Import:**
    * Create a dataset folder in the root directory. Put `data.csv` in that folder.
    * Trigger the `load_csv_to_dw` DAG.

### (3) Data Transformation with dbt

* **Initialize dbt:**
    * Access the Airflow GUI and trigger the `run_dbt_init_tasks` DAG.
* **Run dbt Models:**
    * Trigger the `run_dbt_model` DAG.

### (4) Data Analysis and Visualization with Superset

* **Explore Data with Superset:**
    * Access the Superset GUI at `http://localhost:8088`.
    * Use the default credentials (user: admin, password: admin) to log in.
    * Create visualizations to analyze the data in the Data Warehouse.




