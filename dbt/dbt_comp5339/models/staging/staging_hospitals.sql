WITH staging_hospitals AS (
    SELECT
        hospital_id,
        ed_stay_id,
        
        CASE 
            WHEN ed_hadm_id IS NULL THEN NULL 
            ELSE ed_hadm_id 
        END AS ed_hadm_id,  
        
        CASE 
            WHEN hosp_hadm_id IS NULL THEN NULL 
            ELSE hosp_hadm_id 
        END AS hosp_hadm_id
        
    FROM {{ ref('src_hospitals_table') }}
)

SELECT
    hospital_id,
    ed_stay_id,
    ed_hadm_id,
    hosp_hadm_id
FROM staging_hospitals

