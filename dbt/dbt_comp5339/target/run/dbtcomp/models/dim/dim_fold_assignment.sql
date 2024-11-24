
  
    

  create  table "eicu_dw"."dev"."dim_fold_assignment__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    file_name,
    fold,
    strat_fold
FROM "eicu_dw"."dev"."staging_fold_assignment"
  );
  