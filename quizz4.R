#############################################################################################
## Q1
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/quizz4_Q1.csv", mode='wb')
familyData <- read.csv("./data/quizz4_Q1.csv", sep = ",", header = TRUE,stringsAsFactors = FALSE)
headerNames <- colnames(familyData)
strsplit(headerNames,"wgtp")[123]
# or
dfNames <- names(familyData)
strsplit(dfNames,"wgtp")[123]

#############################################################################################
## Q2
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/quizz4_Q2.csv", mode='wb')
gdpData <- read.csv("./data/quizz4_Q2.csv", sep = ",", header = FALSE
                    ,skip = 5,nrows = 190,stringsAsFactors = FALSE)
gdpData <- gdpData[,c(1,2,4,5)]
colnames(gdpData) <- c("state","rank","stateName","gdp")
gdpData[,"gdp"] <- as.numeric(gsub(pattern = " |,",replacement = "",x = gdpData$gdp))
mean(gdpData$gdp)

#############################################################################################
## Q3
countryNames <- gdpData$stateName

grep("^United",countryNames)

#############################################################################################
## Q4
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/quizz4_Q4.csv", mode='wb')
gdpData2 <- read.csv("./data/quizz4_Q4.csv", sep = ",", header = FALSE
                    ,skip = 5,nrows = 190,stringsAsFactors = FALSE)
gdpData2 <- gdpData2[,c(1,2,4,5)]
colnames(gdpData2) <- c("state","rank","stateName","gdp")
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, destfile = "./data/quizz4_Q4_2.csv", mode='wb')
educ <- read.csv("./data/quizz4_Q4_2.csv", sep = ",", header = TRUE
                     ,stringsAsFactors = FALSE)
mergedData <- merge(x = gdpData2,y = educ,by.x = "state", by.y = "CountryCode",all.x = TRUE,all.y = TRUE)
fiscalYearEnd <- mergedData$Special.Notes
fiscalYearEndList <- grep(pattern = "^Fiscal year end: June",x = fiscalYearEnd,value = TRUE)
length(fiscalYearEndList)

#############################################################################################
## Q5



