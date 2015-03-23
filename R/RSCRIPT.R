# read in data
hivvert <- read.csv("data/hivvert-data04.csv") 

# missing data
missing <- apply(hivvert, 2, function(x) sum(is.na(x))/length(x))

# data missing more than 5%
sort(missing[missing > 0.05], decreasing=TRUE)

# mean visits
library(dplyr)
visits <- hivvert %>%
    group_by(STUDYID) %>%
    summarise(visits=n())

mean(visits$visits)

library(ggplot2)

# plot histogram of visits
qplot(x=visits, data=visits)

# last visit year
library(lubridate)
year.info <- hivvert %>%
    group_by(STUDYID) %>%
    summarise(last.year=max(year(mdy(VDATE))))

qplot(x=last.year, data=year.info)
