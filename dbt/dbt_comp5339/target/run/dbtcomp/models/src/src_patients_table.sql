
  create view "eicu_dw"."dev"."src_patients_table__dbt_tmp"
    
    
  as (
    WITH raw_patients AS (
    SELECT * FROM "eicu_dw"."import"."patients_dw"
)

SELECT
    patient_id,
    subject_id,
    gender,
    age,
    anchor_year,
    anchor_age,
    dod
FROM raw_patients
  );