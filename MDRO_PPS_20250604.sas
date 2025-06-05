/*
 *------------------------------------------------------------------------------
 * Program Name:  MDRO_PPS_20250327
 * Author:        Mikhail Hoskins
 * Date Created:  04/15/2025
 * Date Modified: 06/04/2025
 * Description:   Point prevelance screening extract, cleaning, and analysis.
 *
 * Input:        mdro_pps_20250425.sas7bdat : C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap
 * Output:       C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap\screening_breakdown_21MAY25.xlsx
 *
 * Notes:       Follow RedCap instructions to download. Save a raw file and create a working file (done below) for analysis.
 *				Confine to 2024 moving forward.
 *				i. 			Define if screening is actually PPS. Some may be contact screening NOT PPS. 
 *				ii.			2024 only.
 *				Edits 5/21/25. Improved tables and added denominator values (total screened). Added output describing screenings resulting
 *				in cases and screenings NOT resulting in cases. Basically a table 1. 
 *			
 *
 *------------------------------------------------------------------------------
 */


/*Create working file*/
libname import "C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap";

data MDRO_working;
	set import.mdro_pps_20250425;
		if screening_id = "screening_id" then delete;
		if screening_id = "123" then delete;

run;


/*Strip the screening ID to just the number*/
data MDRO_working;
set MDRO_working;

	screening_id_new = substr(screening_id, 1, 9);

run;
 
proc contents data=MDRO_working order=varnum;run;

title; footnote;
/*Set your output pathway here*/
ods excel file="C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap\screening_raw_&sysdate..xlsx";

title justify=left height=10pt font='Helvetica' "Screening Summary - 2024";
ods excel options (sheet_interval = "none" sheet_name = "summary table" embedded_titles='Yes');
proc print data=MDRO_working noobs label;run;

ods excel close;







/*Keep a set of variables -- add/take away as necessary*/
proc sql;
create table MDRO_clean_1 as
select
		screening_id,
		screening_id_new,
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

	/*case risk factors*/
	case_riskfactors___1,
	case_riskfactors___2,
	case_riskfactors___3,
	case_riskfactors___4,
	case_riskfactors___5,
	case_riskfactors___6,
	case_riskfactors___7,
	case_riskfactors___0,
	case_riskfactors___9


from MDRO_working
	order by screening_id
;
quit;


/*Create singular labels defined by each series of variables in a category (simplify our tables): SCREENING SPECIFIC */
proc sql;
create table MDRO_clean_2_screenings as
select

	screening_id_new,
	screening_id,
	year,
	/*case when case_id not in ('') then 1 else 0 end as MDRO_identified 'MDRO Identified from screening',*/
	index_mdro,
	setting,
	/*how many screenings/postives did we get*/
		pps_num_p1,
		pps_num_total,
		pps_denom_p1,
		pps_denom_total,

	case when cpase___0 in (1) then 'None'
		 when cpase___1 in (1) then 'KPC'
		 when cpase___2 in (1) then 'NDM'
		 when cpase___3 in (1) then 'OXA-23/24'
		 when cpase___4 in (1) then 'OXA-48'
		 when cpase___5 in (1) then 'VIM'
		 when cpase___6 in (1) then 'IMP'
		 when cpase___7 in (1) then 'Other'
		 when cpase___9 in (1) then 'Unknown'

	else '' end as prompt_scrn "Which carbapenemase(s) prompted the response?",

	case when setting_acuity_type___1 in (1) then 'ICU'
		 when setting_acuity_type___2 in (1) then 'Burn'
		 when setting_acuity_type___3 in (1) then 'Ventilator unit'
		 when setting_acuity_type___4 in (1) then 'Oncology unit'
		 when setting_acuity_type___7 in (1) then 'Other'
		 when setting_acuity_type___9 in (1) then 'Unknown'
		 when setting_other not in ('') then setting_other
		 
	else '' end as setting_scrn "In what type of high acuity unit was the screening conducted?"


from MDRO_clean_1
where year in (2024) /*Define year here, merge later will align with year*/
having case_id in ('')

	order by screening_id_new;

quit;



/*Create singular labels defined by each series of variables in a category: CASE SPECIFIC*/
proc sql;
create table MDRO_case_identified as
select

	screening_id_new,
	screening_id,
	case_id,
	index_mdro,

	/*case when case_id not in ('') then 1 else 0 end as MDRO_identified 'MDRO Identified from screening',*/

	case when case_organism___1 in (1) then 'C.auris'
		 when case_organism___2 in (1) then 'E. coli'
		 when case_organism___3 in (1) then 'E. cloacae'
		 when case_organism___4 in (1) then 'E. aerogenes/K. aerogenes'
		 when case_organism___5 in (1) then 'K. pneumoniae'
		 when case_organism___6 in (1) then 'K. oxytoca'
		 when case_organism___7 in (1) then 'CRPA'
		 when case_organism___8 in (1) then 'CRAB'
		 when case_organism___9 in (1) then 'No organism identified'
		 when case_organism___10 in (1) then 'Other'
		 when case_organism_other not in ('') then case_organism_other

	else '' end as organism "Which organism(s) prompted the screening?",

	case when calculated organism in (' ') then 0 else 1 end as MDRO_identified,

	
/*Risk factors (make numeric for analysis)*/
	case when case_riskfactors___1 in (1) then 1 else 0 end as risk_wound,
	case when case_riskfactors___2 in (1) then 1 else 0 end as risk_trach,
	case when case_riskfactors___3 in (1) then 1 else 0 end as risk_CL,
	case when case_riskfactors___4 in (1) then 1 else 0 end as risk_indwell,
	case when case_riskfactors___5 in (1) then 1 else 0 end as risk_immuno,
	case when case_riskfactors___6 in (1) then 1 else 0 end as risk_mdro,
	case when case_riskfactors___7 in (1) then 1 else 0 end as risk_trav,
	case when case_riskfactors___0 in (1) then 1 else 0 end as risk_none,
	case when case_riskfactors___9 in (1) then 1 else 0 end as risk_unk


from MDRO_clean_1
having case_ID not in ('')
	order by screening_id_new;
	
quit;

proc sql;
create table MDRO_case_year as
select

	b.screening_id_new,
	b.screening_id, 
	a.year,
	b.case_ID, b.index_mdro, b.organism, b.MDRO_identified, 

	b.risk_wound,
	b.risk_trach,
	b.risk_CL,
	b.risk_indwell,
	b.risk_immuno,
	b.risk_mdro,
	b.risk_trav,
	b.risk_none,
	b.risk_unk
	

from MDRO_clean_2_screenings a right join MDRO_case_identified b
	on a.screening_id_new = b.screening_id_new
;
quit;


/*Join screening and case specific fields*/
proc sql; 
create table join_screening_case as
select

	case when b.case_id not in ('') then 1 else 0 end as MDRO_identified,
	case when a.pps_num_p1 GT 0 then 1 else 0 end as MDRO_identified_2,
	a.*,
	b.case_id, b.screening_id_new, b.screening_id_new as screening_id_2, b.organism, b.risk_wound, b.risk_trach, b.risk_CL, b.risk_indwell, b.risk_immuno, b.risk_mdro, b.risk_trav, b.risk_none, b.risk_unk

from MDRO_clean_2_screenings a left join MDRO_case_year b
	on a.screening_id_new = b.screening_id_new;
quit;


proc sort data=join_screening_case out=dedup_test_join nodupkey;
by screening_id_new screening_id_2;run;

/*Create unique counts of screenings, positives, and screenings with a positive*/
proc sql;
create table table_1 as
select 

	count (distinct screening_id) as tot_scrn "Total unique screenings 2024",

	sum (case when MDRO_identified in (1) then 1 else 0 end) as sum_pos "Total positives yielded 2024"

from join_screening_case;

create table table_1a as
select 
	
	count (distinct screening_id) as tot_pos "Unique screenings returning a positive 2024"

from join_screening_case
	where MDRO_identified in (1)
;
quit;

/*Merge summary tables to create final table 1*/
data table_join;
merge table_1 table_1a;
run;

proc sql;
create table table_1_final as
select
	*,
	tot_pos / tot_scrn as pct_pos "Percent yield of screenings (GE 1 positive) 2024" format percent10.2

from table_join
;

quit;

proc print data=table_1_final noobs label;run;



/*Prep table for analysis (make missing values 0 for risk factors, they're not missing, they just didn't have an MDRO*/
data mdro_analysis;
set join_screening_case;
	array variablesOfInterest _numeric_;
 	do over variablesOfInterest;
		if variablesOfInterest=. then variablesOfInterest=0;
   end;
run;

proc contents data=mdro_analysis;run;

proc sort data=mdro_analysis;by screening_id_new;run;
proc print data=mdro_analysis;run;
/*Create screening breakdown by case and not case associated*/ 
/*Key vars: setting, CP prompting screening, total cases, total screened*/

proc sql;
create table case_breakdown as 
select distinct

	screening_id_new 'Screening ID',
	year 'Year of Screening',
	setting as setting_case 'Screening Setting',
	setting_scrn as setting_case_2 'In what type of high acuity unit was the screening conducted? (if applicable)',
	organism as organism_scrn 'Organism that prompted screening',
	prompt_scrn as prompt_scrn_case ' Carbapenemase/organism that prompted screening',
	

	pps_num_p1 as pps_num_p1_case 'Positives during the first PPS, for thesame carbapenemase/organism as the index case',
	pps_denom_p1 as pps_denom_p1_case 'Total tested during the first PPS (number of swabs collected)',
		(pps_num_p1 / pps_denom_p1) as pct_return_1 "Percent postive first PPS" format percent10.2,

	pps_num_total as pps_num_total_case 'Positives across all PPSs',
	pps_denom_total as pps_denom_case 'Total tests across all PPSs (number of swabs collected)',
		(pps_num_total / pps_denom_total) as pct_return_all "Percent postive across all PPS" format percent10.2,

		case when risk_CL in (1) then 1
			 when risk_immuno in (1) then 1
			 when risk_indwell in (1) then 1
			 when risk_mdro in (1) then 1
			 when risk_trach in (1) then 1
			 when risk_trav in (1) then 1
			 when risk_wound in (1) then 1
					else 0 end as risk_any 'Any risk factor(s) identified'

from mdro_analysis 
	where case_id not in (''); /*use only screenings that identified cases*/

create table screening_breakdown as /*ALL screenings*/
select distinct

	screening_id_new 'Screening ID',
	year 'Year of Screening',
	setting as setting_scr 'Screening Setting',
	setting_scrn as setting_scr_2 'In what type of high acuity unit was the screening conducted? (if applicable)',
	organism as organism_scrn 'Organism that prompted screening',
	prompt_scrn as prompt_scrn_scr ' Carbapenemase/organism that prompted screening',
	pps_num_p1 as pps_num_p1_scr 'Positives during the first PPS, for thesame carbapenemase/organism as the index case',

	case when pps_denom_p1 not in (0) then pps_denom_p1 else . end as pps_denom_p1_scr 'Total tested during the first PPS (number of swabs collected)',
	pps_num_total as pps_num_total_scr 'Positives across all PPSs',

	case when pps_denom_total not in (0) then pps_denom_total 
		 when pps_denom_total in (0) then calculated pps_denom_p1_scr 

			else . end as pps_denom_scr 'Total tests across all PPSs (number of swabs collected)' /*Count PPS' denominator where applicable, if no total then use first PPS value*/

	
from mdro_analysis 
	where case_id in ('')
	order by  pps_denom_scr desc
;

quit;




/*Right now we need to remove duplicate entries specific to some classifications, so we can't exactly proc sort dedupe or sql distinct just yet, in the future we will*/
data case_breakdown_clean;
set case_breakdown;

if screening_id_new in ('104000275') and risk_any in (0) then delete;
if screening_id_new in ('103840840') and organism_scrn in ('No organism identified') then delete;


run;

data test_join;
set case_breakdown_clean screening_breakdown;
run;

proc print data=test_join;run;


/*Check for duplicates obs should = 0*/
proc sql;
create table dupes as
select
	screening_id_new, 
	count(*) as id_count

from test_join
	group by screening_id_new
	having Count(*) >1
;
quit;

proc print data=dupes;run;


proc print data=screening_breakdown;run;
proc print data=case_breakdown noobs;run;


/*Outputs*/
/*Send to excel output for easy sending/viewing*/

title; footnote;
/*Set your output pathway here*/
ods excel file="C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap\screening_breakdown_&sysdate..xlsx";

title justify=left height=10pt font='Helvetica' "Screening Summary - 2024";
ods excel options (sheet_interval = "none" sheet_name = "summary table" embedded_titles='Yes');
proc print data=table_1_final noobs label;run;

title justify=left height=10pt font='Helvetica' "Screenings-resulting-in-cases Table";
ods excel options (sheet_interval = "none" sheet_name = "case table" embedded_titles='Yes');
proc print data=case_breakdown noobs label;run;

title justify=left height=10pt font='Helvetica' "Screenings-not-resulting-in-cases Table";
ods excel options (sheet_interval = "now" sheet_name = "screening table" embedded_titles='Yes');
proc print data=screening_breakdown noobs label;run;

title justify=left height=10pt font='Helvetica' "Screenings-resulting-in-cases Metrics";
ods excel options (sheet_interval = "now" sheet_name = "case metrics" embedded_titles='Yes');
proc freq data=case_breakdown; tables setting_case setting_case_2 prompt_scrn_case /norow nocol nocum;run;
proc means data=case_breakdown maxdec=0 mean median max min; var pps_num_p1_case pps_num_total_case pps_denom_p1_case pps_denom_case;run;

title justify=left height=10pt font='Helvetica' "Screenings-not-resulting-in-cases Metrics";
ods excel options (sheet_interval = "now" sheet_name = "screening metrics" embedded_titles='Yes');
proc freq data=screening_breakdown; tables setting_scr setting_scr_2 prompt_scrn_scr /norow nocol nocum;run;
proc means data=screening_breakdown maxdec=0 mean median max min;var pps_denom_p1_scr pps_denom_scr;where pps_denom_scr GT 0;run;

ods excel close;







