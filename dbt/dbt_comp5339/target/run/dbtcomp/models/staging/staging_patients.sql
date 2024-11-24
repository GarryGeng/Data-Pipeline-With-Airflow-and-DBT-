
  create view "eicu_dw"."dev"."staging_patients__dbt_tmp"
    
    
  as (
    WITH staging_patients AS (
    SELECT
        patient_id,
        subject_id,
        
        CASE 
            WHEN gender = 'missing' THEN NULL
            ELSE gender
        END AS gender,
        
        age,
        anchor_year,
        anchor_age,
        
        CASE 
            WHEN dod IS NULL THEN NULL 
            ELSE dod
        END AS dod
    FROM "eicu_dw"."dev"."src_patients_table"
)

SELECT
    patient_id,
    subject_id,
    gender,
    age,
    anchor_year,
    anchor_age,
    dod
FROM staging_patients
  );