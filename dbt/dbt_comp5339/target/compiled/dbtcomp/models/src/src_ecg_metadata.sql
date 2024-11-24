WITH raw_ecg_metadata AS (
    SELECT * FROM "eicu_dw"."import"."ecg_metadata_dw"
)

SELECT
    file_name,
    ecg_no_within_stay,
    ecg_taken_in_ed,
    ecg_taken_in_hosp,
    ecg_taken_in_ed_or_hosp
FROM raw_ecg_metadata