# libraries
library(readr)
library(dplyr)
library(ggplot2)

# read in data
# hivvert <- read.csv("data/hivvert-data04.csv",
#                     stringsAsFactors=FALSE) %>%
#     tbl_df()

hivvert <- read_csv("data/hivvert-data04.csv",
                    col_types="iiciiididdiiiiiiiddiiiiiiiiiiiidc")

hivhoriz <- read_csv("data/macswihs_horiz2013_copy-1.csv") %>%
    filter(COHORT==1) %>%
    # convert SAS numeric to date format
    mutate(sero.date=as.Date("1960-01-01") + FPOSDATE,
           sero.pos=sero.date < as.Date("2100-01-01"),
           dob=as.Date("1960-01-01") + DOB,
           base.date=as.Date("1960-01-01") + BSDATE,
           age.base=as.double(difftime(base.date, 
#                                        dob, unit="weeks"))/52.25) %>%
                                       dob, unit="weeks"))/52.25)
    select(STUDYID, sero.date, sero.pos, AIDSDIAG, FRSTARTD,
           RACE, age.base, STATUS, FRSTAIDD, SECAIDD, base.date)

# join datasets
hiv.full <- left_join(hivvert, hivhoriz, 
                      by="STUDYID") %>%
    # only keep MACS data
    filter(COHORT==1) %>%
#     filter(COHORT==1,
           # drop prevalent cases
#            STATUS != 2) %>%
    # transform visit number
    mutate(visit.num=VISIT/10,
           art.date=as.Date("1960-01-01") + FRSTARTD,
           first.adi.date=as.Date("1960-01-01") + FRSTAIDD,
           sec.adi.date=as.Date("1960-01-01") + SECAIDD) %>%
    # keep relevant fields
    select(id=STUDYID,
           race=RACE,
           age.base,
           base.date,
           first.adi.date,
           sec.adi.date,
           visit.num,
           visit.date=VDATE,
           cd4.count=CD4N,
           cd4.pct=CD4P,
           therapy=THRPY,
           depression.score=CESD,
           idu=IDU,
           pot=POTUSE,
           crack=CRACKUSE,
           cocaine=COCUSE,
           heroin=HERUSE,
           amphetamine=AMPHUSE,
           poppers=POPUSE,
           sero.date,
           sero.pos,
           defining.diag=AIDSDIAG)

# first
hivhoriz %>% filter(STATUS==2) %>% transmute(less=FRSTAIDD<BSDATE, diag=AIDSDIAG > 0) %>% count(less, diag)

# second
hivhoriz %>% filter(STATUS==2) %>% transmute(less=SECAIDD<BSDATE, diag=SECAIDSDIAG > 0) %>% count(less, diag)

# converters
hivhoriz %>% filter(STATUS==4, COHORT==1, AIDSDIAG>0) %>% 
    mutate(bsdate=as.Date("1960-01-01")+BSDATE,
           frstartd=as.Date("1960-01-01")+FRSTARTD) %>%
    count(year(bsdate))

# START OVER

covariates <- read_csv("data/macswihs_horiz2013_copy-1.csv") %>%
    # keep MACS only
    filter(COHORT==1,
           # keep people with first ADI only
           AIDSDIAG != 0) %>%
           # date of death
    mutate(death.date=as.Date("1960-01-01") + FRSTDTHD,
           aids.date=as.Date("1960-01-01") + FRSTAIDD,
           sec.aids.date=as.Date("1960-01-01") + SECAIDD,
           frst.aids.diag=AIDSDIAG,
           sec.aids.diag=SECAIDSDIAG,
           haart.era.94=year(aids.date) >= 1994,
           haart.era.96=year(aids.date) >= 1996,
           had.sec=year(sec.aids.date) < 2100,
           died=year(death.date) < 2100)

hivvert <- read_csv("data/hivvert-data04.csv",
                    col_types="iiciiididdiiiiiiiddiiiiiiiiiiiidc") %>%
    mutate(visit=VISIT / 10) %>%
    group_by(STUDYID) %>%
#     summarise(first.wt=
    

hiv.full <- left_join(hivhoriz, 



    # convert SAS numeric to date format
    mutate(sero.date=as.Date("1960-01-01") + FPOSDATE,
           sero.pos=sero.date < as.Date("2100-01-01"),
           dob=as.Date("1960-01-01") + DOB,
           base.date=as.Date("1960-01-01") + BSDATE,
           age.base=as.double(difftime(base.date, 
#                                        dob, unit="weeks"))/52.25) %>%
                                       dob, unit="weeks"))/52.25)
