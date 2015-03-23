# input MACS/WIHS data

### NOTE: you will need to replace CHANGEME with appropriate paths

#There are two datasets to work with.  One is arranged
#vertically.  This means that there are more than one
#record (rows of data) for each unique ID value.  This is
#because there are multiple visits for each subject.  Each
#visit generates a separate record.  All separate records 
#for a given subject are 'stacked' on top of one another.
#The other dataset is horizontal.  This means there is only
#one record for each ID.  Notice the substantial differences
#in the sample sizes. THe horizontal data set is useful for
#cross-sectional analyses and for time-invariant values
#like sex and race.  These datasets can be combined in many
#ways.  You can merge one to many (horizontal to vertical) or
#many to one (vertical to horizontal).  


### Horizontal 

# replace CHANGEME with path to directory where you have stored hivhoriz.data02.csv 
# sep="," indicates that this is a comma delimited file (.csv) 
# header=TRUE tell R that the first line in the data file contains a header with variable names
# na.strings="." replaces missing values from "." to "NA"

horiz <- read.table("CHANGEME/macswihs_horiz2013.csv", sep=",", header=TRUE, na.strings=".")
# fix the fact that visits for MACS lacked a zero at the end
# NOTE: Please run these next few lines even if you were told it was not necessary prior to 4/7/14

horiz$LASTAFRV<-ifelse(horiz$COHORT==1, horiz$LASTAFRV*10, horiz$LASTAFRV)
horiz$FRSTAIDV<-ifelse(horiz$COHORT==1, horiz$FRSTAIDV*10, horiz$FRSTAIDV)
horiz$SECAIDV<-ifelse(horiz$COHORT==1, horiz$SECAIDV*10, horiz$SECAIDV)
horiz$LASTALIV<-ifelse(horiz$COHORT==1, horiz$LASTALIV*10, horiz$LASTALIV)
horiz$FRSTDTHV<-ifelse(horiz$COHORT==1, horiz$FRSTDTHV*10, horiz$FRSTDTHV)

### Vertical

# replace CHANGEME with path to directory where you have stored hivvert.data04.csv 
# sep="," indicates that this is a comma delimited file (.csv) 
# header=TRUE tell R that the first line in the data file contains a header with variable names
# na.strings="." replaces missing values from "." to "NA"
vert <- read.table("CHANGEME/hivvert.data04.csv", sep=",", header=TRUE, na.strings=".")
