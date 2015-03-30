# libraries
library(dplyr)
library(ggplot2)

# read in data
hivvert <- read.csv("data/hivvert-data04.csv") %>%
    tbl_df()

hivhoriz <- read.csv("data/macswihs_horiz2013_copy-1.csv") %>%
    tbl_df() %>%
    # convert SAS numeric to date format
    mutate(sero.date=as.Date("1960-01-01") + FPOSDATE,
           sero.pos=sero.date < as.Date("2100-01-01")) %>%
    select(STUDYID, sero.date, sero.pos, AIDSDIAG)

# join datasets
hiv.full <- left_join(hivvert, hivhoriz, 
                      by="STUDYID") %>%
    # only keep MACS data
    filter(COHORT==1) %>%
    # transform visit number
    mutate(visit.num=VISIT/10) %>%
    # keep relevant fields
    select(id=STUDYID,
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

