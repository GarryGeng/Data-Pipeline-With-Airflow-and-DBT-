
  
    

  create  table "eicu_dw"."dev"."dim_hospitals__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    hospital_id,
    ed_stay_id,
    ed_hadm_id,
    hosp_hadm_id
FROM "eicu_dw"."dev"."staging_hospitals"
  );
  