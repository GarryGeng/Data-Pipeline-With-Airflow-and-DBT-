
  
    

  create  table "eicu_dw"."dev"."dim_ecg_metadata__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    file_name,
    ecg_no_within_stay,
    ecg_taken_in_ed,
    ecg_taken_in_hosp,
    ecg_taken_in_ed_or_hosp
FROM "eicu_dw"."dev"."staging_ecg_metadata"
  );
  