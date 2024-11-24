{{
    config(
        materialized = 'table',
        unique_key = 'diagnosis_id'
    )
}}

SELECT
    diagnosis_id,
    ed_stay_id,
    ed_diag_ed,
    ed_diag_hosp,
    hosp_diag_hosp,
    all_diag_hosp,
    all_diag_all
FROM {{ ref('staging_diagnoses') }}
