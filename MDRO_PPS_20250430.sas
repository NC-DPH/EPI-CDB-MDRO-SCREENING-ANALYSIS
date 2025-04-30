/*
 *------------------------------------------------------------------------------
 * Program Name:  MDRO_PPS_20250327
 * Author:        Mikhail Hoskins
 * Date Created:  04/15/2025
 * Date Modified: 04/25/2025
 * Description:   Point prevelance screening extract, cleaning, and analysis.
 *
 * Input:        mdro_pps_20250425.sas7bdat : C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap
 * Output:       .
 *
 * Notes:       Follow RedCap instructions to download. Save a raw file and create a working file (done below) for analysis.
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

proc contents data=MDRO_working;run;
proc freq data=MDRO_working; tables pps_num_p1 /norow nocol nopercent;run;

data MDRO_working;
set MDRO_working;

	screening_id_new = substr(screening_id, 1, 9);

run;

 
/*Keep a sample set of variables*/
proc sql;
create table MDRO_clean_1 as
select
		screening_id,
		screening_id_new,
		case_id,
		index_mdro,
		setting,
		pps_num_p1,
		pps_denom_total,
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
proc print data=MDRO_clean_1;run;
/*Create singular labels defined by each series of variables in a category (simplify our tables): SCREENING SPECIFIC */
proc sql;
create table MDRO_clean_2_screenings as
select

	screening_id_new,
	/*case when case_id not in ('') then 1 else 0 end as MDRO_identified 'MDRO Identified from screening',*/
	index_mdro,
	setting,
	pps_num_p1,
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
having case_id in ('')
	order by screening_id_new;
	


quit;




/*Create singular labels defined by each series of variables in a category: CASE SPECIFIC*/
proc sql;
create table MDRO_case_identified as
select

	screening_id_new,
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

	else '' end as organism "Which organism(s) did the person test positive for during screening?",

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
proc print data=MDRO_case_identified ;run;


/*Join screening and case specific fields*/
proc sql; 
create table join_screening_case as
select

	case when b.case_id not in ('') then 1 else 0 end as MDRO_identified,
	case when a.pps_num_p1 GT 0 then 1 else 0 end as MDRO_identified_2,
	a.*,
	b.case_id, b.screening_id_new, b.screening_id_new as screening_id_2, b.organism, b.risk_wound, b.risk_trach, b.risk_CL, b.risk_indwell, b.risk_immuno, b.risk_mdro, b.risk_trav, b.risk_none, b.risk_unk

from MDRO_clean_2_screenings a left join MDRO_case_identified b
	on a.screening_id_new = b.screening_id_new;

/*Create unique counts of screenings, positives, and screenings with a positive*/

create table table_1 as
select 

	count (distinct screening_id_new) as tot_scrn "Total unique screenings",

	sum (case when MDRO_identified in (1) then 1 else 0 end) as sum_pos "Total positives yielded"

from join_screening_case;

create table table_1a as
select 
	
	count (distinct screening_id_new) as tot_pos "Unique screenings returning a positive"

from join_screening_case
	where MDRO_identified in (1)
;
quit;

proc print data=join_screening_case;run;




/*Merge tables to create final table 1*/
data table_join;
merge table_1 table_1a;
run;

proc sql;
create table table_1_final as
select
	*,
	tot_pos / tot_scrn as pct_pos "Percent yield of screenings (GE 1 positive)" format percent10.2

from table_join
;

quit;


/*Prep table for analysis (make missing values 0 for risk factors, they're not missing, they just didn't have an MDRO*/
data mdro_analysis;
set join_screening_case;
	array variablesOfInterest _numeric_;
 	do over variablesOfInterest;
		if variablesOfInterest=. then variablesOfInterest=0;
   end;
run;

/*run 2x2 on risk factors*/
proc freq data=join_screening_case;
tables MDRO_identified*MDRO_identified_2/ norow nocol nopercent ;

run;


/*Outputs*/
proc print data=mdro_analysis noobs;run;
proc print data=MDRO_working noobs;run;
proc print data=table_1_final noobs label;run;

proc contents data=MDRO_analysis;run;


proc freq data=MDRO_analysis;tables 

	risk_immuno*MDRO_identified_2
	risk_indwell*MDRO_identified_2
	risk_mdro*MDRO_identified_2
	risk_CL*MDRO_identified_2
	risk_none*MDRO_identified_2
	risk_trach*MDRO_identified_2
	risk_trav*MDRO_identified_2
	risk_unk*MDRO_identified_2
	risk_wound*MDRO_identified_2
	prompt_scrn
	screening_id

		/norow nocol nopercent;

run;

proc freq data=MDRO_analysis; tables prompt_scrn /norow nocol nopercent;
where screening_id not in ('');
run;


proc sql;
create table distinct_source as

select distinct
	prompt_scrn,
	count (distinct screening_id) as unique_scrn "Unique screenings"

from MDRO_analysis
	group by prompt_scrn
	
;

create table distinct_setting as

select distinct
	setting,
	count (distinct screening_id) as unique_scrn "Unique screenings"

from MDRO_analysis
	group by setting
	
;
quit;

proc print data=distinct_source noobs label;run;
proc print data=distinct_setting noobs label;run;


proc freq data=MDRO_working; tables case_id*redcap_repeat_instrument /norow nocol nopercent;run;
