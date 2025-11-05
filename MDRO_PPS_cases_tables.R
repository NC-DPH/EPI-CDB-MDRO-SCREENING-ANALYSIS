#
# Program Name:  MDRO_PPS_cases
# Author:        Mikhail Hoskins
# Date Created:  09/03/2025
# Date Modified: 
# Description:   R tables for cases only investigation.
#        
# Inputs:       C:/Users/mhoskins1/Desktop/Work Files/MDRO Screening RedCap/MDRO_PPS_cases_longpivot.xlsx
# Output:       .
#  Notes:       
#   


library(dplyr)
library(tidyr)
library(table1)
library(readxl)
library(rmarkdown)
library(knitr)



MDRO_PPS_cases_longpivot <- read_excel("C:/Users/mhoskins1/Desktop/Work Files/MDRO Screening RedCap/MDRO_PPS_cases_longpivot.xlsx")
print(MDRO_PPS_cases_longpivot)

#Reorder for display by frequency later (honestly no idea how I did this, just trial and error)
reorder_by_freq <- function(x) {
    if(is.factor(x) || is.character(x)) {
        x <- factor(x, levels = names(sort(table(x), decreasing = TRUE)))
    }
    return(x)
}

vars_to_reorder <- c("case_organism", "case_setting_new", "acuity", 
                     "screening_source", "case_link_new", "wholegenome", 
                     "precautions", "assist_lvl", "common_area", "mechanism", "riskfactor", 
                     "hiacuity_hictrf", "hiriskfactor")

MDRO_PPS_cases_longpivot[vars_to_reorder] <- 
    lapply(MDRO_PPS_cases_longpivot[vars_to_reorder], reorder_by_freq)


    #Don't display column counts for risk factors, it's confusing because each event can have >1 risk factor
column_headers <- function(label, n){as.character(label)}



#Labels
label(MDRO_PPS_cases_longpivot$riskfactor) <- "Risk Factor"
#First table: no adjustments
table1(~ riskfactor , data = MDRO_PPS_cases_longpivot, render.strat = column_headers, render.missing = NULL)




#Table for one-to-two vars (mechanism only)
one_to_two_vars <- MDRO_PPS_cases_longpivot %>%
    distinct(case_id, mechanism, .keep_all = TRUE)
#Labels
label(one_to_two_vars$mechanism) <- "CRE Mechanism"
#Second table: adjusting for mechanism
table1(~ mechanism , data = one_to_two_vars, render.strat = column_headers, render.missing = NULL)




#Table for one-to-one vars
one_to_one_vars <- MDRO_PPS_cases_longpivot %>%
    distinct(case_id, case_organism, case_setting_new, acuity,
             screening_source, case_link_new, wholegenome,
             precautions, assist_lvl, common_area, count_rf, .keep_all = TRUE)

label(one_to_one_vars$case_organism) <- "CRE Organism"
label(one_to_one_vars$case_setting_new) <- "Case Setting"
label(one_to_one_vars$acuity) <- "Acuity Level"
label(one_to_one_vars$screening_source) <- "Type of Screening"
label(one_to_one_vars$case_link_new) <- "Connection to Index Case"
label(one_to_one_vars$wholegenome) <- "Whole Genome Sequencing Conducted"
label(one_to_one_vars$precautions) <- "Patient on Precautions"
label(one_to_one_vars$assist_lvl) <- "Patient's Need for Assistance"
label(one_to_one_vars$common_area) <- "Patient Access to Common Areas"
label(one_to_one_vars$hiacuity_hictrf) <- "High Acuity OR 2 + Risk Factors"
label(one_to_one_vars$hiriskfactor) <- "2+ Risk Factors"
       #Risk factors keeps returning mean/med/SD. Make it a factor (then label)
one_to_one_vars$count_rf <- factor(one_to_one_vars$count_rf)
label(one_to_one_vars$count_rf) <- "Number of Risk Factors"
          
#Third table for one-to-one vars (everything except mechanism and risk factors)
table1(~ case_organism + case_setting_new + acuity + screening_source + count_rf
            + case_link_new + wholegenome + precautions + assist_lvl + common_area 
            + hiriskfactor + hiacuity_hictrf
       
       , data = one_to_one_vars, render.strat = column_headers)

