
  create view "eicu_dw"."dev"."src_ecg_recordings_table__dbt_tmp"
    
    
  as (
    WITH raw_ecg_recordings AS (
    SELECT * FROM "eicu_dw"."import"."ecg_recordings_dw"
)

SELECT
    recordings_id,
    file_name,
    study_id,
    ecg_time
FROM raw_ecg_recordings
  );