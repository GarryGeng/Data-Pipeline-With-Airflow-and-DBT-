{{
    config(
        materialized = 'table',
        unique_key = 'hospital_id'
    )
}}

SELECT
    hospital_id,
    ed_stay_id,
    ed_hadm_id,
    hosp_hadm_id
FROM {{ ref('staging_hospitals') }}
