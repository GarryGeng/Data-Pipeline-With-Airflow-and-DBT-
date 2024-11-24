WITH raw_fold_assignment AS (
    SELECT * FROM {{ source('import', 'fold_assignment_dw') }}
)

SELECT
    file_name,
    fold,
    strat_fold
FROM raw_fold_assignment
