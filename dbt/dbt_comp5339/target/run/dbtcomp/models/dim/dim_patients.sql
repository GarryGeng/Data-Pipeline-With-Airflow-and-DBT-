
  
    

  create  table "eicu_dw"."dev"."dim_patients__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    patient_id,
    subject_id,
    gender,
    age,
    anchor_year,
    anchor_age,
    dod
FROM "eicu_dw"."dev"."staging_patients"
  );
  