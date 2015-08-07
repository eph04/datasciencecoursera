# Q1

library("data.table")
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/getdata1.csv")
dateDownloaded <- date()
communities <- fread("./data/getdata1.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)

propertyValueMillion <- nrow(communities[!is.na(communities$VAL) & communities$VAL==24,]) # count values

# Q3

library("xlsx")
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/getdata2.xlsx", mode='wb') # xlsx is binary (windows specific)
dateDownloaded <- date()
colIndex=7:15
rowIndex=18:23
dat <- read.xlsx("./data/getdata2.xlsx",sheetIndex=1,header=TRUE,
                  colIndex=colIndex,rowIndex=rowIndex, stringsAsFactors = FALSE)

sum(dat$Zip*dat$Ext,na.rm=T) # question calculation

# Q4

library(XML)
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile = "./data/restaurants.xml")#, mode='wb')
doc <- xmlTreeParse("./data/restaurants.xml",useInternal=TRUE)
rootNode <- xmlRoot(doc) # root node = complete xml

zipcodes <- xpathSApply(rootNode,"//zipcode",xmlValue) #extract value for all zipcode tags from root node

nb_of_21231_zip <- sum(zipcodes=="21231") # count values equal to the filter

# Q5

library("data.table")
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/getdata5.csv")
DT <- fread("./data/getdata5.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)

# cases
tapply(DT$pwgtp15,DT$SEX,mean)
system.time(tapply(DT$pwgtp15,DT$SEX,mean)) #0.00

meanF <- function() {mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)}
system.time(meanF()) #0.03

mean(DT$pwgtp15,by=DT$SEX)
system.time(mean(DT$pwgtp15,by=DT$SEX)) #0.00

DT2 <- DT[,.(pwgtp15,SEX)]
meanF2 <- function() {rowMeans(DT2)[DT2$SEX==1]; rowMeans(DT2)[DT2$SEX==2]} #error
system.time(meanF2())

DT[,mean(pwgtp15),by=SEX]
system.time(DT[,mean(pwgtp15),by=SEX]) #0.00

sapply(split(DT$pwgtp15,DT$SEX),mean)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)) #0.00




