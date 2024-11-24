WITH staging_fold_assignment AS (
    SELECT
        file_name,
        fold,
        strat_fold
    FROM {{ ref('src_fold_assignment') }}
)

SELECT
    file_name,
    fold,
    strat_fold
FROM staging_fold_assignment
