

SELECT
    er.file_name,
    er.study_id,
    er.ecg_time,
    dp.patient_id,
    dp.subject_id,
    dp.gender,
    dp.age,
    dp.anchor_year,
    dp.anchor_age,
    dp.dod,
    em.ecg_no_within_stay,
    em.ecg_taken_in_ed,
    em.ecg_taken_in_hosp,
    em.ecg_taken_in_ed_or_hosp,
    dh.ed_stay_id,
    dh.ed_hadm_id,
    dh.hosp_hadm_id,
    dd.diagnosis_id,
    dd.ed_diag_ed,
    dd.ed_diag_hosp,
    dd.hosp_diag_hosp,
    dd.all_diag_hosp,
    dd.all_diag_all,
    fa.fold,
    fa.strat_fold

FROM "eicu_dw"."dev"."dim_ecg_recordings" er
LEFT JOIN "eicu_dw"."dev"."dim_patients" dp ON er.recordings_id = dp.patient_id
LEFT JOIN "eicu_dw"."dev"."dim_ecg_metadata" em ON er.file_name = em.file_name
LEFT JOIN "eicu_dw"."dev"."dim_hospitals" dh ON dh.hospital_id = dp.patient_id
LEFT JOIN "eicu_dw"."dev"."dim_diagnoses" dd ON dd.ed_stay_id = dh.ed_stay_id
LEFT JOIN "eicu_dw"."dev"."dim_fold_assignment" fa ON er.file_name = fa.file_name