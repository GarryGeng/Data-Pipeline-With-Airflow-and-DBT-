
  
    

  create  table "eicu_dw"."dev"."dim_ecg_recordings__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    recordings_id,
    file_name,
    study_id,
    ecg_time
FROM "eicu_dw"."dev"."staging_ecg_recordings"
  );
  