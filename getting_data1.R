#############################################################################################
## csv files
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
#download.file(fileUrl, destfile = "cameras.csv", method = "curl")
download.file(fileUrl, destfile = "./data/cameras.csv", mode='wb')
dateDownloaded <- date()
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE) #cameraData <- read.csv("./data/cameras.csv")

#############################################################################################
## xlsx files
if(!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
#download.file(fileUrl,destfile="./data/cameras.xlsx",method="curl")
download.file(fileUrl,destfile="./data/cameras.xlsx", mode='wb')
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,header=TRUE)

colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,
                              colIndex=colIndex,rowIndex=rowIndex)

#############################################################################################
## XML files

library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc) # root node = complete xml
xmlName(rootNode) # name of the root tag

names(rootNode) # nodes name under the root node

rootNode[[1]] # extract first node under root node

rootNode[[1]][[1]] #extract first sub node of the first sub node
rootNode[[2]][[1]] #extract first sub node of the second sub node
rootNode[[1]][[2]] #extract second sub node of the first sub node

xmlSApply(rootNode,xmlValue) #gather all values for each subnode of the root

xpathSApply(rootNode,"//name",xmlValue) #extract value for all names tags from root node
xpathSApply(rootNode,"//price",xmlValue) #extract value for all prices tags from root node

fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens" #no values for score
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
teams <- xpathSApply(doc, "//div[@class='game-info']", xmlValue)
scores <- xpathSApply(doc, "//div[@class='score']", xmlValue)


fileUrl <- "http://espn.go.com/mlb/team/_/name/bal/baltimore-orioles" 
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
scores <- xpathSApply(doc, "//div[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//div[@class='game-info']", xmlValue)
teams2 <- xpathSApply(doc, "//div[@class='game-info']", function(e) {s<-strsplit(xmlValue(e), " "); paste(s[[1]][-(1)], collapse=" ")})

#############################################################################################
## json files

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData) #name of the nodes attr
names(jsonData$owner) #name of the subnode attr

myjson <- toJSON(iris, pretty=TRUE) #convert a dataframe to JSON
cat(myjson)

iris2 <- fromJSON(myjson)

#############################################################################################
## data.table

library(data.table)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9)) #create data frame
head(DF,3)

DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9)) #create data table
head(DT,3)

tables() #list all tables and attributes

DT[2,] #get second line
DT[DT$y=="a",] #get lines where y=="a"
DT[c(2,3)] # get 2,3 lines

DT[,.(x,y)] # get columns x&y (returns a data.table instead of a vector if I don't use ".()")

