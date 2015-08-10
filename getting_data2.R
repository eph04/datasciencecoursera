#############################################################################################
## mysql connection

library("RMySQL")
ucscDb <- dbConnect(MySQL(),user="genome", 
                    host="genome-mysql.cse.ucsc.edu") # connect to mysql DB without password and create Handler
result <- dbGetQuery(ucscDb,"show databases;") # returns list of databases on server
dbDisconnect(ucscDb) # don't forget to disconnect!!!!!

#######################
## common mysql commands

library("RMySQL")
hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                  host="genome-mysql.cse.ucsc.edu")

allTables <- dbListTables(hg19) # get list of all tables on hg19 database of the server

fields.affyU133Plus2 <- dbListFields(hg19,"affyU133Plus2") # list fields of the table

count.affyU133Plus2 <- dbGetQuery(hg19, "select count(*) from affyU133Plus2") # get count on table

data.affyU133Plus2 <- dbReadTable(hg19, "affyU133Plus2") # read all table!!!! /!\ WARNING /!\

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3") # query on DB
affyMis <- fetch(query) # fetch all data from DB /!\ WARNING /!\
affyMisSmall <- fetch(query,n=10); # fetch only 10 first rows
dbClearResult(query); # don't forget to clear the DB from the query results!!!!!!!!!!!!!!!!!!!!

dbDisconnect(hg19) # don't forget to disconnect!!!!!


#############################################################################################
## hdf5 connection

source("http://bioconductor.org/biocLite.R") # install biocLite.R for bioinfo packages
biocLite("rhdf5") # install rhfd5 package

library(rhdf5)
created = h5createFile("example.h5") # create file
created = h5createGroup("example.h5","foo") # add foo level group
created = h5createGroup("example.h5","baa") # add baa level group
created = h5createGroup("example.h5","foo/foobaa") # add foobaa sub level to foo level group
h5ls("example.h5")

A = matrix(1:10,nr=5,nc=2)
h5write(A, "example.h5","foo/A") # write the matrix in the A sublevel of level foo
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5","foo/foobaa/B")  # write the array in the B sublevel of sublevel foobaa of level foo

df = data.frame(1L:5L,seq(0,1,length.out=5),
                c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5","df") # write the data frame in the root level
h5ls("example.h5")

readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf= h5read("example.h5","df")

h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1)) # overwrite first 3 values of column 1
h5read("example.h5","foo/A")


#############################################################################################
## web connections

con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en") #create url handler
htmlCode = readLines(con) # read all lines on the handler url
close(con)  # don't forget to close the handler!!!!!
htmlCode

#######################
## parsing using XML package

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T) # parse the url given using internal nodes names

xpathSApply(html, "//title", xmlValue) # extract the value of all title tags

xpathSApply(html, "//td [@class='gsc_a_c']", xmlValue) # extract number of citations

#######################
## parsing using httr package

library(httr)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html2 = GET(url) # use a GET to fetch the url without options
content2 = content(html2,as="text") # combine output into text variable

parsedHtml = htmlParse(content2,asText=TRUE) # parse html as text
xpathSApply(parsedHtml, "//title", xmlValue) # retrieve title tag value

#######################
## httr & authentification

library(httr)
pg1 = GET("http://httpbin.org/basic-auth/user/passwd") # GET without options
pg1
# Response [http://httpbin.org/basic-auth/user/passwd]
# Date: 2015-08-10 12:23
# Status: 401
# Content-Type: <unknown>
#   <EMPTY BODY>

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd")) # GET using credential for authentication
pg2
# Response [http://httpbin.org/basic-auth/user/passwd]
# Date: 2015-08-10 12:23
# Status: 200
# Content-Type: application/json
# Size: 47 B
# {
# "authenticated": true, 
# "user": "user"
# }
names(pg2)
# [1] "url"         "status_code" "headers"     "all_headers" "cookies"     "content"     "date"       
# [8] "times"       "request"     "handle"
pg2$content
# [1] 7b 0a 20 20 22 61 75 74 68 65 6e 74 69 63 61 74 65 64 22 3a 20 74 72 75 65 2c 20 0a 20 20 22 75 73
# [34] 65 72 22 3a 20 22 75 73 65 72 22 0a 7d 0a
content(pg2)
# $authenticated
# [1] TRUE
# 
# $user
# [1] "user"
content(pg2,as="text")
# [1] "{\n  \"authenticated\": true, \n  \"user\": \"user\"\n}\n"

#######################
## using handles

google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")

#############################################################################################
## API connections

#######################
## twitter

library(httr)
library(jsonlite)
consumerKey <- "MMrdIPhrD99gARzAqcZ7kA"
consumerSecret <- "6QXIImX6twte3mK2WjCFmzrW7tHISHyLvlXhPTTtg"

tokenApp <- "1247238300-kPXVhkIl86UbVbBtlOWFOPZ2Yxi6FaBwN3dGNdk"
tokenSecretApp <- "HSRdcickjTfbDVS40LtEpppT2L4XRmoCy2xeqhzRUY9Lu"

myapp = oauth_app("twitter",
                  key=consumerKey,secret=consumerSecret) # get oAuth credentials
sig = sign_oauth1.0(myapp,
                    token = tokenApp,
                    token_secret = tokenSecretApp) # sign in usint oAuth credentials
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig) # connect to the twitter app and get data
json1 = content(homeTL) # gather page content
json2 = jsonlite::fromJSON(toJSON(json1)) # parse JSON into data frame


#######################
## github

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
repocontent[repocontent$name == "datasharing",]$created_at  # create date of repo














