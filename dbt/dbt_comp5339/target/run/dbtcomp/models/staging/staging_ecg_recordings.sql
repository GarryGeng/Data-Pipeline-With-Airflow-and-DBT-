
  create view "eicu_dw"."dev"."staging_ecg_recordings__dbt_tmp"
    
    
  as (
    WITH staging_ecg_recordings AS (
    SELECT
        recordings_id,
        file_name,
        study_id,
        ecg_time
    FROM "eicu_dw"."dev"."src_ecg_recordings_table"
)

SELECT
    recordings_id,
    file_name,
    study_id,
    ecg_time
FROM staging_ecg_recordings
  );