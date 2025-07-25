#
# Program Name:  MDRO_PPS_202500430
# Author:        Mikhail Hoskins
# Date Created:  04/25/2025
# Date Modified: 07/25/2025
# Description:   R SQL cleaning and tables for PPS only investigation
#        
# Inputs:       C:\Users\mhoskins1\Desktop\Work Files\MDRO Screening RedCap\mdro_pps_20250716.sas7bdat
# Output:       .
#  Notes:       Can use existing R code in GitHub to create parent file
#            


library(sqldf)
library(dplyr)
library(haven)
library(tidyverse)
library(writexl)

#Import SAS dataset (or better, follow instructions to import directly from RedCap into R)

MDRO_working <- read_sas('C:\\Users\\mhoskins1\\Desktop\\Work Files\\MDRO Screening RedCap\\mdro_pps_202500716.sas7bdat')
View(MDRO_working)

#Change here to use uniform dataset
MDRO_working_2 <- MDRO_working %>% slice(-c(1,2))


MDRO_working_2$screening_id_new <-   substr(MDRO_working_2$screening_id, 1, 9)

#SQL written for SAS cleaned RedCap datasets
#SQL 1
MDRO_clean_1 <- sqldf(" 
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


from MDRO_working_2
	where year >= 2023
	order by screening_id")


#SQL 2

MDRO_clean_2_screenings <- sqldf(" 
select
    

	screening_id_new,
	screening_id,
	redcap_repeat_instrument,
	year,
	case when setting in (1) then 'Acute care hospital'
	     when setting in (2) then 'Long-term acute care hospital'
	     when setting in (3) then 'Ventilator-capable skilled nursing facility'
	     when setting in (4) then 'Skilled nursing facility/nursing home'
	     when setting in (5) then 'Assisted living facility/adult care home'
	     when setting in (6) then 'Dialysis'
	   else 'Missing' end as setting_case,
	   
	index_mdro,
	
		pps_num_p1,
		pps_num_total,
		pps_denom_p1,
		pps_denom_total,
	
	case when cp_ebp in (1) then 'Yes'
		 when cp_ebp in (9) then 'Unknown'
			else 'No' end as contact_prec,
			
	case when index_lda___1 in (1) then 'Open/draining Wound' else 'None' end as wound,
		case when index_lda___2 in (1) then 'Endotracheal tube/Nasotracheal tube/Tracheostomy'  else 'None' end as endo,
		case when index_lda___3 in (1) then 'Central Line/PICC'  else 'None' end as cenline,
		case when index_lda___4 in (1) then 'Other indwelling devices'  else 'None' end as othindwell,
		case when index_lda___5 in (1) then 'Immunocompromised'  else 'None' end as immuno,
		case when index_lda___6 in (1) then 'Prior/other MDRO'  else 'None' end as priorMDRO,
		case when index_lda___7 in (1) then 'International healthcare or travel'  else 'None' end as trav,
		case when index_lda___0 in (1) then 'None'  else 'None' end as none,
		case when index_lda___9 in (1) then 'Missing'  else 'None' end as miss,
		
	case when cpase___0 in (1) then 'None'
		 when cpase___1 in (1) then 'KPC'
		 when cpase___2 in (1) then 'NDM'
		 when cpase___3 in (1) then 'OXA-23/24'
		 when cpase___4 in (1) then 'OXA-48'
		 when cpase___5 in (1) then 'VIM'
		 when cpase___6 in (1) then 'IMP'
		 when cpase___7 in (1) then 'Other'
		 when cpase___9 in (1) then 'Unknown'

	else '' end as prompt_scrn,
	
	
	case when organism___1 in (1) then 'C. auris'
		 when organism___2 in (1) then 'E. Coli'
		 when organism___3 in (1) then 'E. cloacae'
		 when organism___4 in (1) then 'E. aerogenes/K. aerogenes'
		 when organism___5 in (1) then 'K. pneumoniae'
		 when organism___6 in (1) then 'K. oxytoca'
		 when organism___7 in (1) then 'CRPA'
		 when organism___8 in (1) then 'CRAB'
		 when organism___9 in (1) then 'No organism identified'
		 when organism___10 in (1) then organism_other

	else '' end as organism_prompt,
	
	case when setting_acuity_type___1 in (1) then 'ICU'
		 when setting_acuity_type___2 in (1) then 'Burn'
		 when setting_acuity_type___3 in (1) then 'Ventilator unit'
		 when setting_acuity_type___4 in (1) then 'Oncology unit'
		 when setting_acuity_type___7 in (1) then 'Other'
		 when setting_acuity_type___9 in (1) then 'Unknown'
		 when setting_other not in ('') then setting_other
		 
	else '' end as hiacutiy_setting_scrn,
	
	
	case when (pps_num_total) not in (0,'') then 1 else 0 end as MDRO_identified,

	case when (pps_denom_total) not in (0,'') then pps_denom_total else pps_denom_p1 end as denom_combine_PPS
		
		
from MDRO_clean_1
where redcap_repeat_instrument in ('screening_abstraction') and pps_flag in (1)
                                 order by screening_id_new")
                                 
MDRO_clean_3_screenings <- sqldf("
select *,
    
    case when (prompt_scrn) in ('None') then organism_prompt
		  else prompt_scrn end as parent_prompt 
                                 
from MDRO_clean_2_screenings")


# Vars: parent_prompt, organism_prompt, setting_case, contact_prec, wound, endo, cenline, othindwell, immuno, priorMDRO, trav, none, miss, hiacutiy_setting_scrn, MDRO_identified


MDRO_clean_final <- sqldf("
select 

 screening_id_new,
  parent_prompt, organism_prompt, setting_case, contact_prec, wound, endo, cenline, othindwell, immuno, priorMDRO, trav, none, miss, hiacutiy_setting_scrn, MDRO_identified
  
from MDRO_clean_3_screenings")

MDRO_clean_final_positives <- sqldf("
select 

 screening_id_new,
  parent_prompt, organism_prompt, setting_case, contact_prec, wound, endo, cenline, othindwell, immuno, priorMDRO, trav, none, miss, hiacutiy_setting_scrn, MDRO_identified
  
from MDRO_clean_3_screenings
                                    where MDRO_identified in (1)")


#Export final datasets

write_xlsx(MDRO_clean_final, "C:\\Users\\mhoskins1\\Desktop\\Work Files\\MDRO Screening RedCap\\MDRO_clean_PPS_ALL.xlsx")
write_xlsx(MDRO_clean_final_positives, "C:\\Users\\mhoskins1\\Desktop\\Work Files\\MDRO Screening RedCap\\MDRO_clean_PPS_Positives.xlsx")



















source("Cleaning.r",local = knitr::knit_global())

screentypedata2 <- data %>% 
  pivot_longer(cols = starts_with("screen_type"),
               names_to = "screening_type",
               values_to = "screening_type_value",
               values_transform = list(screening_type_value = as.integer)) %>% 
  mutate(screening_type = case_match(screening_type, "screen_type___1" ~ "pps",
                                     "screen_type___2" ~ "ID_contact",
                                     "screen_type___3" ~ "flag_contact",
                                     "screen_type___7" ~ "other",
                                     "screen_type___9" ~ "unknown"))



mutate(screening_type = case_match(screening_type, "screen_type___1" ~ "pps",
                                   "screen_type___2" ~ "ID_contact",
                                   "screen_type___3" ~ "flag_contact",
                                   "screen_type___7" ~ "other",
                                   "screen_type___9" ~ "unknown"))



#
mutate(setting1 = case_match(setting1, "setting_acuity_type___1" ~ "ICU",
                             "setting_acuity_type___2" ~ "Burn",
                             "setting_acuity_type___3" ~ "Vent",
                             "setting_acuity_type___4" ~ "Oncology",
                             "setting_acuity_type___7" ~ "Other",
                             "setting_acuity_type___9" ~ "Unknown")) %>% 
  filter(settingvalue == 1) %>% 
















