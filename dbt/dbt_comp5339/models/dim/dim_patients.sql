{{
    config(
        materialized = 'table',
        unique_key = 'patient_id'
    )
}}

SELECT
    patient_id,
    subject_id,
    gender,
    age,
    anchor_year,
    anchor_age,
    dod
FROM {{ ref('staging_patients') }}
