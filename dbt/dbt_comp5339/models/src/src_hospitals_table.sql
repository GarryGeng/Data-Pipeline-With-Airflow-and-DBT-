WITH raw_hospitals AS (
    SELECT * FROM {{ source('import', 'hospitals_dw') }}
)

SELECT
    hospital_id,
    ed_stay_id,
    ed_hadm_id,
    hosp_hadm_id
FROM raw_hospitals
