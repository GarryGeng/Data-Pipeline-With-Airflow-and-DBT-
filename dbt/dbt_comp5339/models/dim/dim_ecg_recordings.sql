{{
    config(
        materialized = 'table',
        unique_key = 'recordings_id'
    )
}}

SELECT
    recordings_id,
    file_name,
    study_id,
    ecg_time
FROM {{ ref('staging_ecg_recordings') }}
