/*
 *------------------------------------------------------------------------------
 * Program Name:  MDROScreeningDataAna_SAS_2025-03-27_1555
 * Author:        Mikhail Hoskins
 * Date Created:  03/27/2025
 * Date Modified: .
 * Description:   RedCap import and labels file.
 *
 * Input:        MDROScreeningDataAna_DATA_NOHDRS_2025-03-27_1725.csv : C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap
 * Output:       .
 *
 * Notes:       Follow RedCap instructions to download. (Basically just update the CSV file path in the first let statement). 
 *
 *------------------------------------------------------------------------------
 */




/* Edit the following line to reflect the full path to your CSV file */
%let csv_file = 'C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap\MDROScreeningDataAna_DATA_Current.csv';

OPTIONS nofmterr;

proc format;
	value $redcap_repeat_instrument_ 'screening_abstraction'='Screening abstraction' 'case_abstraction'='Case abstraction';
	value setting_ 1='Acute care hospital' 2='Long-term acute care hospital' 
		3='Ventilator-capable skilled nursing facility' 4='Skilled nursing facility/nursing home' 
		5='Assisted living facility/adult care home' 6='Dialysis' 
		7='Other' 9='Unknown';
	value setting_acuity_ 1='Yes' 2='No' 
		9='Unknown';
	value setting_acuity_type___1_ 0='Unchecked' 1='Checked';
	value setting_acuity_type___2_ 0='Unchecked' 1='Checked';
	value setting_acuity_type___3_ 0='Unchecked' 1='Checked';
	value setting_acuity_type___4_ 0='Unchecked' 1='Checked';
	value setting_acuity_type___7_ 0='Unchecked' 1='Checked';
	value setting_acuity_type___9_ 0='Unchecked' 1='Checked';
	value reason___1_ 0='Unchecked' 1='Checked';
	value reason___2_ 0='Unchecked' 1='Checked';
	value reason___3_ 0='Unchecked' 1='Checked';
	value intl_hosp_ 1='Yes' 0='No';
	value organism___1_ 0='Unchecked' 1='Checked';
	value organism___2_ 0='Unchecked' 1='Checked';
	value organism___3_ 0='Unchecked' 1='Checked';
	value organism___4_ 0='Unchecked' 1='Checked';
	value organism___5_ 0='Unchecked' 1='Checked';
	value organism___6_ 0='Unchecked' 1='Checked';
	value organism___7_ 0='Unchecked' 1='Checked';
	value organism___8_ 0='Unchecked' 1='Checked';
	value organism___9_ 0='Unchecked' 1='Checked';
	value organism___10_ 0='Unchecked' 1='Checked';
	value cpase___1_ 0='Unchecked' 1='Checked';
	value cpase___2_ 0='Unchecked' 1='Checked';
	value cpase___3_ 0='Unchecked' 1='Checked';
	value cpase___4_ 0='Unchecked' 1='Checked';
	value cpase___5_ 0='Unchecked' 1='Checked';
	value cpase___6_ 0='Unchecked' 1='Checked';
	value cpase___7_ 0='Unchecked' 1='Checked';
	value cpase___0_ 0='Unchecked' 1='Checked';
	value cpase___9_ 0='Unchecked' 1='Checked';
	value pns_ 1='Yes' 2='No';
	value cp_ebp_ 1='Yes' 0='No' 
		9='Unknown';
	value index_lda___1_ 0='Unchecked' 1='Checked';
	value index_lda___2_ 0='Unchecked' 1='Checked';
	value index_lda___3_ 0='Unchecked' 1='Checked';
	value index_lda___4_ 0='Unchecked' 1='Checked';
	value index_lda___5_ 0='Unchecked' 1='Checked';
	value index_lda___6_ 0='Unchecked' 1='Checked';
	value index_lda___7_ 0='Unchecked' 1='Checked';
	value index_lda___0_ 0='Unchecked' 1='Checked';
	value index_lda___9_ 0='Unchecked' 1='Checked';
	value index_assist_ 1='Patient needs assistance with ADLs/high contact care' 2='Patient is completely ambulatory and does not need assistance with ADLs/high contact care' 
		3='Unknown';
	value index_commonareas_ 1='Yes' 2='No, patient stays in room' 
		9='Unknown';
	value screen_type___1_ 0='Unchecked' 1='Checked';
	value screen_type___2_ 0='Unchecked' 1='Checked';
	value screen_type___3_ 0='Unchecked' 1='Checked';
	value screen_type___7_ 0='Unchecked' 1='Checked';
	value screen_type___9_ 0='Unchecked' 1='Checked';
	value pps_icu_ 1='Yes' 0='No' 
		9='Unknown';
	value pps_acuity_type___1_ 0='Unchecked' 1='Checked';
	value pps_acuity_type___2_ 0='Unchecked' 1='Checked';
	value pps_acuity_type___3_ 0='Unchecked' 1='Checked';
	value pps_acuity_type___4_ 0='Unchecked' 1='Checked';
	value pps_acuity_type___7_ 0='Unchecked' 1='Checked';
	value pps_acuity_type___9_ 0='Unchecked' 1='Checked';
	value pps_admit_ 1='Yes - still admitted to one of the 1st PPS units' 2='Yes - still admitted elsewhere in facility (not on one of the 1st PPS units)' 
		3='Yes - still admitted, unknown which unit' 0='No' 
		9='Unknown';
	value adm_admit_ 1='Yes - still admitted to the unit where contact(s) were screened' 2='Yes - still admitted elsewhere in facility (different unit from where contacts screened)' 
		3='Yes - still admitted, unknown which unit' 0='No' 
		9='Unknown';
	value screening_abstraction_complete_ 0='Incomplete' 1='Unverified' 
		2='Complete';
	value case_organism___1_ 0='Unchecked' 1='Checked';
	value case_organism___2_ 0='Unchecked' 1='Checked';
	value case_organism___3_ 0='Unchecked' 1='Checked';
	value case_organism___4_ 0='Unchecked' 1='Checked';
	value case_organism___5_ 0='Unchecked' 1='Checked';
	value case_organism___6_ 0='Unchecked' 1='Checked';
	value case_organism___7_ 0='Unchecked' 1='Checked';
	value case_organism___8_ 0='Unchecked' 1='Checked';
	value case_organism___9_ 0='Unchecked' 1='Checked';
	value case_organism___10_ 0='Unchecked' 1='Checked';
	value case_cpase___1_ 0='Unchecked' 1='Checked';
	value case_cpase___2_ 0='Unchecked' 1='Checked';
	value case_cpase___3_ 0='Unchecked' 1='Checked';
	value case_cpase___4_ 0='Unchecked' 1='Checked';
	value case_cpase___5_ 0='Unchecked' 1='Checked';
	value case_cpase___6_ 0='Unchecked' 1='Checked';
	value case_cpase___7_ 0='Unchecked' 1='Checked';
	value case_cpase___8_ 0='Unchecked' 1='Checked';
	value case_cpase___9_ 0='Unchecked' 1='Checked';
	value case_setting_ 1='Acute care hospital' 2='Long-term acute care hospital' 
		3='Ventilator-capable skilled nursing facility' 4='Skilled nursing facility/nursing home' 
		5='Assisted living facility/adult care home' 6='Dialysis' 
		7='Other' 9='Unknown';
	value case_acuity_ 1='Yes' 0='No';
	value case_acuitytype_ 1='ICU' 2='Burn unit' 
		3='Ventilator unit' 4='Oncology unit' 
		7='Other' 9='Unknown';
	value case_reason_ 1='Screening conducted in response to a MDRO case/outbreak' 7='Other' 
		9='Unknown';
	value case_screentype_ 1='PPS on unit where index case resided' 2='Identified as a contact, still admitted, screened immediately' 
		3='Identified as a contact, already discharged, screened on readmission' 9='Unknown';
	value case_link_ 1='Roommate' 2='On a unit where the index case resided, unknown if at the same time' 
		3='On the same unit at the same time' 4='On the same unit where the index case stayed, but not at the same time' 
		5='In the same room as the index case after them' 6='In the facility at the same time as the index case, but never on the same unit' 
		0='No overlap in space or time' 9='Unknown';
	value case_wgs_ 1='Yes - confirmed related' 2='Yes - confirmed NOT related' 
		0='No' 9='Unknown';
	value case_tbp_ 1='Yes' 0='No' 
		9='Unknown';
	value case_riskfactors___1_ 0='Unchecked' 1='Checked';
	value case_riskfactors___2_ 0='Unchecked' 1='Checked';
	value case_riskfactors___3_ 0='Unchecked' 1='Checked';
	value case_riskfactors___4_ 0='Unchecked' 1='Checked';
	value case_riskfactors___5_ 0='Unchecked' 1='Checked';
	value case_riskfactors___6_ 0='Unchecked' 1='Checked';
	value case_riskfactors___7_ 0='Unchecked' 1='Checked';
	value case_riskfactors___0_ 0='Unchecked' 1='Checked';
	value case_riskfactors___9_ 0='Unchecked' 1='Checked';
	value case_assist_ 1='Patient needs assistance with ADLs/high contact care' 2='Patient is completely ambulatory and does not need assistance with ADLs/high contact care' 
		9='Unknown';
	value case_commonareas_ 1='Yes' 2='No, patient stays in room' 
		9='Unknown';
	value case_abstraction_complete_ 0='Incomplete' 1='Unverified' 
		2='Complete';

	run;

data work.redcap; %let _EFIERR_ = 0;
infile &csv_file  delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=1 ;

	informat screening_id $500. ;
	informat redcap_repeat_instrument $500. ;
	informat redcap_repeat_instance best32. ;
	informat year best32. ;
	informat index_id $500. ;
	informat name $500. ;
	informat arln_id_1 $500. ;
	informat arln_id_2 $500. ;
	informat arln_id_3 $500. ;
	informat arln_id_4 $500. ;
	informat arln_id_5 $500. ;
	informat arln_id_6 $500. ;
	informat arln_id_7 $500. ;
	informat arln_id_8 $500. ;
	informat arln_id_9 $500. ;
	informat arln_id_10 $500. ;
	informat setting best32. ;
	informat setting_other $500. ;
	informat setting_acuity best32. ;
	informat setting_acuity_type___1 best32. ;
	informat setting_acuity_type___2 best32. ;
	informat setting_acuity_type___3 best32. ;
	informat setting_acuity_type___4 best32. ;
	informat setting_acuity_type___7 best32. ;
	informat setting_acuity_type___9 best32. ;
	informat setting_acuity_other $500. ;
	informat reason___1 best32. ;
	informat reason___2 best32. ;
	informat reason___3 best32. ;
	informat intl_hosp best32. ;
	informat organism___1 best32. ;
	informat organism___2 best32. ;
	informat organism___3 best32. ;
	informat organism___4 best32. ;
	informat organism___5 best32. ;
	informat organism___6 best32. ;
	informat organism___7 best32. ;
	informat organism___8 best32. ;
	informat organism___9 best32. ;
	informat organism___10 best32. ;
	informat organism_other $500. ;
	informat cpase___1 best32. ;
	informat cpase___2 best32. ;
	informat cpase___3 best32. ;
	informat cpase___4 best32. ;
	informat cpase___5 best32. ;
	informat cpase___6 best32. ;
	informat cpase___7 best32. ;
	informat cpase___0 best32. ;
	informat cpase___9 best32. ;
	informat cpase_other $500. ;
	informat pns best32. ;
	informat mdro_date yymmdd10. ;
	informat report_date yymmdd10. ;
	informat cp_ebp best32. ;
	informat index_lda___1 best32. ;
	informat index_lda___2 best32. ;
	informat index_lda___3 best32. ;
	informat index_lda___4 best32. ;
	informat index_lda___5 best32. ;
	informat index_lda___6 best32. ;
	informat index_lda___7 best32. ;
	informat index_lda___0 best32. ;
	informat index_lda___9 best32. ;
	informat index_mdro $500. ;
	informat index_assist best32. ;
	informat index_commonareas best32. ;
	informat screen_type___1 best32. ;
	informat screen_type___2 best32. ;
	informat screen_type___3 best32. ;
	informat screen_type___7 best32. ;
	informat screen_type___9 best32. ;
	informat pps_count best32. ;
	informat ppsonly_count best32. ;
	informat pps_date yymmdd10. ;
	informat pps_denom_p1 best32. ;
	informat pps_num_p1 best32. ;
	informat pps_totalpos_p1 best32. ;
	informat pps_denom_total best32. ;
	informat pps_num_total best32. ;
	informat pps_icu best32. ;
	informat pps_acuity_type___1 best32. ;
	informat pps_acuity_type___2 best32. ;
	informat pps_acuity_type___3 best32. ;
	informat pps_acuity_type___4 best32. ;
	informat pps_acuity_type___7 best32. ;
	informat pps_acuity_type___9 best32. ;
	informat pps_acuity_other $500. ;
	informat pps_list $5000. ;
	informat pps_admit best32. ;
	informat pps_dc_date yymmdd10. ;
	informat pps_refusal_p1 $500. ;
	informat pps_refusal_total $500. ;
	informat adm_criteria $5000. ;
	informat adm_total best32. ;
	informat adm_screeningcount best32. ;
	informat adm_date yymmdd10. ;
	informat adm_tested best32. ;
	informat adm_pos best32. ;
	informat adm_admit best32. ;
	informat readm_criteria $5000. ;
	informat readm_total best32. ;
	informat readm_date yymmdd10. ;
	informat readm_screened best32. ;
	informat readm_pos best32. ;
	informat other_unknown $5000. ;
	informat notes $5000. ;
	informat screening_abstraction_complete best32. ;
	informat case_id $500. ;
	informat case_name $500. ;
	informat case_organism___1 best32. ;
	informat case_organism___2 best32. ;
	informat case_organism___3 best32. ;
	informat case_organism___4 best32. ;
	informat case_organism___5 best32. ;
	informat case_organism___6 best32. ;
	informat case_organism___7 best32. ;
	informat case_organism___8 best32. ;
	informat case_organism___9 best32. ;
	informat case_organism___10 best32. ;
	informat case_organism_other $500. ;
	informat case_cpase___1 best32. ;
	informat case_cpase___2 best32. ;
	informat case_cpase___3 best32. ;
	informat case_cpase___4 best32. ;
	informat case_cpase___5 best32. ;
	informat case_cpase___6 best32. ;
	informat case_cpase___7 best32. ;
	informat case_cpase___8 best32. ;
	informat case_cpase___9 best32. ;
	informat case_cpase_other $500. ;
	informat case_setting best32. ;
	informat case_setting_other $500. ;
	informat case_acuity best32. ;
	informat case_acuitytype best32. ;
	informat case_acuitytypeother $500. ;
	informat case_reason best32. ;
	informat case_reason_other $5000. ;
	informat case_screentype best32. ;
	informat case_link best32. ;
	informat case_wgs best32. ;
	informat case_tbp best32. ;
	informat case_riskfactors___1 best32. ;
	informat case_riskfactors___2 best32. ;
	informat case_riskfactors___3 best32. ;
	informat case_riskfactors___4 best32. ;
	informat case_riskfactors___5 best32. ;
	informat case_riskfactors___6 best32. ;
	informat case_riskfactors___7 best32. ;
	informat case_riskfactors___0 best32. ;
	informat case_riskfactors___9 best32. ;
	informat case_othermdro $500. ;
	informat case_assist best32. ;
	informat case_commonareas best32. ;
	informat case_notes $5000. ;
	informat case_abstraction_complete best32. ;

	format screening_id $500. ;
	format redcap_repeat_instrument $500. ;
	format redcap_repeat_instance best12. ;
	format year best12. ;
	format index_id $500. ;
	format name $500. ;
	format arln_id_1 $500. ;
	format arln_id_2 $500. ;
	format arln_id_3 $500. ;
	format arln_id_4 $500. ;
	format arln_id_5 $500. ;
	format arln_id_6 $500. ;
	format arln_id_7 $500. ;
	format arln_id_8 $500. ;
	format arln_id_9 $500. ;
	format arln_id_10 $500. ;
	format setting best12. ;
	format setting_other $500. ;
	format setting_acuity best12. ;
	format setting_acuity_type___1 best12. ;
	format setting_acuity_type___2 best12. ;
	format setting_acuity_type___3 best12. ;
	format setting_acuity_type___4 best12. ;
	format setting_acuity_type___7 best12. ;
	format setting_acuity_type___9 best12. ;
	format setting_acuity_other $500. ;
	format reason___1 best12. ;
	format reason___2 best12. ;
	format reason___3 best12. ;
	format intl_hosp best12. ;
	format organism___1 best12. ;
	format organism___2 best12. ;
	format organism___3 best12. ;
	format organism___4 best12. ;
	format organism___5 best12. ;
	format organism___6 best12. ;
	format organism___7 best12. ;
	format organism___8 best12. ;
	format organism___9 best12. ;
	format organism___10 best12. ;
	format organism_other $500. ;
	format cpase___1 best12. ;
	format cpase___2 best12. ;
	format cpase___3 best12. ;
	format cpase___4 best12. ;
	format cpase___5 best12. ;
	format cpase___6 best12. ;
	format cpase___7 best12. ;
	format cpase___0 best12. ;
	format cpase___9 best12. ;
	format cpase_other $500. ;
	format pns best12. ;
	format mdro_date yymmdd10. ;
	format report_date yymmdd10. ;
	format cp_ebp best12. ;
	format index_lda___1 best12. ;
	format index_lda___2 best12. ;
	format index_lda___3 best12. ;
	format index_lda___4 best12. ;
	format index_lda___5 best12. ;
	format index_lda___6 best12. ;
	format index_lda___7 best12. ;
	format index_lda___0 best12. ;
	format index_lda___9 best12. ;
	format index_mdro $500. ;
	format index_assist best12. ;
	format index_commonareas best12. ;
	format screen_type___1 best12. ;
	format screen_type___2 best12. ;
	format screen_type___3 best12. ;
	format screen_type___7 best12. ;
	format screen_type___9 best12. ;
	format pps_count best12. ;
	format ppsonly_count best12. ;
	format pps_date yymmdd10. ;
	format pps_denom_p1 best12. ;
	format pps_num_p1 best12. ;
	format pps_totalpos_p1 best12. ;
	format pps_denom_total best12. ;
	format pps_num_total best12. ;
	format pps_icu best12. ;
	format pps_acuity_type___1 best12. ;
	format pps_acuity_type___2 best12. ;
	format pps_acuity_type___3 best12. ;
	format pps_acuity_type___4 best12. ;
	format pps_acuity_type___7 best12. ;
	format pps_acuity_type___9 best12. ;
	format pps_acuity_other $500. ;
	format pps_list $5000. ;
	format pps_admit best12. ;
	format pps_dc_date yymmdd10. ;
	format pps_refusal_p1 $500. ;
	format pps_refusal_total $500. ;
	format adm_criteria $5000. ;
	format adm_total best12. ;
	format adm_screeningcount best12. ;
	format adm_date yymmdd10. ;
	format adm_tested best12. ;
	format adm_pos best12. ;
	format adm_admit best12. ;
	format readm_criteria $5000. ;
	format readm_total best12. ;
	format readm_date yymmdd10. ;
	format readm_screened best12. ;
	format readm_pos best12. ;
	format other_unknown $5000. ;
	format notes $5000. ;
	format screening_abstraction_complete best12. ;
	format case_id $500. ;
	format case_name $500. ;
	format case_organism___1 best12. ;
	format case_organism___2 best12. ;
	format case_organism___3 best12. ;
	format case_organism___4 best12. ;
	format case_organism___5 best12. ;
	format case_organism___6 best12. ;
	format case_organism___7 best12. ;
	format case_organism___8 best12. ;
	format case_organism___9 best12. ;
	format case_organism___10 best12. ;
	format case_organism_other $500. ;
	format case_cpase___1 best12. ;
	format case_cpase___2 best12. ;
	format case_cpase___3 best12. ;
	format case_cpase___4 best12. ;
	format case_cpase___5 best12. ;
	format case_cpase___6 best12. ;
	format case_cpase___7 best12. ;
	format case_cpase___8 best12. ;
	format case_cpase___9 best12. ;
	format case_cpase_other $500. ;
	format case_setting best12. ;
	format case_setting_other $500. ;
	format case_acuity best12. ;
	format case_acuitytype best12. ;
	format case_acuitytypeother $500. ;
	format case_reason best12. ;
	format case_reason_other $5000. ;
	format case_screentype best12. ;
	format case_link best12. ;
	format case_wgs best12. ;
	format case_tbp best12. ;
	format case_riskfactors___1 best12. ;
	format case_riskfactors___2 best12. ;
	format case_riskfactors___3 best12. ;
	format case_riskfactors___4 best12. ;
	format case_riskfactors___5 best12. ;
	format case_riskfactors___6 best12. ;
	format case_riskfactors___7 best12. ;
	format case_riskfactors___0 best12. ;
	format case_riskfactors___9 best12. ;
	format case_othermdro $500. ;
	format case_assist best12. ;
	format case_commonareas best12. ;
	format case_notes $5000. ;
	format case_abstraction_complete best12. ;

input
	screening_id $
	redcap_repeat_instrument $
	redcap_repeat_instance
	year
	index_id $
	name $
	arln_id_1 $
	arln_id_2 $
	arln_id_3 $
	arln_id_4 $
	arln_id_5 $
	arln_id_6 $
	arln_id_7 $
	arln_id_8 $
	arln_id_9 $
	arln_id_10 $
	setting
	setting_other $
	setting_acuity
	setting_acuity_type___1
	setting_acuity_type___2
	setting_acuity_type___3
	setting_acuity_type___4
	setting_acuity_type___7
	setting_acuity_type___9
	setting_acuity_other $
	reason___1
	reason___2
	reason___3
	intl_hosp
	organism___1
	organism___2
	organism___3
	organism___4
	organism___5
	organism___6
	organism___7
	organism___8
	organism___9
	organism___10
	organism_other $
	cpase___1
	cpase___2
	cpase___3
	cpase___4
	cpase___5
	cpase___6
	cpase___7
	cpase___0
	cpase___9
	cpase_other $
	pns
	mdro_date
	report_date
	cp_ebp
	index_lda___1
	index_lda___2
	index_lda___3
	index_lda___4
	index_lda___5
	index_lda___6
	index_lda___7
	index_lda___0
	index_lda___9
	index_mdro $
	index_assist
	index_commonareas
	screen_type___1
	screen_type___2
	screen_type___3
	screen_type___7
	screen_type___9
	pps_count
	ppsonly_count
	pps_date
	pps_denom_p1
	pps_num_p1
	pps_totalpos_p1
	pps_denom_total
	pps_num_total
	pps_icu
	pps_acuity_type___1
	pps_acuity_type___2
	pps_acuity_type___3
	pps_acuity_type___4
	pps_acuity_type___7
	pps_acuity_type___9
	pps_acuity_other $
	pps_list $
	pps_admit
	pps_dc_date
	pps_refusal_p1 $
	pps_refusal_total $
	adm_criteria $
	adm_total
	adm_screeningcount
	adm_date
	adm_tested
	adm_pos
	adm_admit
	readm_criteria $
	readm_total
	readm_date
	readm_screened
	readm_pos
	other_unknown $
	notes $
	screening_abstraction_complete
	case_id $
	case_name $
	case_organism___1
	case_organism___2
	case_organism___3
	case_organism___4
	case_organism___5
	case_organism___6
	case_organism___7
	case_organism___8
	case_organism___9
	case_organism___10
	case_organism_other $
	case_cpase___1
	case_cpase___2
	case_cpase___3
	case_cpase___4
	case_cpase___5
	case_cpase___6
	case_cpase___7
	case_cpase___8
	case_cpase___9
	case_cpase_other $
	case_setting
	case_setting_other $
	case_acuity
	case_acuitytype
	case_acuitytypeother $
	case_reason
	case_reason_other $
	case_screentype
	case_link
	case_wgs
	case_tbp
	case_riskfactors___1
	case_riskfactors___2
	case_riskfactors___3
	case_riskfactors___4
	case_riskfactors___5
	case_riskfactors___6
	case_riskfactors___7
	case_riskfactors___0
	case_riskfactors___9
	case_othermdro $
	case_assist
	case_commonareas
	case_notes $
	case_abstraction_complete
;
if _ERROR_ then call symput('_EFIERR_',"1");
run;

proc contents;run;

data redcap;
	set redcap;
	label screening_id='Screening ID';
	label redcap_repeat_instrument='Repeat Instrument';
	label redcap_repeat_instance='Repeat Instance';
	label year='Year of screening';
	label index_id='Index case event ID';
	label name='Abstractor name';
	label arln_id_1='Additional screening IDs (e.g., ARLN IDs)';
	label arln_id_2='Additional screening IDs (e.g., ARLN IDs)';
	label arln_id_3='Additional screening IDs (e.g., ARLN IDs)';
	label arln_id_4='Additional screening IDs (e.g., ARLN IDs)';
	label arln_id_5='Additional screening IDs (e.g., ARLN IDs)';
	label arln_id_6='Additional screening IDs (e.g., ARLN IDs)';
	label arln_id_7='Additional screening IDs (e.g., ARLN IDs)';
	label arln_id_8='Additional screening IDs (e.g., ARLN IDs)';
	label arln_id_9='Additional screening IDs (e.g., ARLN IDs)';
	label arln_id_10='Additional screening IDs (e.g., ARLN IDs)';
	label setting='1. In which setting did screening occur? ';
	label setting_other='1a. Other setting';
	label setting_acuity='2. Was the index case on a high acuity unit such as an ICU, burn unit, ventilator unit, or oncology unit?';
	label setting_acuity_type___1='2a. What type of high acuity unit? (choice=ICU)';
	label setting_acuity_type___2='2a. What type of high acuity unit? (choice=Burn unit)';
	label setting_acuity_type___3='2a. What type of high acuity unit? (choice=Ventilator unit)';
	label setting_acuity_type___4='2a. What type of high acuity unit? (choice=Oncology unit)';
	label setting_acuity_type___7='2a. What type of high acuity unit? (choice=Other)';
	label setting_acuity_type___9='2a. What type of high acuity unit? (choice=Unknown)';
	label setting_acuity_other='2b. Other type of high acuity setting';
	label reason___1='3. What was the reason for screening? (check all that apply) (choice=Identified MDRO case)';
	label reason___2='3. What was the reason for screening? (check all that apply) (choice=Preventative PPS in LTACH or vSNF (as part of a specific initiative beginning in 2023). *Skip to screening activities question and select PPS.)';
	label reason___3='3. What was the reason for screening? (check all that apply) (choice=Other (*Explain reason for screening in Notes section at bottom of this form.))';
	label intl_hosp='4. Was the index case identified by admission screening due to a history of international hospitalization or healthcare?';
	label organism___1='5. Which organism(s) prompted the response?  (choice=C. auris)';
	label organism___2='5. Which organism(s) prompted the response?  (choice=E. coli)';
	label organism___3='5. Which organism(s) prompted the response?  (choice=E. cloacae)';
	label organism___4='5. Which organism(s) prompted the response?  (choice=E. aerogenes/K. aerogenes)';
	label organism___5='5. Which organism(s) prompted the response?  (choice=K. pneumoniae)';
	label organism___6='5. Which organism(s) prompted the response?  (choice=K. oxytoca)';
	label organism___7='5. Which organism(s) prompted the response?  (choice=CRPA)';
	label organism___8='5. Which organism(s) prompted the response?  (choice=CRAB)';
	label organism___9='5. Which organism(s) prompted the response?  (choice=No organism identified)';
	label organism___10='5. Which organism(s) prompted the response?  (choice=Other)';
	label organism_other='5a. Other organism(s):';
	label cpase___1='6. Which carbapenemase(s) prompted the response?  (choice=KPC)';
	label cpase___2='6. Which carbapenemase(s) prompted the response?  (choice=NDM)';
	label cpase___3='6. Which carbapenemase(s) prompted the response?  (choice=OXA-23/24)';
	label cpase___4='6. Which carbapenemase(s) prompted the response?  (choice=OXA-48)';
	label cpase___5='6. Which carbapenemase(s) prompted the response?  (choice=VIM)';
	label cpase___6='6. Which carbapenemase(s) prompted the response?  (choice=IMP)';
	label cpase___7='6. Which carbapenemase(s) prompted the response?  (choice=Other)';
	label cpase___0='6. Which carbapenemase(s) prompted the response?  (choice=None)';
	label cpase___9='6. Which carbapenemase(s) prompted the response?  (choice=Unknown)';
	label cpase_other='6a. Other carbapenemase(s):';
	label pns='7. Is the organism pan non-susceptible (PNS)?';
	label mdro_date='8. What was the collection date for the first positive lab for the index case?';
	label report_date='9. What date was the MDRO first reported to public health?';
	label cp_ebp='10. Was the index case on contact or enhanced barrier precautions for their ENTIRE healthcare stay, including before being diagnosed with the MDRO? ';
	label index_lda___1='11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Open/draining wounds)';
	label index_lda___2='11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Endotracheal tube/Nasotracheal tube/Tracheostomy)';
	label index_lda___3='11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Central lines (including PICCs))';
	label index_lda___4='11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Other indwelling devices (dialysis catheter, urinary catheter, G tube or NG tube, nephrostomy tube, surgical drain. do not include ostomy.))';
	label index_lda___5='11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Immunocompromised)';
	label index_lda___6='11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Diagnosed with other MDROs (around the same time or prior to the MDRO that triggered screening))';
	label index_lda___7='11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=International healthcare or travel)';
	label index_lda___0='11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=None of the above risk factors are documented)';
	label index_lda___9='11. Do any of the following risk factors apply to the index case? Select all that apply. (choice=Unknown- there is no documentation in NCEDSS or notes to inform any selection)';
	label index_mdro='11a. What other MDROs does the index case have?';
	label index_assist='12. Does the index patient need assistance with ADLs/receive high contact care?';
	label index_commonareas='13. Has the index patient used common areas (such as rehab room, ambulate in hallway, activity room, etc)?';
	label screen_type___1='14. What screening activities occurred? Select all that apply. (choice=Point prevalence survey (PPS) (test all patients/residents currently on a unit))';
	label screen_type___2='14. What screening activities occurred? Select all that apply. (choice=Identify contacts and screen those still admitted)';
	label screen_type___3='14. What screening activities occurred? Select all that apply. (choice=Flag contacts for screening on readmission)';
	label screen_type___7='14. What screening activities occurred? Select all that apply. (choice=Other)';
	label screen_type___9='14. What screening activities occurred? Select all that apply. (choice=Unknown)';
	label pps_count='15. How many total PPSs were conducted (at this facility, in reponse to the index case carbapenemase/organism)?';
	label ppsonly_count='16. How many screenings were PPS only?';
	label pps_date='17. What date was the first PPS performed? ';
	label pps_denom_p1='18. How many people were tested during the first PPS? (number of swabs collected)';
	label pps_num_p1='19. How many people tested positive during the first PPS, for thesame carbapenemase/organism as the index case?';
	label pps_totalpos_p1='20. How many total people tested positive during the first PPS, for any carbapenemase or C. auris?';
	label pps_denom_total='21. How many total tests were conducted across all PPSs? (number of swabs collected)';
	label pps_num_total='22. How many screening cases were identified across all PPSs?';
	label pps_icu='23. Were any of the units screened a high acuity unit, such as an ICU, burn unit, ventilator unit, or oncology unit ? ';
	label pps_acuity_type___1='23a. What type of high acuity unit? (choice=ICU)';
	label pps_acuity_type___2='23a. What type of high acuity unit? (choice=Burn unit)';
	label pps_acuity_type___3='23a. What type of high acuity unit? (choice=Ventilator unit)';
	label pps_acuity_type___4='23a. What type of high acuity unit? (choice=Oncology unit)';
	label pps_acuity_type___7='23a. What type of high acuity unit? (choice=Other)';
	label pps_acuity_type___9='23a. What type of high acuity unit? (choice=Unknown)';
	label pps_acuity_other='23b. Other type of high acuity setting';
	label pps_list='24. Please list the ARLN screening ID, facility type, date, number screened, number positives, and what units were screened for all PPSs in this facility type. For screenings including high acuity units, please break the numbers out by unit if available. ';
	label pps_admit='25. Was the index case still admitted to the facility at the time of the first PPS? ';
	label pps_dc_date='25a. What date was the index case discharged?';
	label pps_refusal_p1='26. If available: How many patients refused screening during the first screening? ';
	label pps_refusal_total='27. If available: How many patients refused screening during all screenings combined? ';
	label adm_criteria='28. How were contacts defined? Please document this if information is readily available. If unknown, leave blank.';
	label adm_total='29. How many total contacts were identified?';
	label adm_screeningcount='30. How many total screeningsat this facility included screening contacts (as opposed to being only a PPS)?';
	label adm_date='31. What date was the first contact-based screening?';
	label adm_tested='32. How many total contacts  were screened? ';
	label adm_pos='33. How many were positive?';
	label adm_admit='34. Was the index case still admitted to the facility at the time of the first contact-based screening?';
	label readm_criteria='35. How were contacts defined? Please document this if information is readily available. If unknown, leave blank.';
	label readm_total='36. How many total contacts were identified who had already been discharged?';
	label readm_date='37. What date was the first readmitted contact screened?';
	label readm_screened='38. How many total contacts were screened on readmission?';
	label readm_pos='39. How many contacts tested positive on readmission?';
	label other_unknown='14a. If other/unknown, please provide all available info on the screening, including date, number tested, number positive, and who was screened. ';
	label notes='40. Notes (optional)';
	label screening_abstraction_complete='Complete?';
	label case_id='NC EDSS event ID(s)';
	label case_name='Abstractor name';
	label case_organism___1='C1. Which organism(s) did the person test positive for during screening? (choice=C. auris)';
	label case_organism___2='C1. Which organism(s) did the person test positive for during screening? (choice=E. coli)';
	label case_organism___3='C1. Which organism(s) did the person test positive for during screening? (choice=E. cloacae)';
	label case_organism___4='C1. Which organism(s) did the person test positive for during screening? (choice=E. aerogenes/K. aerogenes)';
	label case_organism___5='C1. Which organism(s) did the person test positive for during screening? (choice=K. pneumoniae)';
	label case_organism___6='C1. Which organism(s) did the person test positive for during screening? (choice=K. oxytoca)';
	label case_organism___7='C1. Which organism(s) did the person test positive for during screening? (choice=CRPA)';
	label case_organism___8='C1. Which organism(s) did the person test positive for during screening? (choice=CRAB)';
	label case_organism___9='C1. Which organism(s) did the person test positive for during screening? (choice=No organism identified)';
	label case_organism___10='C1. Which organism(s) did the person test positive for during screening? (choice=Other)';
	label case_organism_other='C1a. Other organism:';
	label case_cpase___1='C2. Which carbapenemase(s) did the person test positive for during screening? (choice=KPC)';
	label case_cpase___2='C2. Which carbapenemase(s) did the person test positive for during screening? (choice=NDM)';
	label case_cpase___3='C2. Which carbapenemase(s) did the person test positive for during screening? (choice=OXA-23/24)';
	label case_cpase___4='C2. Which carbapenemase(s) did the person test positive for during screening? (choice=OXA-48)';
	label case_cpase___5='C2. Which carbapenemase(s) did the person test positive for during screening? (choice=VIM)';
	label case_cpase___6='C2. Which carbapenemase(s) did the person test positive for during screening? (choice=IMP)';
	label case_cpase___7='C2. Which carbapenemase(s) did the person test positive for during screening? (choice=Other)';
	label case_cpase___8='C2. Which carbapenemase(s) did the person test positive for during screening? (choice=None)';
	label case_cpase___9='C2. Which carbapenemase(s) did the person test positive for during screening? (choice=Unknown)';
	label case_cpase_other='C2a. Other carbapenemase: ';
	label case_setting='C3. In which setting was the case screened?';
	label case_setting_other='C3a. Other setting:';
	label case_acuity='C4. Was the positive residing on a high acuity unit, such as an ICU, burn unit, ventilator unit, or oncology unit?';
	label case_acuitytype='C4a. What type of high acuity setting?';
	label case_acuitytypeother='C4b. Other type of high acuity setting';
	label case_reason='C5. Why was the person screened? ';
	label case_reason_other='C5a. Please provide all available information about the reason for screening.';
	label case_screentype='C6. Which of the following best describes this screening?';
	label case_link='C7. Which of the following best describes the epi link between the index case and the screening case?';
	label case_wgs='C8. Has whole genome sequencing been conducted on this patient and the index case?';
	label case_tbp='C9. Was this person on transmission-based precautions for their ENTIRE healthcare stay (including before being diagnosed)?';
	label case_riskfactors___1='C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Open/draining wounds)';
	label case_riskfactors___2='C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Endotracheal tube/Nasotracheal tube/Tracheostomy)';
	label case_riskfactors___3='C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Central lines (including PICCs))';
	label case_riskfactors___4='C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Other indwelling devices (dialysis catheter, urinary catheter, G tube or NG tube, nephrostomy tube, surgical drain. do not include ostomy))';
	label case_riskfactors___5='C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Immunocompromised)';
	label case_riskfactors___6='C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Diagnosed with other MDROs (around the same time or prior to the MDRO that triggered screening))';
	label case_riskfactors___7='C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=International healthcare or travel)';
	label case_riskfactors___0='C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=None of the above risk factors are documented)';
	label case_riskfactors___9='C10. Do any of the following risk factors apply to the screening case during their current hospitalization/healthcare stay? Select all that apply. (choice=Unknown- there is no documentation in NCEDSS or notes to inform any selection)';
	label case_othermdro='C10a. What other MDRO(s) does the patient have?';
	label case_assist='C11. Does the screening case need assistance with ADLs/receive high contact care?';
	label case_commonareas='C12. Has the screening case used common areas (such as rehab room, ambulate in hallway, activity room, etc)?';
	label case_notes='C13. Notes (optional)';
	label case_abstraction_complete='Complete?';

	format redcap_repeat_instrument redcap_repeat_instrument_.;
	format setting setting_.;
	format setting_acuity setting_acuity_.;
	format setting_acuity_type___1 setting_acuity_type___1_.;
	format setting_acuity_type___2 setting_acuity_type___2_.;
	format setting_acuity_type___3 setting_acuity_type___3_.;
	format setting_acuity_type___4 setting_acuity_type___4_.;
	format setting_acuity_type___7 setting_acuity_type___7_.;
	format setting_acuity_type___9 setting_acuity_type___9_.;
	format reason___1 reason___1_.;
	format reason___2 reason___2_.;
	format reason___3 reason___3_.;
	format intl_hosp intl_hosp_.;
	format organism___1 organism___1_.;
	format organism___2 organism___2_.;
	format organism___3 organism___3_.;
	format organism___4 organism___4_.;
	format organism___5 organism___5_.;
	format organism___6 organism___6_.;
	format organism___7 organism___7_.;
	format organism___8 organism___8_.;
	format organism___9 organism___9_.;
	format organism___10 organism___10_.;
	format cpase___1 cpase___1_.;
	format cpase___2 cpase___2_.;
	format cpase___3 cpase___3_.;
	format cpase___4 cpase___4_.;
	format cpase___5 cpase___5_.;
	format cpase___6 cpase___6_.;
	format cpase___7 cpase___7_.;
	format cpase___0 cpase___0_.;
	format cpase___9 cpase___9_.;
	format pns pns_.;
	format cp_ebp cp_ebp_.;
	format index_lda___1 index_lda___1_.;
	format index_lda___2 index_lda___2_.;
	format index_lda___3 index_lda___3_.;
	format index_lda___4 index_lda___4_.;
	format index_lda___5 index_lda___5_.;
	format index_lda___6 index_lda___6_.;
	format index_lda___7 index_lda___7_.;
	format index_lda___0 index_lda___0_.;
	format index_lda___9 index_lda___9_.;
	format index_assist index_assist_.;
	format index_commonareas index_commonareas_.;
	format screen_type___1 screen_type___1_.;
	format screen_type___2 screen_type___2_.;
	format screen_type___3 screen_type___3_.;
	format screen_type___7 screen_type___7_.;
	format screen_type___9 screen_type___9_.;
	format pps_icu pps_icu_.;
	format pps_acuity_type___1 pps_acuity_type___1_.;
	format pps_acuity_type___2 pps_acuity_type___2_.;
	format pps_acuity_type___3 pps_acuity_type___3_.;
	format pps_acuity_type___4 pps_acuity_type___4_.;
	format pps_acuity_type___7 pps_acuity_type___7_.;
	format pps_acuity_type___9 pps_acuity_type___9_.;
	format pps_admit pps_admit_.;
	format adm_admit adm_admit_.;
	format screening_abstraction_complete screening_abstraction_complete_.;
	format case_organism___1 case_organism___1_.;
	format case_organism___2 case_organism___2_.;
	format case_organism___3 case_organism___3_.;
	format case_organism___4 case_organism___4_.;
	format case_organism___5 case_organism___5_.;
	format case_organism___6 case_organism___6_.;
	format case_organism___7 case_organism___7_.;
	format case_organism___8 case_organism___8_.;
	format case_organism___9 case_organism___9_.;
	format case_organism___10 case_organism___10_.;
	format case_cpase___1 case_cpase___1_.;
	format case_cpase___2 case_cpase___2_.;
	format case_cpase___3 case_cpase___3_.;
	format case_cpase___4 case_cpase___4_.;
	format case_cpase___5 case_cpase___5_.;
	format case_cpase___6 case_cpase___6_.;
	format case_cpase___7 case_cpase___7_.;
	format case_cpase___8 case_cpase___8_.;
	format case_cpase___9 case_cpase___9_.;
	format case_setting case_setting_.;
	format case_acuity case_acuity_.;
	format case_acuitytype case_acuitytype_.;
	format case_reason case_reason_.;
	format case_screentype case_screentype_.;
	format case_link case_link_.;
	format case_wgs case_wgs_.;
	format case_tbp case_tbp_.;
	format case_riskfactors___1 case_riskfactors___1_.;
	format case_riskfactors___2 case_riskfactors___2_.;
	format case_riskfactors___3 case_riskfactors___3_.;
	format case_riskfactors___4 case_riskfactors___4_.;
	format case_riskfactors___5 case_riskfactors___5_.;
	format case_riskfactors___6 case_riskfactors___6_.;
	format case_riskfactors___7 case_riskfactors___7_.;
	format case_riskfactors___0 case_riskfactors___0_.;
	format case_riskfactors___9 case_riskfactors___9_.;
	format case_assist case_assist_.;
	format case_commonareas case_commonareas_.;
	format case_abstraction_complete case_abstraction_complete_.;
run;

proc contents data=redcap;
proc print data=redcap;
run;



libname import "C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap";
data import.MDRO_PPS_20250425;
set redcap;
run;
