
  create view "eicu_dw"."dev"."src_diagnoses_table__dbt_tmp"
    
    
  as (
    WITH raw_diagnoses AS (
    SELECT * FROM "eicu_dw"."import"."diagnoses_dw"
)

SELECT
    diagnosis_id,
    ed_stay_id,
    ed_diag_ed,
    ed_diag_hosp,
    hosp_diag_hosp,
    all_diag_hosp,
    all_diag_all
FROM raw_diagnoses
  );