
  create view "eicu_dw"."dev"."src_fold_assignment__dbt_tmp"
    
    
  as (
    WITH raw_fold_assignment AS (
    SELECT * FROM "eicu_dw"."import"."fold_assignment_dw"
)

SELECT
    file_name,
    fold,
    strat_fold
FROM raw_fold_assignment
  );