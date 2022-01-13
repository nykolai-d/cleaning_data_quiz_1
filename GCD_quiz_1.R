getwd()
setwd("/home/nykolai/Documents/datasciencecoursera/cleaningdata/")

#Creating the new directory and setting it as work directory
if(!file.exists("quiz1")){dir.create("quiz1")}
setwd("/home/nykolai/Documents/datasciencecoursera/cleaningdata/quiz1")

#question 1
destination.file <- "/home/nykolai/Documents/datasciencecoursera/cleaningdata/quiz1/01.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = destination.file)
data <- read.csv("01.csv")
data
sum(data[!is.na(data$VAL),]$VAL == 24)
#53

#question 2
#Tidy data has one variable per column. 

#question 3
install.packages("openxlsx")
library(openxlsx)

destination.file <- "/home/nykolai/Documents/datasciencecoursera/cleaningdata/quiz1/03.xlsx"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = destination.file)
dat <- readWorkbook("03.xlsx", sheet = 1, rows = 18:23, cols = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)
#36534720

#question 4

#On Ubuntu 20.04, first do the following:
#sudo apt-get update
#sudo apt-get install libxml2-dev

install.packages("XML")
library(XML)

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
tree <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(tree)
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")
#127

#question 5
install.packages("data.table")
library(data.table)

destination.file <- "/home/nykolai/Documents/datasciencecoursera/cleaningdata/quiz1/05.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = destination.file)
DT <- fread("05.csv")

sum(system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15)))
#0.017
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
#0.01
system.time(DT[,mean(pwgtp15),by=SEX])
#0.06
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
#0.02
system.time(mean(DT$pwgtp15,by=DT$SEX))
#0.0(?)
sum(system.time(rowMeans(DT)[DT$SEX==1]+system.time(rowMeans(DT)[DT$SEX==2])))
#Error
