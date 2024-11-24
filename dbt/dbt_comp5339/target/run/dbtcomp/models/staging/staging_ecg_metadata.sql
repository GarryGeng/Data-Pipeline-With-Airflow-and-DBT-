
  create view "eicu_dw"."dev"."staging_ecg_metadata__dbt_tmp"
    
    
  as (
    WITH staging_ecg_metadata AS (
    SELECT
        file_name,
        ecg_no_within_stay,
        CASE WHEN ecg_taken_in_ed = 'TRUE' THEN TRUE ELSE FALSE END AS ecg_taken_in_ed,
        CASE WHEN ecg_taken_in_hosp = 'TRUE' THEN TRUE ELSE FALSE END AS ecg_taken_in_hosp,
        CASE WHEN ecg_taken_in_ed_or_hosp = 'TRUE' THEN TRUE ELSE FALSE END AS ecg_taken_in_ed_or_hosp
    FROM "eicu_dw"."dev"."src_ecg_metadata"
)

SELECT
    file_name,
    ecg_no_within_stay,
    ecg_taken_in_ed,
    ecg_taken_in_hosp,
    ecg_taken_in_ed_or_hosp
FROM staging_ecg_metadata
  );