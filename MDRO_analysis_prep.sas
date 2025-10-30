/*
 *------------------------------------------------------------------------------
 * Program Name:  MDRO_PPS_20250327
 * Author:        Mikhail Hoskins
 * Date Created:  04/15/2025
 * Date Modified: 10/29/2025
 * Description:   Point prevelance screening extract, cleaning, and analysis.
 *
 * Input:        Final version of screening abstractions : T:\HAI\MDRO Surveillance\MDRO screening analysis\REDCap data back ups\MDROScreeningDataAna_DATA_Final.csv
 * Outputs:      i.  MDRO_clean_2_screenings; for analysis summary table at the screening level, no duplicates.
 *				 ii. table_1_final_join; long tidy version for tables in R (visually more appealing). Denormalized, may have duplicates. 
 *
 * Notes:       
 *				10/29/2025: rewrote large chunks to create a longtidy version for R table 1. Analysis table for OR's (idk what else to use as of now). 
 *			
 *
 *------------------------------------------------------------------------------
 */


/*Create working file*/

/*clear all your other terrible results*/
dm 'odsresults; clear';

/*Import latest line list*/
proc import out=screening_raw
    datafile="T:\HAI\MDRO Surveillance\MDRO screening analysis\REDCap data back ups\MDROScreeningDataAna_DATA_Final.csv"
    dbms=csv
    replace;
    getnames=YES;
run;

data MDRO_working;
	set screening_raw;
		if screening_id = "screening_id" then delete;
		if screening_id = "123" then delete;

run;

/*Strip the screening ID to just the number*/
data MDRO_working;
set MDRO_working;

	screening_id_new = substr(screening_id, 1, 9);

run;
 proc contents data=screening_raw order=varnum;run;
proc print data=MDRO_working label; run; title;

/*Keep a set of variables -- add/take away as necessary*/
proc sql;
create table MDRO_clean_1 as
select
		screening_id,
		screening_id_new,
		redcap_repeat_instrument,
		case_id,
		index_mdro,
		setting,
		pps_num_p1,
		pps_num_total,
		pps_denom_p1,
		pps_denom_total,
		year,


	/*organism identified*/
	case_organism___1,
	case_organism___2,
	case_organism___3,
	case_organism___4,
	case_organism___5,
	case_organism___6,
	case_organism___7,
	case_organism___8,
	case_organism___9,
	case_organism___10,
	case_organism_other,

	/*index case organism*/
	organism___1,
	organism___2,
	organism___3,
	organism___4,
	organism___5,
	organism___6,
	organism___7,
	organism___8,
	organism___9,
	organism___10,
	organism_other,

	/*organism prompting screening*/
	cpase___1,
	cpase___2,
	cpase___3,
	cpase___4,
	cpase___5,
	cpase___6,
	cpase___7,
	cpase___9,
	cpase___0,

	/*setting*/
	setting_other,
	setting_acuity,
	setting_acuity_type___1,
	setting_acuity_type___2,
	setting_acuity_type___3,
	setting_acuity_type___4,
	setting_acuity_type___7,
	setting_acuity_type___9,
	setting_acuity_other,

	/*Screening Type*/
	screen_type___1,
	screen_type___2,
	screen_type___3,
	screen_type___7,
	screen_type___9,
		
	/*Screening type flags*/
	case when screen_type___1 in (1) then 1 else 0 end as pps_flag,
	case when screen_type___2 in (1) then 1 else 0 end as contact_flag,
	case when screen_type___3 in (1) then 1 else 0 end as ptchartflag_flag,

	/*Index case risk factors*/
	index_lda___1,
	index_lda___2,
	index_lda___3,
	index_lda___4,
	index_lda___5,
	index_lda___6,
	index_lda___7,
	index_lda___0,
	index_lda___9,
	/*Index case precautions*/
	cp_ebp,

	/*More index case factors*/
	index_assist,
	index_commonareas


from MDRO_working
	where year GE (2023)
	order by screening_id
;
quit;

proc freq data=MDRO_clean_1; tables pps_flag/ norow nocol nopercent;run;


/*Create singular labels defined by each series of variables in a category (simplify our tables): SCREENING SPECIFIC */
proc sql;
create table MDRO_clean_2_screenings as
select

	screening_id_new,
	screening_id,
	redcap_repeat_instrument,
	year,

	/*Positives flag*/
	case when (pps_num_total) not in (0,.) and screening_id_new not in ('103906387') then 1 else 0 end as pos_result,

	/*Index organism*/
	/*Group organism response into one variable*/
	case when organism___1 in (1) then "C. auris" 
		 when organism___2 in (1) then "E. Coli"
		 when organism___3 in (1) then "E. cloacae"
		 when organism___4 in (1) then "E. aerogenes/K. aerogenes" 
		 when organism___5 in (1) then "K. pneumoniae" 
		 when organism___6 in (1) then "K. oxytoca"
		 when organism___7 in (1) then "CRPA (P.aeruginosa)"
		 when organism___8 in (1) then "CRAB (A. baumanii)"
		 when organism___9 in (1) then "No organism identified"
		 when organism___10 in (1) then "Other"

			else '' end as organism_prompt "Which Organism prompted the response?",

	/*Rename mechanisms to names*/
	case when cpase___0 in (1) then 'None (C.auris)' else '' end as mech_none,
	case when cpase___1 in (1) then 'KPC' else '' end as mech_kpc,
	case when cpase___2 in (1) then 'NDM' else '' end as mech_ndm,
	case when cpase___3 in (1) then 'OXA-23/24' else '' end as mech_oxa23_24,
	case when cpase___4 in (1) then 'OXA-48' else '' end as mech_oxa_48,
	case when cpase___5 in (1) then 'VIM' else '' end as mech_vim,
	case when cpase___6 in (1) then 'IMP' else '' end as mech_imp,
	case when cpase___7 in (1) then 'Other' else '' end as mech_other,
	case when cpase___9 in (1) then 'Unknown' else '' end as mech_unknown,

	/*Setting*/
	case when setting in (1) then 'Acute Care Hospital' 
		 when setting in (2) then 'Long-term Acute Care Hospital'
		 when setting in (3) then 'Ventilator-capable Skilled Nursing Facility'
		 when setting in (4) then 'Skilled Nursing Facility/Nursing Home'
		 when setting in (5) then 'Assisted Living Facility/Adult Care Home'

		 	else '' end as setting_class,

	/*Acuity*/
	case when setting_acuity in (1) then "High Acuity" /*high acuity*/
		 when setting_acuity in (2) then "Low Acuity" /*low acuity*/

				else "Unknown/Missing" end as acuity_new,

	case when setting_acuity_type___1 in (1) then 'Intensive Care Unit' else '' end as hiacuity_icu,
	case when setting_acuity_type___2 in (1) then 'Burn Unit' else '' end as hiacuity_burn,
	case when setting_acuity_type___3 in (1) then 'Ventilator Unit' else '' end as hiacuity_vent,
	case when setting_acuity_type___4 in (1) then 'Oncology Unit' else '' end as hiacuity_onc,
	case when setting_acuity_type___7 in (1) then 'Other' else '' end as hiacuity_oth,
	case when setting_acuity_type___9 in (1) then 'Unknown' else '' end as hiacuity_unkmiss,
	case when setting_other not in ('') then setting_other else '' end as other_type,

	/*Precautions*/
	case when cp_ebp in (1) then 'Yes'
		 when cp_ebp in (9) then 'Unknown' 
			else 'No' end as precautions,

	case when index_lda___1 in (1) then 'Open/draining Wound' else '' end as wound,
		case when index_lda___2 in (1) then 'Endotracheal tube/Nasotracheal tube/Tracheostomy' else '' end as endo,
		case when index_lda___3 in (1) then 'Central lines (including PICCs)' else '' end as cenline,
		case when index_lda___4 in (1) then 'Other indwelling devices' else '' end as othindwell,
		case when index_lda___5 in (1) then 'Immunocompromised' else '' end as immuno,
		case when index_lda___6 in (1) then 'Diagnosed with other MDROs' else '' end as priorMDRO,
		case when index_lda___7 in (1) then 'History of international travel or hospitalization' else '' end as trav,
		case when index_lda___0 in (1) then 'No risk factors identified' else '' end as none,
		case when index_lda___9 in (1) then 'Missing/Unknown' else '' end as miss,

		/*Screening counts*/
		pps_num_p1,
		pps_num_total,
		pps_denom_p1,
		pps_denom_total







from MDRO_clean_1
where redcap_repeat_instrument in ('screening_abstraction') and pps_flag in (1) 
/*where year in (2024) Define year here, merge later will align with year*/

	order by screening_id_new;

quit;


proc freq data=MDRO_clean_2_screenings; tables organism_prompt /norow nocol nopercent nocum; where pos_result in (1);*where screening_id_new in ('103906387');run;

proc sql;
/*PART I: Mechanisms*/
create table table_1_mechanisms as
select

	screening_id,
	'KPC' as mechanism 

from MDRO_clean_2_screenings 
	having mech_kpc ='KPC' union all select

	screening_id,
	'NDM' as mechanism

from MDRO_clean_2_screenings 
	having mech_ndm ='NDM' union all select

	screening_id,
	'OXA-23/24' as mechanism

from MDRO_clean_2_screenings 
	having mech_oxa23_24 ='OXA-23/24' union all select

	screening_id,
	'OXA-48' as mechanism

from MDRO_clean_2_screenings 
	having mech_oxa_48 ='OXA-48' union all select

	screening_id,
	'VIM' as mechanism

from MDRO_clean_2_screenings 
	having mech_vim ='VIM' union all select

	screening_id,
	'IMP' as mechanism

from MDRO_clean_2_screenings 
	having mech_imp ='IMP' union all select

	screening_id,
	'Other' as mechanism

from MDRO_clean_2_screenings 
	having mech_other ='Other' union all select

	screening_id,
	'None (C. auris)' as mechanism

from MDRO_clean_2_screenings 
	having mech_none ='None (C.auris)' union all select

	screening_id,
	'Unknown' as mechanism

from MDRO_clean_2_screenings 
	having mech_unknown ='Unknown'
;

/*PART II: Risk Factors
wound endo cenline othindwell immuno priorMDRO trav none miss */

create table table_1_riskfactors as
select

	screening_id,
	'Open/draining wounds' as riskfactor

from MDRO_clean_2_screenings 
	having wound ='Open/draining Wound' union all select

	screening_id,
	'Endotracheal tube/Nasotracheal tube/Tracheostomy' as riskfactor

from MDRO_clean_2_screenings 
	having endo ='Endotracheal tube/Nasotracheal tube/Tracheostomy' union all select

	screening_id,
	'Central lines (including PICCs)' as riskfactor

from MDRO_clean_2_screenings 
	having cenline ='Central lines (including PICCs)' union all select

	screening_id,
	'Other indwelling devices' as riskfactor

from MDRO_clean_2_screenings 
	having othindwell ='Other indwelling devices' union all select

	screening_id,
	'Immunocompromised' as riskfactor

from MDRO_clean_2_screenings 
	having immuno ='Immunocompromised' union all select

	screening_id,
	'Diagnosed with other MDROs' as riskfactor

from MDRO_clean_2_screenings 
	having priorMDRO ='Diagnosed with other MDROs' union all select

	screening_id,
	'International healthcare or travel' as riskfactor

from MDRO_clean_2_screenings 
	having trav ='History of international travel or hospitalization' union all select

	screening_id,
	'No risk factors documented' as riskfactor

from MDRO_clean_2_screenings 
	having none ='No risk factors identified' union all select

	screening_id,
	'Unknown' as riskfactor

from MDRO_clean_2_screenings 
	having miss ='Missing/Unknown';
/*hiacuity_icu hiacuity_burn hiacuity_vent hiacuity_onc hiacuity_oth hiacuity_unkmiss other_type */

create table table_1_acuity as
select

	screening_id,
	'Intensive Care Unit' as hiacuitysetting

from MDRO_clean_2_screenings 
	having hiacuity_icu ='Intensive Care Unit' union all select

	screening_id,
	'Burn Unit' as hiacuitysetting

from MDRO_clean_2_screenings 
	having hiacuity_burn ='Burn Unit' union all select

	screening_id,
	'Ventilator Unit' as hiacuitysetting

from MDRO_clean_2_screenings 
	having hiacuity_vent ='Ventilator Unit' union all select

	screening_id,
	'Oncology Unit' as hiacuitysetting

from MDRO_clean_2_screenings 
	having hiacuity_onc ='Oncology Unit' union all select

	screening_id,
	'Other' as hiacuitysetting

from MDRO_clean_2_screenings 
	having hiacuity_oth ='Other'
;

create table table_1_joins as
select 

	a.screening_id,
	a.mechanism,
		b.riskfactor,
			c.hiacuitysetting,
				d.setting_class,
				d.acuity_new,
				d.year,
				d.pos_result,
				d.organism_prompt,
				d.precautions
			

from table_1_mechanisms a left join table_1_riskfactors b
	on a.screening_id = b.screening_id 
left join table_1_acuity c on a.screening_id = c.screening_id

left join MDRO_clean_2_screenings d on a.screening_id = d.screening_id
	order by a.screening_id
;

create table table_1_newvars as
select distinct

	screening_id,

	case when riskfactor not in ('No risk factors documented', 'Unknown') then count(distinct riskfactor) 
		 when riskfactor in ('No risk factors documented') then 0 

			else . end as count_rf, /*Count risk factors per case ID*/

	case when calculated count_rf in (0) then '0'
		 when calculated count_rf in (1) then '1'
		 when calculated count_rf in (2) then '2'
		 when calculated count_rf in (3,4,5) then '3+'

		 	else '' end as rf_groups,


		case when acuity_new in ('High Acuity') or calculated rf_groups not in ('0','1','' ) then 'Yes' else 'No' end 
		as hiacuity_hirf

from table_1_joins
	group by screening_id;

/*Merge back with longtidy table*/
create table table_1_final_join as
select

	a.*,
		b.count_rf,
		b.rf_groups,
		b.hiacuity_hirf

from table_1_joins a left join table_1_newvars b
	on a.screening_id = b.screening_id
;


quit;




proc print data=table_1_final_join noobs; run;





title; footnote;
/*Set your output pathway here*/
ods excel file="C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap\MDRO_analysis linelist_&sysdate..xlsx" style=pearl;
ods excel options (sheet_interval = "now" sheet_name = "line list" embedded_titles='Yes');


proc print data=MDRO_clean_2_screenings noobs;run;


ods excel close;




title; footnote;
/*Set your output pathway here*/
ods excel file="C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap\MDRO_PPS_screenings_longpivot.xlsx" style=pearl;
ods excel options (sheet_interval = "now" sheet_name = "line list" embedded_titles='Yes');


proc print data=table_1_final_join noobs;run;


ods excel close;



proc freq data=MDRO_clean_2_screenings; tables precautions /norow nocol nopercent;run;











/*Some modeling*/
proc logistic

data=MDRO_clean_2_screenings descending outmodel=model_PPS;

	class pos_result (param=ref ref='0') total_rf (param=ref ref='0');
	/*building our model using total risk factors, acutiy level, and specific risk factors*/
	model pos_result = total_rf acuity_new wound endo cenline othindwell immuno	priorMDRO trav none	miss / expb;

run;



/*KEY PIECE: Now we're going to use our model we created and apply it to each row with "score." The logistic formula logit (prob) = intercept + B1Var1 + B2Var2 + BnVarn will be applied to each row. Where B is the parameter and Var is the presence or category of the variable*/
proc logistic inmodel=model_PPS;

	score data=MDRO_clean_2_screenings out=mdro_pps_score  ;

run;
proc contents data=mdro_pps_score;run;


proc print data=mdro_pps_score; var screening_id_new P_1;run;



proc sql;
create table test_sir_mdro as
select

	P_1 as mdro_pred_total "Total MDRO Predicted from PPS" format 10.2,
	pos_result as mdro_act_total "Total MDRO Observed from PPS" format 10.0

from mdro_pps_score
;

create table pps_mdro_Final as
select

	mdro_pred_total,
	mdro_act_total,

	mdro_act_total / mdro_pred_total as yield_ratio "Yield ratio actual:predicted",
	(STDERR(calculated yield_ratio)) as std_err "Standard error"

from test_sir_mdro
;

create table pps_mdro_final_2 as
select

	sum (mdro_act_total) as act_total "Total MDRO Observed from PPS" format 10.0,
	sum (mdro_pred_total) as pred_total "Total MDRO Predicted from PPS" format 10.2,
		calculated act_total / calculated pred_total as yield_ratio_total "Yield ratio actual:predicted" format 10.2,

	
	max(std_err) as std_err_calc "Standard error",
		(calculated yield_ratio_total - (1.96*(calculated std_err_calc))) as lCL "Lower confidence limit" format 10.2,
		(calculated yield_ratio_total + (1.96*(calculated std_err_calc))) as uCL "Upper confidence limit" format 10.2,

		/*Add interpretation*/
	case when calculated yield_ratio_total GE 1 and 1 < calculated lCL then "PPS returned MORE positives than expected"
		 when calculated yield_ratio_total GE 1 and calculated uCL < 1 then "PPS returned LESS positives than expected"

	else "PPS returned the SAME positives than expected" end as interp "Interpretion for PPS NC 2023-2025"



from pps_mdro_final
;
alter table pps_mdro_final_2 drop std_err_calc;
quit;

dm 'odsresults; clear';
proc print data=pps_mdro_final_2 noobs label;run;
