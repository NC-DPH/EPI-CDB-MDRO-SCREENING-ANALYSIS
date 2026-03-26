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
   /* datafile="T:\HAI\MDRO Surveillance\MDRO screening analysis\REDCap data back ups\MDROScreeningDataAna_DATA_Final.csv"*/
	
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
	index_commonareas,

	/*Some continuous variables*/

	mdro_date, /*date MDRO identified by positive specimen*/
	report_date, /*date reported to DHHS*/
	pps_date,/*date PPS initiated*/

	abs(mdro_date - report_date) as IDtoreport,
	abs(mdro_date - pps_date) as IDtoPPS,
	abs(report_date - pps_date) as reporttoPPS,

	/*time to event flags*/
	case when calculated IDtoPPS gt (30) then 1 else 0 end as IDtoPPS_flag,
	case when calculated reporttoPPS gt (30) then 1 else 0 end as reporttoPPS_flag

from MDRO_working
	where year GE (2023)
	order by screening_id
;
quit;

proc print data=MDRO_clean_1 noobs; var screening_id pps_num_p1 pps_num_total;where screening_id = '103906387 Durham C auris Duke June 2024';run;


/*Create singular labels defined by each series of variables in a category (simplify our tables): SCREENING SPECIFIC */
proc sql;
create table MDRO_clean_2_screenings as
select

	screening_id_new,
	screening_id,
	redcap_repeat_instrument,
	year,

	/*Positives flag*/
	case when (pps_num_p1) not in (0,.) and screening_id_new not in ('103906387') then 1 else 0 end as pos_result,

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

		/*Days from identification to report and pps initiated*/
		IDtoreport, IDtoPPS, reporttoPPS, IDtoPPS_flag, reporttoPPS_flag,
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


/*Ok you can do this in a SAS data step like below, but I'm a sucker for translateable code so I used SQL*/
/*SAS version:*/
/*data table_1_mechanisms;*/
/*    set MDRO_clean_2_screenings;*/
/**/
/*    length mechanism $20;*/
/**/
/*    if mech_kpc        = 'KPC'          then mechanism = 'KPC';*/
/*    else if mech_ndm   = 'NDM'          then mechanism = 'NDM';*/
/*    else if mech_oxa23_24 = 'OXA-23/24' then mechanism = 'OXA-23/24';*/
/*    else if mech_oxa_48   = 'OXA-48'    then mechanism = 'OXA-48';*/
/*    else if mech_vim   = 'VIM'          then mechanism = 'VIM';*/
/*    else if mech_imp   = 'IMP'          then mechanism = 'IMP';*/
/*    else if mech_other = 'Other'        then mechanism = 'Other';*/
/*    else if mech_none  = 'None (C.auris)' then mechanism = 'None (C. auris)';*/
/*    else if mech_unknown = 'Unknown'    then mechanism = 'Unknown';*/
/*    else delete;*/
/**/
/*    keep screening_id mechanism;*/
/*run;*/


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
				d.precautions,
				d.IDtoreport,
				d.IDtoPPS,
				d.reporttoPPS,
				d.IDtoPPS_flag,
				d.reporttoPPS_flag
			

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



title; footnote;
/*Set your output pathway here*/
ods excel file="T:\HAI\MDRO Surveillance\MDRO screening analysis\MDRO_analysis linelist_&sysdate..xlsx" style=pearl;
ods excel options (sheet_interval = "now" sheet_name = "line list" embedded_titles='Yes');


proc print data=MDRO_clean_2_screenings noobs;run;


ods excel close;




title; footnote;
/*Set your output pathway here*/
ods excel file="T:\HAI\MDRO Surveillance\MDRO screening analysis\MDRO_PPS_screenings_longpivot.xlsx" style=pearl;
ods excel options (sheet_interval = "now" sheet_name = "line list" embedded_titles='Yes');


proc print data=table_1_final_join noobs;run;


ods excel close;



/*Some modeling*/
/*take our final table and revert back to even level line*/
proc sort data=table_1_final_join  out=model_1 nodupkey ;

	by descending screening_id rf_groups hiacuity_hirf ;

run;


proc sql;
create table model_30day_viz as
select

	screening_id,
	pos_result,
	case when pos_result in (1) then 'Yes' else 'No' end as pos_result_char,
	organism_prompt,
	case when organism_prompt in ('CRAB (A. baumanii)') then 'CRAB' else 'Not CRAB' end as CRAB_flag "Causitive organism; CRAB (A. baumanii)",
	reporttoPPS "Report of MDRO to NCEDSS to PPS initiated",
	IDtoreport "Lab result positive for MDRO to report to NCEDSS",
	IDtoPPS "Lab result positive for MDRO to PPS initiated"

from model_1
;
create table analysis_30day as
select

	screening_id,
	pos_result,
	CRAB_flag,
	case when reporttoPPS GE (30) then 1 else 0 end as reporttoPPS_30flag,
	case when IDtoreport GE (30) then 1 else 0 end as IDtoreport_30flag,
	case when IDtoPPS GE (30) then 1 else 0 end as IDtoPPS_30flag

from model_30day_viz
	
;
quit;

proc print data=analysis_30day noobs;run;
/*Sort by CRAB yes/no*/
proc sort data=analysis_30day; by reporttoPPS_30flag;run;

/*Positive result based on 30+ days from time to report to PPS initiated, group by CRAB or not CRAB*/
proc freq data=analysis_30day;
tables pos_result*CRAB_flag / fisher norow nocol nopercent nocum expected;
	by reporttoPPS_30flag;

run;




proc logistic
data=analysis_30day descending;
	class pos_result (param=ref ref='0') reporttoPPS_30flag (param=ref ref='0') CRAB_flag (param=ref ref='Not CRAB') ;
	/*building our model using total risk factors*/
	model pos_result =  reporttoPPS_30flag CRAB_flag / expb ;
	oddsratio reporttoPPS_30flag;

		*where organism_prompt in ('CRAB (A. baumanii)');
run;




/*Obviously just use this...*/
ods output Summary=means_out;

proc means data=model_30day_viz mean median range q1 q3 p90 maxdec=2 ; class pos_result_char CRAB_flag;
var IDtoreport reporttoPPS IDtoPPS; 

run;

proc sql;
create table metrics_IDtoreport as
select

	pos_result_char "Screening resulted in additional positive(s)?",
	CRAB_flag, IDtoreport_Mean, IDtoreport_Median format 10.0, (IDtoreport_Q3 - IDtoreport_Q1) as IQR format 10.0, IDtoreport_Q1 "25th Percentile" format 10.0, IDtoreport_Q3 "75th Percentile" format 10.0, NObs "Count"

from means_out
	group by CRAB_flag, pos_result_char;


create table metrics_reporttoPPS as
select

	pos_result_char "Screening resulted in additional positive(s)?",
	CRAB_flag, reporttoPPS_Mean, reporttoPPS_Median format 10.0, (reporttoPPS_Q3 - reporttoPPS_Q1) as IQR format 10.0, reporttoPPS_Q1 "25th Percentile" format 10.0, reporttoPPS_Q3 "75th Percentile" format 10.0, NObs "Count"

from means_out
	group by CRAB_flag, pos_result_char;

create table metrics_IDtoPPS as
select

	pos_result_char "Screening resulted in additional positive(s)?",
	CRAB_flag, IDtoPPS_Mean, IDtoPPS_Median format 10.0, (IDtoPPS_Q3 - IDtoPPS_Q1) as IQR format 10.0, IDtoPPS_Q1 "25th Percentile" format 10.0, IDtoPPS_Q3 "75th Percentile" format 10.0, NObs "Count"

from means_out
	group by CRAB_flag, pos_result_char;

create table pos_rate_CRABnoCRAB as
select

	sum (case when pos_result in (1) and CRAB_flag in ('CRAB') then 1 else 0 end) as sum_pos_CRAB "Total result in positive organism: CRAB",
	sum (case when pos_result in (1,0) and CRAB_flag in ('CRAB') then 1 else 0 end) as total_CRAB "Total screenings organism: CRAB",
		(calculated sum_pos_CRAB / calculated total_CRAB) as pos_rate_CRAB format percent10.1 "Positivity rate, organism: CRAB",

	sum (case when pos_result in (1) and CRAB_flag in ('Not CRAB') then 1 else 0 end) as sum_pos_notCRAB "Total result in positive organism: Not CRAB",
	sum (case when pos_result in (1,0) and CRAB_flag in ('Not CRAB') then 1 else 0 end) as total_notCRAB "Total screenings organism: Not CRAB",
		(calculated sum_pos_notCRAB / calculated total_notCRAB) as pos_rate_noCRAB format percent10.1 "Positivity rate, organism: Not CRAB"

from analysis_30day
;

quit;

title justify=left height=8pt  'Positivity rate report to NCEDSS date to PPS initiated date, CRAB vs. Not CRAB';
proc print data=pos_rate_CRABnoCRAB noobs label;run;

title 'Metrics from lab ID date to state report date';
proc print data=metrics_IDtoreport noobs label;run;

title 'Metrics from state report date to PPS initiated date';
proc print data=metrics_reporttoPPS noobs label;run;

title 'Metrics from lab ID to PPS initiated date';
proc print data=metrics_IDtoPPS noobs label;run;


title 'Analysis CRAB vs. not CRAB and </> 30 days from report to PPS initiation';
/*Positive result based on 30+ days from time to report to PPS initiated, group by CRAB or not CRAB*/
proc freq data=analysis_30day;
tables pos_result*CRAB_flag / fisher norow nocol nopercent nocum expected;
	by reporttoPPS_30flag;

run;



%macro timetoevent_graph  (timetoevent=, eventlabel=);
ods graphics / noborder;
proc sgplot data=model_30day_viz noborder;
/*Set style and contrast colors to be uniform throughout, otherwise SAS will use that gross pale blue and yuk red*/
styleattrs datacolors=(cxA6CEE3 cx1F78B4)
datacontrastcolors=(cxA6CEE3 cx1F78B4);

/*Vbox statement: time to event by CRAB yes or no grouped by positivity*/
    vbox  &timetoevent / category=CRAB_flag group=pos_result_char
        fillattrs=(transparency=0.15)
        meanattrs=(symbol=circlefilled color=black size=8)
		medianattrs=(color=black pattern=dash thickness=2)
        whiskerattrs=(thickness=1)
		outlierattrs=(symbol=circlefilled size=6 color=red) /*Make outliers red*/
		lineattrs=(thickness=0)
			/*displaystats=(q1 q3 mean) abusrd that SAS doesn't support this with a group statement*/;

/*Labels and standardized text size so it doesn't look like a 4 year old drew it*/
    xaxis label="Organism (CRAB/not CRAB)" valueattrs= (family="Arial" size=8)
		labelattrs= (family="Arial" weight=bold size=8);

    yaxis min=0 max=80 label="&eventlabel" valueattrs= (family="Arial" size=8)
		labelattrs= (family="Arial" weight=bold size=8);


	keylegend / title="Screening resulted in Positive" location=outside position=bottom noborder titleattrs= (family="Arial" size=8 weight=bold) valueattrs= (family="Arial" size=8);


run;
%mend;



dm 'odsresults; clear';
/*ODS PDF output*/
ods graphics /noborder;
title; footnote;

/*Set your output pathway here*/ 
ods excel file="T:\HAI\MDRO Surveillance\MDRO screening analysis\MDRO screening_30 day trends_&sysdate..xlsx" ; *style=Journal;

ods excel options (sheet_interval = "none" sheet_name = "tables" embedded_titles='Yes');

title justify=left height=8pt 'Metrics from lab ID date to state report date';
proc print data=metrics_IDtoreport noobs label;run;

title justify=left height=8pt 'Metrics from state report date to PPS initiated date';
proc print data=metrics_reporttoPPS noobs label;run;

title justify=left height=8pt 'Metrics from lab ID to PPS initiated date';
proc print data=metrics_IDtoPPS noobs label;run;

title justify=left height=8pt  'Positivity rate report to NCEDSS date to PPS initiated date, CRAB vs. Not CRAB';
proc print data=pos_rate_CRABnoCRAB noobs label;run;




title;

ods excel options (sheet_interval = "now" sheet_name = "box charts" embedded_titles='Yes') style=HTMLBlue;

title justify=left color=black height=8pt 'Metrics from lab ID date to state report date';
%timetoevent_graph (timetoevent=IDtoreport, eventlabel=Days from MDRO lab identified to MDRO Reported);
title justify=left color=black height=8pt 'Metrics from state report date to PPS initiated date';
%timetoevent_graph (timetoevent=reporttoPPS, eventlabel=Days from MDRO reported to PPS initated);
title justify=left color=black height=8pt 'Metrics from lab ID to PPS initiated date';
%timetoevent_graph (timetoevent=IDtoPPS, eventlabel=Days from MDRO lab identified to PPS initated);



ods excel options (sheet_interval = "now" sheet_name = "CRAB analysis" embedded_titles='Yes') style=HTMLBlue;
/*Quick test to evaluate if CRAB as an organism results in a longer time to PPS response than non-CRAB from time of reporting to PPS initiation*/
proc npar1way data=model_30day_viz wilcoxon plots(only)=(normalboxplot scores=data);
title justify=left height=9pt"Nonparametric test to compare median time from NCEDSS reporting to PPS intiated among CRAB MDRO vs. non-CRAB MDRO";
title2 justify=left height=8pt "Rank sum independent samples (WMW), outlier removed";
	class CRAB_flag; /*yearly 90th percentile*/
	var reporttoPPS; /*Use the rate to account for some providers having many more patients ie. family practice more than dental surgery see Gouin et a. (2019)*/

			where reporttoPPS LT (60);

run;


ods excel options (sheet_interval = "now" sheet_name = "30 day analysis" embedded_titles='Yes') style=HTMLBlue;
title 'Analysis CRAB vs. not CRAB and </> 30 days from report to PPS initiation';
/*Positive result based on 30+ days from time to report to PPS initiated, group by CRAB or not CRAB*/
proc freq data=analysis_30day;
tables pos_result*CRAB_flag / fisher cmh norow nocol nopercent nocum expected;
	by reporttoPPS_30flag;

run;
ods excel close;















proc sort data=table_1_final_join out=model_30day_logit nodupkey ;

	by screening_id  ;

run;


proc logistic
data=model_30day_logit descending;
	class pos_result (param=ref ref='0') IDtoPPS_flag (param=ref ref='0') ;
	/*building our model using total risk factors*/
	model pos_result =  IDtoPPS_flag / expb ;
	oddsratio IDtoPPS_flag;

		*where organism_prompt in ('CRAB (A. baumanii)');
run;


proc print data=table_1_final_join; var screening_id mechanism pos_result IDtoPPS_flag;run;
