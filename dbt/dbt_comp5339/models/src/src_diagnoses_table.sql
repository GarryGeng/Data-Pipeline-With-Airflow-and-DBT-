WITH raw_diagnoses AS (
    SELECT * FROM {{ source('import', 'diagnoses_dw') }}
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
