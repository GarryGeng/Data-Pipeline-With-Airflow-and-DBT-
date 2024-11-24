
  
    

  create  table "eicu_dw"."dev"."dim_diagnoses__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    diagnosis_id,
    ed_stay_id,
    ed_diag_ed,
    ed_diag_hosp,
    hosp_diag_hosp,
    all_diag_hosp,
    all_diag_all
FROM "eicu_dw"."dev"."staging_diagnoses"
  );
  