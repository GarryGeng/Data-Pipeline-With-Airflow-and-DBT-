
  create view "eicu_dw"."dev"."staging_diagnoses__dbt_tmp"
    
    
  as (
    WITH staging_diagnoses AS (
    SELECT
        diagnosis_id,
        CASE 
            WHEN ed_stay_id IS NULL THEN NULL 
            ELSE ed_stay_id 
        END AS ed_stay_id, 
        CASE 
            WHEN ed_diag_ed IN ('', '[]') THEN NULL
            ELSE string_to_array(trim(both '[]' from ed_diag_ed), ', ')
        END AS ed_diag_ed,
        CASE 
            WHEN ed_diag_hosp IN ('', '[]') THEN NULL
            ELSE string_to_array(trim(both '[]' from ed_diag_hosp), ', ')
        END AS ed_diag_hosp,
        CASE 
            WHEN hosp_diag_hosp IN ('', '[]') THEN NULL
            ELSE string_to_array(trim(both '[]' from hosp_diag_hosp), ', ')
        END AS hosp_diag_hosp,
        CASE 
            WHEN all_diag_hosp IN ('', '[]') THEN NULL
            ELSE string_to_array(trim(both '[]' from all_diag_hosp), ', ')
        END AS all_diag_hosp,
        CASE 
            WHEN all_diag_all IN ('', '[]') THEN NULL
            ELSE string_to_array(trim(both '[]' from all_diag_all), ', ')
        END AS all_diag_all
    FROM "eicu_dw"."dev"."src_diagnoses_table"
)

SELECT
    diagnosis_id,
    ed_stay_id,
    ed_diag_ed,
    ed_diag_hosp,
    hosp_diag_hosp,
    all_diag_hosp,
    all_diag_all
FROM staging_diagnoses
  );