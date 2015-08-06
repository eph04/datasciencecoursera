# Q1
library("data.table")

if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/getdata1.csv")#, mode='wb')
dateDownloaded <- date()
communities <- fread("./data/getdata1.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)

propertyValueMillion <- nrow(communities[!is.na(communities$VAL) & communities$VAL==24,])

# Q3

library("xlsx")
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/getdata2.xlsx", mode='wb')
dateDownloaded <- date()
colIndex=7:15
rowIndex=18:23
dat <- read.xlsx("./data/getdata2.xlsx",sheetIndex=1,header=TRUE,
                  colIndex=colIndex,rowIndex=rowIndex, stringsAsFactors = FALSE)
sum(dat$Zip*dat$Ext,na.rm=T) 

propertyValueMillion <- nrow(communities[!is.na(communities$VAL) & communities$VAL==24,])