{{
    config(
        materialized = 'table',
        unique_key = 'file_name'
    )
}}

SELECT
    file_name,
    fold,
    strat_fold
FROM {{ ref('staging_fold_assignment') }}
