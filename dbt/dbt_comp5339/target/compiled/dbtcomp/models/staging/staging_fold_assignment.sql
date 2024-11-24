WITH staging_fold_assignment AS (
    SELECT
        file_name,
        fold,
        strat_fold
    FROM "eicu_dw"."dev"."src_fold_assignment"
)

SELECT
    file_name,
    fold,
    strat_fold
FROM staging_fold_assignment