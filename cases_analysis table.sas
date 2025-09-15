/*
 *------------------------------------------------------------------------------
 * Program Name:  cases_analysis_table_20250903
 * Author:        Mikhail Hoskins
 * Date Created:  09/03/2025
 * Date Modified: 
 * Description:   Point prevelance screening analysis table for cases.
 *
 * Input:        MDROScreeningDataAna_DATA_Current.csv 
 * 				 T:\HAI\MDRO Surveillance\MDRO screening analysis\REDCap data back ups\
 * Output:       table_1 long pivot version for easy analysis
 *
 * Notes:    
 *
 *------------------------------------------------------------------------------
 */


/*clear all your other terrible results*/
dm 'odsresults; clear';
/*Set pathway for sas file output*/
libname mdropps 'C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap';

/*Import latest line list*/
proc import out=screening_raw
    datafile="T:\HAI\MDRO Surveillance\MDRO screening analysis\REDCap data back ups\MDROScreeningDataAna_DATA_Final_20250909.csv"
    dbms=csv
    replace;
    getnames=YES;
run;

proc contents data=screening_raw;run;
/*Keep only case abstractions and case variables*/
proc sql;
create table cases_screening as
select

	case_id,screening_id, redcap_repeat_instrument, redcap_repeat_instance,

	case_name, case_organism___1, case_organism___2, case_organism___3, case_organism___4, case_organism___5, case_organism___6, case_organism___7, 
	case_organism___8, case_organism___9, case_organism___10, case_organism_other, case_cpase___1, case_cpase___2, case_cpase___3, case_cpase___4, 
	case_cpase___5, case_cpase___6, case_cpase___7, case_cpase___8, case_cpase___9, case_cpase_other, case_setting, case_setting_other, case_acuity, 
	case_acuitytype, case_acuitytypeother, case_reason, case_reason_other, case_screentype, case_link, case_wgs, case_tbp, case_riskfactors___1,
	case_riskfactors___2, case_riskfactors___3, case_riskfactors___4, case_riskfactors___5, case_riskfactors___6, case_riskfactors___7,
	case_riskfactors___0, case_riskfactors___9, case_othermdro, case_assist, case_commonareas, case_notes, case_abstraction_complete 



	from screening_raw 
	where redcap_repeat_instrument in ('case_abstraction') and case_id not in (.)
;
quit;


/*Long pivot/denormalize the mechanism, cases can have more than one mechanism but fairly unlikely*/
proc sql;
create table table_1_pt1 as
select

	case_id,
	screening_id,
	'KPC' as mechanism 

from cases_screening 
	having case_cpase___1 =1 union all select

	case_id,
	screening_id,
	'NDM' as mechanism

from cases_screening 
	having case_cpase___2 =1 union all select

	case_id,
	screening_id,
	'OXA-23/24' as mechanism

from cases_screening 
	having case_cpase___3 =1 union all select

	case_id,
	screening_id,
	'OXA-48' as mechanism

from cases_screening 
	having case_cpase___4 =1 union all select

	case_id,
	screening_id,
	'VIM' as mechanism

from cases_screening 
	having case_cpase___5 =1 union all select

	case_id,
	screening_id,
	'IMP' as mechanism

from cases_screening 
	having case_cpase___6 =1 union all select

	case_id,
	screening_id,
	'Other' as mechanism

from cases_screening 
	having case_cpase___7 =1 union all select

	case_id,
	screening_id,
	'None (C. auris)' as mechanism

from cases_screening 
	having case_cpase___8 =1 union all select

	case_id,
	screening_id,
	'Unknown' as mechanism

from cases_screening 
	having case_cpase___9 =1
;
/*Add variables with a single value for each patient/case*/
create table table_1_pt2 as
select

	a.case_id,
	a.screening_id,
	a.mechanism,
	/*Add organism*/
	case when b.case_organism___1 in (1) then 'C. auris'
		 when b.case_organism___2 in (1) then 'E. coli'
		 when b.case_organism___3 in (1) then 'E. cloacae'
		 when b.case_organism___4 in (1) then 'E. aerogenes/K. aerogenes'
		 when b.case_organism___5 in (1) then 'K. pneumoniae'
		 when b.case_organism___6 in (1) then 'K. oxytoca'
		 when b.case_organism___7 in (1) then 'CRPA'
		 when b.case_organism___8 in (1) then 'CRAB'
		 when b.case_organism___9 in (1) then 'No organism identified'
		 when b.case_organism___10 in (1) then 'Other'
	else '' end as case_organism,

	/*Add case setting*/
	case when b.case_setting in (1) then 'Acute Care Hospital'
		 when b.case_setting in (2) then 'LTACH'
		 when b.case_setting in (3) then 'Ventilator-capable skilled nursing facility'
		 when b.case_setting in (4) then 'Skilled nursing facility/nursing home'
		 when b.case_setting in (5) then 'Assisted living facility/adult care home'
		 when b.case_setting in (6) then 'Dialysis'
		 when b.case_setting in (7) then 'Other'
		 when b.case_setting in (9) then 'Unknown'
	else '' end as case_setting_new,
	/*Add acuity*/
	case when b.case_acuity in ('1') then 'High Acuity' else '' end as acuity,
	/*Add screen type: there is only one screening type per case (not the same with screenings which could involve multiple types)*/
	case when case_screentype in (1) then 'PPS'
		 when case_screentype in (2) then 'Contact: initial admit.'
		 when case_screentype in (3) then 'Contact: readmission'
		 when case_screentype in (9) then 'Unknown'
	else '' end as screening_source,
	/*Add case link variable (again, one value per case). Best guess for epi link?*/
	case when case_link in (1) then 'Roommate'
		 when case_link in (2) then 'On a unit where the index case resided, unknown if at the same time'
		 when case_link in (3) then 'On the same unit at the same time'
		 when case_link in (4) then 'On the same unit where the index case stayed, but not at the same time'
		 when case_link in (5) then 'In the same room as the index case after them'
		 when case_link in (6) then 'In the facility at the same time as the index case, but never on the same unit'
		 when case_link in (0) then 'No overlap in space or time'
		 when case_link in (9) then 'Unknown'
	else '' end as case_link_new,
	/*Add WGS*/
	case when case_wgs in (1) then 'Yes - confirmed related'
		 when case_wgs in (2) then 'Yes - confirmed NOT related' 
		 when case_wgs in (0) then 'No'
		 when case_wgs in (9) then 'Unknown'
	else '' end as wholegenome,
	/*Add precautions*/
	case when case_tbp in (1) then 'Yes'
		 when case_tbp in (0) then 'No'
		 when case_tbp in (9) then 'Unknown'
	else '' end as precautions, 
	/*Add assistance need*/
	case when case_assist in (1) then 'Patient needs assistance with ADLs/high contact care'
		 when case_assist in (2) then 'Patient does not need assistance with ADLs/high contact care'
		 when case_assist in (9) then 'Unknown'
	else '' end as assist_lvl,
	/*Add common area yes/no*/
	case when case_commonareas in (1) then 'Yes - pt. in common areas'
		 when case_commonareas in (2) then 'No - pt. stays in room'
		 when case_commonareas in (3) then 'Unknown'
	else '' end as common_area

from table_1_pt1 a left join cases_screening b on a.case_id = b.case_id
;
/*create a long pivot/denormalized table for risk factors. Patients can have many risk factors we'll go from ~30 rows to >60 rows. 
  A case id can appear multiple times, once for each risk factor and/or mechanism.*/ 
create table table_1_rf as
select

	case_id,
	'Open/draining wounds' as riskfactor

from cases_screening 
	having case_riskfactors___1 =1 union all select

	case_id,
	'Endotracheal tube/Nasotracheal tube/Tracheostomy' as riskfactor

from cases_screening 
	having case_riskfactors___2 =1 union all select

	case_id,
	'Central lines (including PICCs)' as riskfactor

from cases_screening 
	having case_riskfactors___3 =1 union all select

	case_id,
	'Other indwelling devices' as riskfactor

from cases_screening 
	having case_riskfactors___4 =1 union all select

	case_id,
	'Immunocompromised' as riskfactor

from cases_screening 
	having case_riskfactors___5 =1 union all select

	case_id,
	'Diagnosed with other MDROs' as riskfactor

from cases_screening 
	having case_riskfactors___6 =1 union all select

	case_id,
	'International healthcare or travel' as riskfactor

from cases_screening 
	having case_riskfactors___7 =1 union all select

	case_id,
	'No risk factors documented' as riskfactor

from cases_screening 
	having case_riskfactors___0 =1 union all select

	case_id,
	'Unknown' as riskfactor

from cases_screening 
	having case_riskfactors___9 =1;

quit;

 
/*Final grouping of risk factors to case list*/
proc sql;
create table table_1_combine as
select

	a.*,
	b.riskfactor
	

from table_1_pt2 a right join table_1_rf b 
	on a.case_id = b.case_id
	order by case_id
;
quit;

/*Last tricky part, getting the number of risk factors for each case*/
proc sort data=table_1_combine out=rf_sort nodupkey;

	by case_id riskfactor;
run;


proc sql;
create table rf_groups as
select distinct

	case_ID,
	case when riskfactor not in ('No risk factors documented') then count(riskfactor) else 0 end as count_rf /*Count risk factors per case ID*/
	/*count(riskfactor) as count_rf*/

from rf_sort
	group by case_ID;
quit;

proc print data=rf_groups;run;
/*One last merge with the count of risk factors back to the long pivoted/denormalized table*/
proc sql;
create table table_1_final as
select

	a.*,
	b.count_rf
	

from table_1_combine a left join rf_groups b 
	on a.case_id = b.case_id
	order by case_id
;
quit;







/*Output twice as an excel and .sas7bdat for analysis*/
/*SAS Dataset output*/
data mdropps.MDRO_PPS_cases_longpivot;
	set table_1_final;
run;




/*Excel output*/
title; footnote;
/*Set your output pathway here*/
ods excel file="C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap\MDRO_PPS_cases_longpivot.xlsx";
ods excel options (sheet_interval = "now" sheet_name = "pps cases" embedded_titles='Yes');

	proc print data=table_1_final noobs label;where screening_source in ('PPS');run;*<----only PPS for now;

ods excel close;













/*Table validation*/












/*De duplicate for one-to-one variables. Just one value for each ID*/
proc sort data=table_1_final out=one_to_one_vars nodupkey;

	by case_ID case_organism case_setting_new acuity screening_source case_link_new	wholegenome	precautions	assist_lvl common_area;
run;

proc print data=one_to_one_vars; var case_id screening_source screening_id case_organism count_rf;run;
/*Table 1 for one-to-one variables*/
proc freq data=one_to_one_vars; 

tables case_organism case_setting_new acuity screening_source case_link_new wholegenome precautions	assist_lvl common_area 
/ norow nocol nocum;

run;

/*Table 1 for one-to-two variables (mechanism)*/
proc sort data=table_1_final out=one_to_two_vars nodupkey;

	by case_ID mechanism;
run;
/*And table for mechanism and risk factors where an ID can have many values*/
proc freq data=one_to_two_vars;

tables mechanism 
/ norow nocol nocum;

run;


/*Table 1 for one-to-many variables (riskfactor)*/
proc sort data=table_1_final out=one_to_many_vars;

	by case_ID riskfactor ;
run;
/*And table for mechanism and risk factors where an ID can have many values*/
proc freq data=one_to_many_vars;

tables riskfactor*case_ID 
/ norow nocol nocum;

run;
