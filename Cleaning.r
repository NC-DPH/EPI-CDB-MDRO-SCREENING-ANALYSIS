#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('MDROScreeningDataAna_DATA_Current.csv')
#Setting Labels

label(data$screening_id)="Screening ID"
label(data$redcap_repeat_instrument)="Repeat Instrument"
label(data$redcap_repeat_instance)="Repeat Instance"
label(data$year)="Year of screening"
label(data$index_id)="Index case event ID"
label(data$name)="Abstractor name"
label(data$arln_id_1)="Additional screening IDs (e.g., ARLN IDs)"
label(data$arln_id_2)="Additional screening IDs (e.g., ARLN IDs)"
label(data$arln_id_3)="Additional screening IDs (e.g., ARLN IDs)"
label(data$arln_id_4)="Additional screening IDs (e.g., ARLN IDs)"
label(data$arln_id_5)="Additional screening IDs (e.g., ARLN IDs)"
label(data$arln_id_6)="Additional screening IDs (e.g., ARLN IDs)"
label(data$arln_id_7)="Additional screening IDs (e.g., ARLN IDs)"
label(data$arln_id_8)="Additional screening IDs (e.g., ARLN IDs)"
label(data$arln_id_9)="Additional screening IDs (e.g., ARLN IDs)"
label(data$arln_id_10)="Additional screening IDs (e.g., ARLN IDs)"
label(data$setting)="1. In which setting did screening occur? "
label(data$setting_other)="1a. Other setting"
label(data$setting_acuity)="2. Was the index case on a high acuity unit such as an ICU, burn unit, ventilator unit, or oncology unit?"
label(data$setting_acuity_type___1)="2a. What type of high acuity unit? (choice=ICU)"
label(data$setting_acuity_type___2)="2a. What type of high acuity unit? (choice=Burn unit)"
label(data$setting_acuity_type___3)="2a. What type of high acuity unit? (choice=Ventilator unit)"
label(data$setting_acuity_type___4)="2a. What type of high acuity unit? (choice=Oncology unit)"
label(data$setting_acuity_type___7)="2a. What type of high acuity unit? (choice=Other)"
label(data$setting_acuity_type___9)="2a. What type of high acuity unit? (choice=Unknown)"
label(data$setting_acuity_other)="2b. Other type of high acuity setting"
label(data$reason___1)="3. What was the reason for screening? (check all that apply) (choice=Identified MDRO case)"
label(data$reason___2)="3. What was the reason for screening? (check all that apply) (choice=Preventative PPS in LTACH or vSNF (as part of a specific initiative beginning in 2023). *Skip to screening activities question and select PPS.)"
label(data$reason___3)="3. What was the reason for screening? (check all that apply) (choice=Other (*Explain reason for screening in Notes section at bottom of this form.))"
label(data$intl_hosp)="4. Was the index case identified by admission screening due to a history of international hospitalization or healthcare?"
label(data$organism___1)="5. Which organism(s) prompted the response?  (choice=C. auris)"
label(data$organism___2)="5. Which organism(s) prompted the response?  (choice=E. coli)"
label(data$organism___3)="5. Which organism(s) prompted the response?  (choice=E. cloacae)"
label(data$organism___4)="5. Which organism(s) prompted the response?  (choice=E. aerogenes/K. aerogenes)"
label(data$organism___5)="5. Which organism(s) prompted the response?  (choice=K. pneumoniae)"
label(data$organism___6)="5. Which organism(s) prompted the response?  (choice=K. oxytoca)"
label(data$organism___7)="5. Which organism(s) prompted the response?  (choice=CRPA)"
label(data$organism___8)="5. Which organism(s) prompted the response?  (choice=CRAB)"
label(data$organism___9)="5. Which organism(s) prompted the response?  (choice=No organism identified)"
label(data$organism___10)="5. Which organism(s) prompted the response?  (choice=Other)"
label(data$organism_other)="5a. Other organism(s):"
label(data$cpase___1)="6. Which carbapenemase(s) prompted the response?  (choice=KPC)"
label(data$cpase___2)="6. Which carbapenemase(s) prompted the response?  (choice=NDM)"
label(data$cpase___3)="6. Which carbapenemase(s) prompted the response?  (choice=OXA-23/24)"
label(data$cpase___4)="6. Which carbapenemase(s) prompted the response?  (choice=OXA-48)"
label(data$cpase___5)="6. Which carbapenemase(s) prompted the response?  (choice=VIM)"
label(data$cpase___6)="6. Which carbapenemase(s) prompted the response?  (choice=IMP)"
label(data$cpase___7)="6. Which carbapenemase(s) prompted the response?  (choice=Other)"
label(data$cpase___0)="6. Which carbapenemase(s) prompted the response?  (choice=None)"
label(data$cpase___9)="6. Which carbapenemase(s) prompted the response?  (choice=Unknown)"
label(data$cpase_other)="6a. Other carbapenemase(s):"
label(data$pns)="7. Is the organism pan non-susceptible (PNS)?"
label(data$mdro_date)="8. What was the collection date for the first positive lab for the index case?"
label(data$report_date)="9. What date was the MDRO first reported to public health?"
label(data$cp_ebp)="10. Was the index case on contact or enhanced barrier precautions for their ENTIRE healthcare stay, including before being diagnosed with the MDRO? "
label(data$index_lda___1)="11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Open/draining wounds)"
label(data$index_lda___2)="11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Endotracheal tube/Nasotracheal tube/Tracheostomy)"
label(data$index_lda___3)="11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Central lines (including PICCs))"
label(data$index_lda___4)="11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Other indwelling devices (dialysis catheter, urinary catheter, G tube or NG tube, nephrostomy tube, surgical drain. do not include ostomy.))"
label(data$index_lda___5)="11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Immunocompromised)"
label(data$index_lda___6)="11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Diagnosed with other MDROs (around the same time or prior to the MDRO that triggered screening))"
label(data$index_lda___7)="11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=International healthcare or travel)"
label(data$index_lda___0)="11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=None of the above risk factors are documented)"
label(data$index_lda___9)="11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Unknown- there is no documentation in NCEDSS or notes to inform any selection)"
label(data$index_mdro)="11a. What other MDROs does the index case have?"
label(data$index_assist)="12. Does the index patient need assistance with ADLs/receive high contact care?"
label(data$index_commonareas)="13. Has the index patient used common areas (such as rehab room, ambulate in hallway, activity room, etc)?"
label(data$screen_type___1)="14. What screening activities occurred? Select all that apply. (choice=Point prevalence survey (PPS) (test all patients/residents currently on a unit))"
label(data$screen_type___2)="14. What screening activities occurred? Select all that apply. (choice=Identify contacts and screen those still admitted)"
label(data$screen_type___3)="14. What screening activities occurred? Select all that apply. (choice=Flag contacts for screening on readmission)"
label(data$screen_type___7)="14. What screening activities occurred? Select all that apply. (choice=Other)"
label(data$screen_type___9)="14. What screening activities occurred? Select all that apply. (choice=Unknown)"
label(data$pps_count)="15. How many total PPSs were conducted (at this facility, in reponse to the index case carbapenemase/organism)?"
label(data$ppsonly_count)="16. How many screenings were PPS only?"
label(data$pps_date)="17. What date was the first PPS performed? "
label(data$pps_denom_p1)="18. How many people were tested during the first PPS? (number of swabs collected)"
label(data$pps_num_p1)="19. How many people tested positive during the first PPS, for thesame carbapenemase/organism as the index case?"
label(data$pps_totalpos_p1)="20. How many total people tested positive during the first PPS, for any carbapenemase or C. auris?"
label(data$pps_denom_total)="21. How many total tests were conducted across all PPSs? (number of swabs collected)"
label(data$pps_num_total)="22. How many screening cases were identified across all PPSs?"
label(data$pps_icu)="23. Were any of the units screened a high acuity unit, such as an ICU, burn unit, ventilator unit, or oncology unit ? "
label(data$pps_acuity_type___1)="23a. What type of high acuity unit? (choice=ICU)"
label(data$pps_acuity_type___2)="23a. What type of high acuity unit? (choice=Burn unit)"
label(data$pps_acuity_type___3)="23a. What type of high acuity unit? (choice=Ventilator unit)"
label(data$pps_acuity_type___4)="23a. What type of high acuity unit? (choice=Oncology unit)"
label(data$pps_acuity_type___7)="23a. What type of high acuity unit? (choice=Other)"
label(data$pps_acuity_type___9)="23a. What type of high acuity unit? (choice=Unknown)"
label(data$pps_acuity_other)="23b. Other type of high acuity setting"
label(data$pps_list)="24. Please list the ARLN screening ID, facility type, date, number screened, number positives, and what units were screened for all PPSs in this facility type. For screenings including high acuity units, please break the numbers out by unit if available. "
label(data$pps_admit)="25. Was the index case still admitted to the facility at the time of the first PPS? "
label(data$pps_dc_date)="25a. What date was the index case discharged?"
label(data$pps_refusal_p1)="26. If available: How many patients refused screening during the first screening? "
label(data$pps_refusal_total)="27. If available: How many patients refused screening during all screenings combined? "
label(data$adm_criteria)="28. How were contacts defined? Please document this if information is readily available. If unknown, leave blank."
label(data$adm_total)="29. How many total contacts were identified?"
label(data$adm_screeningcount)="30. How many total screeningsat this facility included screening contacts (as opposed to being only a PPS)?"
label(data$adm_date)="31. What date was the first contact-based screening?"
label(data$adm_tested)="32. How many total contacts  were screened? "
label(data$adm_pos)="33. How many were positive?"
label(data$adm_admit)="34. Was the index case still admitted to the facility at the time of the first contact-based screening?"
label(data$readm_criteria)="35. How were contacts defined? Please document this if information is readily available. If unknown, leave blank."
label(data$readm_total)="36. How many total contacts were identified who had already been discharged?"
label(data$readm_date)="37. What date was the first readmitted contact screened?"
label(data$readm_screened)="38. How many total contacts were screened on readmission?"
label(data$readm_pos)="39. How many contacts tested positive on readmission?"
label(data$other_unknown)="14a. If other/unknown, please provide all available info on the screening, including date, number tested, number positive, and who was screened. "
label(data$notes)="40. Notes (optional)"
label(data$screening_abstraction_complete)="Complete?"
label(data$case_id)="NC EDSS event ID(s)"
label(data$case_name)="Abstractor name"
label(data$case_organism___1)="C1. Which organism(s) did the person test positive for during screening? (choice=C. auris)"
label(data$case_organism___2)="C1. Which organism(s) did the person test positive for during screening? (choice=E. coli)"
label(data$case_organism___3)="C1. Which organism(s) did the person test positive for during screening? (choice=E. cloacae)"
label(data$case_organism___4)="C1. Which organism(s) did the person test positive for during screening? (choice=E. aerogenes/K. aerogenes)"
label(data$case_organism___5)="C1. Which organism(s) did the person test positive for during screening? (choice=K. pneumoniae)"
label(data$case_organism___6)="C1. Which organism(s) did the person test positive for during screening? (choice=K. oxytoca)"
label(data$case_organism___7)="C1. Which organism(s) did the person test positive for during screening? (choice=CRPA)"
label(data$case_organism___8)="C1. Which organism(s) did the person test positive for during screening? (choice=CRAB)"
label(data$case_organism___9)="C1. Which organism(s) did the person test positive for during screening? (choice=No organism identified)"
label(data$case_organism___10)="C1. Which organism(s) did the person test positive for during screening? (choice=Other)"
label(data$case_organism_other)="C1a. Other organism:"
label(data$case_cpase___1)="C2. Which carbapenemase(s) did the person test positive for during screening? (choice=KPC)"
label(data$case_cpase___2)="C2. Which carbapenemase(s) did the person test positive for during screening? (choice=NDM)"
label(data$case_cpase___3)="C2. Which carbapenemase(s) did the person test positive for during screening? (choice=OXA-23/24)"
label(data$case_cpase___4)="C2. Which carbapenemase(s) did the person test positive for during screening? (choice=OXA-48)"
label(data$case_cpase___5)="C2. Which carbapenemase(s) did the person test positive for during screening? (choice=VIM)"
label(data$case_cpase___6)="C2. Which carbapenemase(s) did the person test positive for during screening? (choice=IMP)"
label(data$case_cpase___7)="C2. Which carbapenemase(s) did the person test positive for during screening? (choice=Other)"
label(data$case_cpase___8)="C2. Which carbapenemase(s) did the person test positive for during screening? (choice=None)"
label(data$case_cpase___9)="C2. Which carbapenemase(s) did the person test positive for during screening? (choice=Unknown)"
label(data$case_cpase_other)="C2a. Other carbapenemase: "
label(data$case_setting)="C3. In which setting was the case screened?"
label(data$case_setting_other)="C3a. Other setting:"
label(data$case_acuity)="C4. Was the positive residing on a high acuity unit, such as an ICU, burn unit, ventilator unit, or oncology unit?"
label(data$case_acuitytype)="C4a. What type of high acuity setting?"
label(data$case_acuitytypeother)="C4b. Other type of high acuity setting"
label(data$case_reason)="C5. Why was the person screened? "
label(data$case_reason_other)="C5a. Please provide all available information about the reason for screening."
label(data$case_screentype)="C6. Which of the following best describes this screening?"
label(data$case_link)="C7. Which of the following best describes the epi link between the index case and the screening case?"
label(data$case_wgs)="C8. Has whole genome sequencing been conducted on this patient and the index case?"
label(data$case_tbp)="C9. Was this person on transmission-based precautions for their ENTIRE healthcare stay (including before being diagnosed)?"
label(data$case_riskfactors___1)="C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Open/draining wounds)"
label(data$case_riskfactors___2)="C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Endotracheal tube/Nasotracheal tube/Tracheostomy)"
label(data$case_riskfactors___3)="C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Central lines (including PICCs))"
label(data$case_riskfactors___4)="C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Other indwelling devices (dialysis catheter, urinary catheter, G tube or NG tube, nephrostomy tube, surgical drain. do not include ostomy))"
label(data$case_riskfactors___5)="C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Immunocompromised)"
label(data$case_riskfactors___6)="C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Diagnosed with other MDROs (around the same time or prior to the MDRO that triggered screening))"
label(data$case_riskfactors___7)="C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=International healthcare or travel)"
label(data$case_riskfactors___0)="C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=None of the above risk factors are documented)"
label(data$case_riskfactors___9)="C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Unknown- there is no documentation in NCEDSS or notes to inform any selection)"
label(data$case_othermdro)="C10a. What other MDRO(s) does the patient have?"
label(data$case_assist)="C11. Does the screening case need assistance with ADLs/receive high contact care?"
label(data$case_commonareas)="C12. Has the screening case used common areas (such as rehab room, ambulate in hallway, activity room, etc)?"
label(data$case_notes)="C13. Notes (optional)"
label(data$case_abstraction_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_repeat_instrument.factor = factor(data$redcap_repeat_instrument,levels=c("screening_abstraction","case_abstraction"))
data$setting.factor = factor(data$setting,levels=c("1","2","3","4","5","6","7","9"))
data$setting_acuity.factor = factor(data$setting_acuity,levels=c("1","2","9"))
data$setting_acuity_type___1.factor = factor(data$setting_acuity_type___1,levels=c("0","1"))
data$setting_acuity_type___2.factor = factor(data$setting_acuity_type___2,levels=c("0","1"))
data$setting_acuity_type___3.factor = factor(data$setting_acuity_type___3,levels=c("0","1"))
data$setting_acuity_type___4.factor = factor(data$setting_acuity_type___4,levels=c("0","1"))
data$setting_acuity_type___7.factor = factor(data$setting_acuity_type___7,levels=c("0","1"))
data$setting_acuity_type___9.factor = factor(data$setting_acuity_type___9,levels=c("0","1"))
data$reason___1.factor = factor(data$reason___1,levels=c("0","1"))
data$reason___2.factor = factor(data$reason___2,levels=c("0","1"))
data$reason___3.factor = factor(data$reason___3,levels=c("0","1"))
data$intl_hosp.factor = factor(data$intl_hosp,levels=c("1","0"))
data$organism___1.factor = factor(data$organism___1,levels=c("0","1"))
data$organism___2.factor = factor(data$organism___2,levels=c("0","1"))
data$organism___3.factor = factor(data$organism___3,levels=c("0","1"))
data$organism___4.factor = factor(data$organism___4,levels=c("0","1"))
data$organism___5.factor = factor(data$organism___5,levels=c("0","1"))
data$organism___6.factor = factor(data$organism___6,levels=c("0","1"))
data$organism___7.factor = factor(data$organism___7,levels=c("0","1"))
data$organism___8.factor = factor(data$organism___8,levels=c("0","1"))
data$organism___9.factor = factor(data$organism___9,levels=c("0","1"))
data$organism___10.factor = factor(data$organism___10,levels=c("0","1"))
data$cpase___1.factor = factor(data$cpase___1,levels=c("0","1"))
data$cpase___2.factor = factor(data$cpase___2,levels=c("0","1"))
data$cpase___3.factor = factor(data$cpase___3,levels=c("0","1"))
data$cpase___4.factor = factor(data$cpase___4,levels=c("0","1"))
data$cpase___5.factor = factor(data$cpase___5,levels=c("0","1"))
data$cpase___6.factor = factor(data$cpase___6,levels=c("0","1"))
data$cpase___7.factor = factor(data$cpase___7,levels=c("0","1"))
data$cpase___0.factor = factor(data$cpase___0,levels=c("0","1"))
data$cpase___9.factor = factor(data$cpase___9,levels=c("0","1"))
data$pns.factor = factor(data$pns,levels=c("1","2"))
data$cp_ebp.factor = factor(data$cp_ebp,levels=c("1","0","9"))
data$index_lda___1.factor = factor(data$index_lda___1,levels=c("0","1"))
data$index_lda___2.factor = factor(data$index_lda___2,levels=c("0","1"))
data$index_lda___3.factor = factor(data$index_lda___3,levels=c("0","1"))
data$index_lda___4.factor = factor(data$index_lda___4,levels=c("0","1"))
data$index_lda___5.factor = factor(data$index_lda___5,levels=c("0","1"))
data$index_lda___6.factor = factor(data$index_lda___6,levels=c("0","1"))
data$index_lda___7.factor = factor(data$index_lda___7,levels=c("0","1"))
data$index_lda___0.factor = factor(data$index_lda___0,levels=c("0","1"))
data$index_lda___9.factor = factor(data$index_lda___9,levels=c("0","1"))
data$index_assist.factor = factor(data$index_assist,levels=c("1","2","3"))
data$index_commonareas.factor = factor(data$index_commonareas,levels=c("1","2","9"))
data$screen_type___1.factor = factor(data$screen_type___1,levels=c("0","1"))
data$screen_type___2.factor = factor(data$screen_type___2,levels=c("0","1"))
data$screen_type___3.factor = factor(data$screen_type___3,levels=c("0","1"))
data$screen_type___7.factor = factor(data$screen_type___7,levels=c("0","1"))
data$screen_type___9.factor = factor(data$screen_type___9,levels=c("0","1"))
data$pps_icu.factor = factor(data$pps_icu,levels=c("1","0","9"))
data$pps_acuity_type___1.factor = factor(data$pps_acuity_type___1,levels=c("0","1"))
data$pps_acuity_type___2.factor = factor(data$pps_acuity_type___2,levels=c("0","1"))
data$pps_acuity_type___3.factor = factor(data$pps_acuity_type___3,levels=c("0","1"))
data$pps_acuity_type___4.factor = factor(data$pps_acuity_type___4,levels=c("0","1"))
data$pps_acuity_type___7.factor = factor(data$pps_acuity_type___7,levels=c("0","1"))
data$pps_acuity_type___9.factor = factor(data$pps_acuity_type___9,levels=c("0","1"))
data$pps_admit.factor = factor(data$pps_admit,levels=c("1","2","3","0","9"))
data$adm_admit.factor = factor(data$adm_admit,levels=c("1","2","3","0","9"))
data$screening_abstraction_complete.factor = factor(data$screening_abstraction_complete,levels=c("0","1","2"))
data$case_organism___1.factor = factor(data$case_organism___1,levels=c("0","1"))
data$case_organism___2.factor = factor(data$case_organism___2,levels=c("0","1"))
data$case_organism___3.factor = factor(data$case_organism___3,levels=c("0","1"))
data$case_organism___4.factor = factor(data$case_organism___4,levels=c("0","1"))
data$case_organism___5.factor = factor(data$case_organism___5,levels=c("0","1"))
data$case_organism___6.factor = factor(data$case_organism___6,levels=c("0","1"))
data$case_organism___7.factor = factor(data$case_organism___7,levels=c("0","1"))
data$case_organism___8.factor = factor(data$case_organism___8,levels=c("0","1"))
data$case_organism___9.factor = factor(data$case_organism___9,levels=c("0","1"))
data$case_organism___10.factor = factor(data$case_organism___10,levels=c("0","1"))
data$case_cpase___1.factor = factor(data$case_cpase___1,levels=c("0","1"))
data$case_cpase___2.factor = factor(data$case_cpase___2,levels=c("0","1"))
data$case_cpase___3.factor = factor(data$case_cpase___3,levels=c("0","1"))
data$case_cpase___4.factor = factor(data$case_cpase___4,levels=c("0","1"))
data$case_cpase___5.factor = factor(data$case_cpase___5,levels=c("0","1"))
data$case_cpase___6.factor = factor(data$case_cpase___6,levels=c("0","1"))
data$case_cpase___7.factor = factor(data$case_cpase___7,levels=c("0","1"))
data$case_cpase___8.factor = factor(data$case_cpase___8,levels=c("0","1"))
data$case_cpase___9.factor = factor(data$case_cpase___9,levels=c("0","1"))
data$case_setting.factor = factor(data$case_setting,levels=c("1","2","3","4","5","6","7","9"))
data$case_acuity.factor = factor(data$case_acuity,levels=c("1","0"))
data$case_acuitytype.factor = factor(data$case_acuitytype,levels=c("1","2","3","4","7","9"))
data$case_reason.factor = factor(data$case_reason,levels=c("1","7","9"))
data$case_screentype.factor = factor(data$case_screentype,levels=c("1","2","3","9"))
data$case_link.factor = factor(data$case_link,levels=c("1","2","3","4","5","6","0","9"))
data$case_wgs.factor = factor(data$case_wgs,levels=c("1","2","0","9"))
data$case_tbp.factor = factor(data$case_tbp,levels=c("1","0","9"))
data$case_riskfactors___1.factor = factor(data$case_riskfactors___1,levels=c("0","1"))
data$case_riskfactors___2.factor = factor(data$case_riskfactors___2,levels=c("0","1"))
data$case_riskfactors___3.factor = factor(data$case_riskfactors___3,levels=c("0","1"))
data$case_riskfactors___4.factor = factor(data$case_riskfactors___4,levels=c("0","1"))
data$case_riskfactors___5.factor = factor(data$case_riskfactors___5,levels=c("0","1"))
data$case_riskfactors___6.factor = factor(data$case_riskfactors___6,levels=c("0","1"))
data$case_riskfactors___7.factor = factor(data$case_riskfactors___7,levels=c("0","1"))
data$case_riskfactors___0.factor = factor(data$case_riskfactors___0,levels=c("0","1"))
data$case_riskfactors___9.factor = factor(data$case_riskfactors___9,levels=c("0","1"))
data$case_assist.factor = factor(data$case_assist,levels=c("1","2","9"))
data$case_commonareas.factor = factor(data$case_commonareas,levels=c("1","2","9"))
data$case_abstraction_complete.factor = factor(data$case_abstraction_complete,levels=c("0","1","2"))

levels(data$redcap_repeat_instrument.factor)=c("Screening abstraction","Case abstraction")
levels(data$setting.factor)=c("Acute care hospital","Long-term acute care hospital","Ventilator-capable skilled nursing facility","Skilled nursing facility/nursing home","Assisted living facility/adult care home","Dialysis","Other","Unknown")
levels(data$setting_acuity.factor)=c("Yes","No","Unknown")
levels(data$setting_acuity_type___1.factor)=c("Unchecked","Checked")
levels(data$setting_acuity_type___2.factor)=c("Unchecked","Checked")
levels(data$setting_acuity_type___3.factor)=c("Unchecked","Checked")
levels(data$setting_acuity_type___4.factor)=c("Unchecked","Checked")
levels(data$setting_acuity_type___7.factor)=c("Unchecked","Checked")
levels(data$setting_acuity_type___9.factor)=c("Unchecked","Checked")
levels(data$reason___1.factor)=c("Unchecked","Checked")
levels(data$reason___2.factor)=c("Unchecked","Checked")
levels(data$reason___3.factor)=c("Unchecked","Checked")
levels(data$intl_hosp.factor)=c("Yes","No")
levels(data$organism___1.factor)=c("Unchecked","Checked")
levels(data$organism___2.factor)=c("Unchecked","Checked")
levels(data$organism___3.factor)=c("Unchecked","Checked")
levels(data$organism___4.factor)=c("Unchecked","Checked")
levels(data$organism___5.factor)=c("Unchecked","Checked")
levels(data$organism___6.factor)=c("Unchecked","Checked")
levels(data$organism___7.factor)=c("Unchecked","Checked")
levels(data$organism___8.factor)=c("Unchecked","Checked")
levels(data$organism___9.factor)=c("Unchecked","Checked")
levels(data$organism___10.factor)=c("Unchecked","Checked")
levels(data$cpase___1.factor)=c("Unchecked","Checked")
levels(data$cpase___2.factor)=c("Unchecked","Checked")
levels(data$cpase___3.factor)=c("Unchecked","Checked")
levels(data$cpase___4.factor)=c("Unchecked","Checked")
levels(data$cpase___5.factor)=c("Unchecked","Checked")
levels(data$cpase___6.factor)=c("Unchecked","Checked")
levels(data$cpase___7.factor)=c("Unchecked","Checked")
levels(data$cpase___0.factor)=c("Unchecked","Checked")
levels(data$cpase___9.factor)=c("Unchecked","Checked")
levels(data$pns.factor)=c("Yes","No")
levels(data$cp_ebp.factor)=c("Yes","No","Unknown")
levels(data$index_lda___1.factor)=c("Unchecked","Checked")
levels(data$index_lda___2.factor)=c("Unchecked","Checked")
levels(data$index_lda___3.factor)=c("Unchecked","Checked")
levels(data$index_lda___4.factor)=c("Unchecked","Checked")
levels(data$index_lda___5.factor)=c("Unchecked","Checked")
levels(data$index_lda___6.factor)=c("Unchecked","Checked")
levels(data$index_lda___7.factor)=c("Unchecked","Checked")
levels(data$index_lda___0.factor)=c("Unchecked","Checked")
levels(data$index_lda___9.factor)=c("Unchecked","Checked")
levels(data$index_assist.factor)=c("Patient needs assistance with ADLs/high contact care","Patient is completely ambulatory and does not need assistance with ADLs/high contact care","Unknown")
levels(data$index_commonareas.factor)=c("Yes","No, patient stays in room","Unknown")
levels(data$screen_type___1.factor)=c("Unchecked","Checked")
levels(data$screen_type___2.factor)=c("Unchecked","Checked")
levels(data$screen_type___3.factor)=c("Unchecked","Checked")
levels(data$screen_type___7.factor)=c("Unchecked","Checked")
levels(data$screen_type___9.factor)=c("Unchecked","Checked")
levels(data$pps_icu.factor)=c("Yes","No","Unknown")
levels(data$pps_acuity_type___1.factor)=c("Unchecked","Checked")
levels(data$pps_acuity_type___2.factor)=c("Unchecked","Checked")
levels(data$pps_acuity_type___3.factor)=c("Unchecked","Checked")
levels(data$pps_acuity_type___4.factor)=c("Unchecked","Checked")
levels(data$pps_acuity_type___7.factor)=c("Unchecked","Checked")
levels(data$pps_acuity_type___9.factor)=c("Unchecked","Checked")
levels(data$pps_admit.factor)=c("Yes - still admitted to one of the 1st PPS units","Yes - still admitted elsewhere in facility (not on one of the 1st PPS units)","Yes - still admitted, unknown which unit","No","Unknown")
levels(data$adm_admit.factor)=c("Yes - still admitted to the unit where contact(s) were screened","Yes - still admitted elsewhere in facility (different unit from where contacts screened)","Yes - still admitted, unknown which unit","No","Unknown")
levels(data$screening_abstraction_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$case_organism___1.factor)=c("Unchecked","Checked")
levels(data$case_organism___2.factor)=c("Unchecked","Checked")
levels(data$case_organism___3.factor)=c("Unchecked","Checked")
levels(data$case_organism___4.factor)=c("Unchecked","Checked")
levels(data$case_organism___5.factor)=c("Unchecked","Checked")
levels(data$case_organism___6.factor)=c("Unchecked","Checked")
levels(data$case_organism___7.factor)=c("Unchecked","Checked")
levels(data$case_organism___8.factor)=c("Unchecked","Checked")
levels(data$case_organism___9.factor)=c("Unchecked","Checked")
levels(data$case_organism___10.factor)=c("Unchecked","Checked")
levels(data$case_cpase___1.factor)=c("Unchecked","Checked")
levels(data$case_cpase___2.factor)=c("Unchecked","Checked")
levels(data$case_cpase___3.factor)=c("Unchecked","Checked")
levels(data$case_cpase___4.factor)=c("Unchecked","Checked")
levels(data$case_cpase___5.factor)=c("Unchecked","Checked")
levels(data$case_cpase___6.factor)=c("Unchecked","Checked")
levels(data$case_cpase___7.factor)=c("Unchecked","Checked")
levels(data$case_cpase___8.factor)=c("Unchecked","Checked")
levels(data$case_cpase___9.factor)=c("Unchecked","Checked")
levels(data$case_setting.factor)=c("Acute care hospital","Long-term acute care hospital","Ventilator-capable skilled nursing facility","Skilled nursing facility/nursing home","Assisted living facility/adult care home","Dialysis","Other","Unknown")
levels(data$case_acuity.factor)=c("Yes","No")
levels(data$case_acuitytype.factor)=c("ICU","Burn unit","Ventilator unit","Oncology unit","Other","Unknown")
levels(data$case_reason.factor)=c("Screening conducted in response to a MDRO case/outbreak","Other","Unknown")
levels(data$case_screentype.factor)=c("PPS on unit where index case resided","Identified as a contact, still admitted, screened immediately","Identified as a contact, already discharged, screened on readmission","Unknown")
levels(data$case_link.factor)=c("Roommate","On a unit where the index case resided, unknown if at the same time","On the same unit at the same time","On the same unit where the index case stayed, but not at the same time","In the same room as the index case after them","In the facility at the same time as the index case, but never on the same unit","No overlap in space or time","Unknown")
levels(data$case_wgs.factor)=c("Yes - confirmed related","Yes - confirmed NOT related","No","Unknown")
levels(data$case_tbp.factor)=c("Yes","No","Unknown")
levels(data$case_riskfactors___1.factor)=c("Unchecked","Checked")
levels(data$case_riskfactors___2.factor)=c("Unchecked","Checked")
levels(data$case_riskfactors___3.factor)=c("Unchecked","Checked")
levels(data$case_riskfactors___4.factor)=c("Unchecked","Checked")
levels(data$case_riskfactors___5.factor)=c("Unchecked","Checked")
levels(data$case_riskfactors___6.factor)=c("Unchecked","Checked")
levels(data$case_riskfactors___7.factor)=c("Unchecked","Checked")
levels(data$case_riskfactors___0.factor)=c("Unchecked","Checked")
levels(data$case_riskfactors___9.factor)=c("Unchecked","Checked")
levels(data$case_assist.factor)=c("Patient needs assistance with ADLs/high contact care","Patient is completely ambulatory and does not need assistance with ADLs/high contact care","Unknown")
levels(data$case_commonareas.factor)=c("Yes","No, patient stays in room","Unknown")
levels(data$case_abstraction_complete.factor)=c("Incomplete","Unverified","Complete")
