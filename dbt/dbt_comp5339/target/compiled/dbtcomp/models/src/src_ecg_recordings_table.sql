WITH raw_ecg_recordings AS (
    SELECT * FROM "eicu_dw"."import"."ecg_recordings_dw"
)

SELECT
    recordings_id,
    file_name,
    study_id,
    ecg_time
FROM raw_ecg_recordings