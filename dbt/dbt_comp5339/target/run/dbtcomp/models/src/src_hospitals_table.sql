
  create view "eicu_dw"."dev"."src_hospitals_table__dbt_tmp"
    
    
  as (
    WITH raw_hospitals AS (
    SELECT * FROM "eicu_dw"."import"."hospitals_dw"
)

SELECT
    hospital_id,
    ed_stay_id,
    ed_hadm_id,
    hosp_hadm_id
FROM raw_hospitals
  );