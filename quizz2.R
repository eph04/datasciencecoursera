#############################################################################################
## Q1

library(httr)
library(jsonlite)
library(httpuv)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#

clientID <- "8144e3cbef9ebc567194"
clientSecret <- "14b818ce5958883f8b33a07d3bb8469c967139a1"
myapp <- oauth_app("github",
                   key = clientID,
                   secret = clientSecret)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp, cache=FALSE) #removing the cache is mendatory

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
# OR replacing last 2 lines of code:
#req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))

stop_for_status(req) # stop if GET fuction fails
repoRaw <- content(req)  # gather page content
repocontent = jsonlite::fromJSON(toJSON(repoRaw)) # parse JSON into data frame
repocontent[repocontent$name == "datasharing",]$created_at   # create date of repo
#repocontent$created_at[[6]] #datasharing is the 6th repo

#############################################################################################
## Q2/3

library(sqldf)
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/quizz2_Q2.csv")
acs <- read.table("./data/quizz2_Q2.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)

sqldf("select * from acs where AGEP < 50") # ko get all columns
sqldf("select pwgtp1 from acs where AGEP < 50") # ok get only 1 column & filter <=> acs$pwgtp1[acs$ages < 50]
sqldf("select * from acs") # ko get all columns w/o filter
sqldf("select * from acs where AGEP < 50 and pwgtp1") # ko get all columns & filter KO

sqldf("select AGEP where unique from acs") # ko not sql
sqldf("select distinct pwgtp1 from acs") # ko unique pwgtp1
sqldf("select distinct AGEP from acs") # ok unique AGEP in acs
sqldf("select unique AGEP from acs") # ko not sql

#############################################################################################
## Q4

con = url("http://biostat.jhsph.edu/~jleek/contact.html ") #create url handler
htmlCode <- readLines(con) # read all lines on the handler url
close(con)  # don't forget to close the handler!!!!!
sapply(list(10,20,30,100),function (x) {nchar(htmlCode[x])}) # get length of all vectors for this list

#############################################################################################
## Q5

if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile = "./data/quizz2_q5.for")
dateDownloaded <- date()
dataF <- read.fwf("./data/quizz2_q5.for", skip = 4, header = FALSE,stringsAsFactors = FALSE
                  ,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4)
                  ,col.names = c("Week","SST1","SSTA1","SST2","SSTA2","SST3","SSTA3","SST4","SSTA4"))
sum(dataF[,4])











