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
    FROM {{ ref('src_patients_table') }}
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

