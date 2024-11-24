{{
    config(
        materialized = 'table',
        unique_key = 'file_name'
    )
}}

SELECT
    file_name,
    ecg_no_within_stay,
    ecg_taken_in_ed,
    ecg_taken_in_hosp,
    ecg_taken_in_ed_or_hosp
FROM {{ ref('staging_ecg_metadata') }}
