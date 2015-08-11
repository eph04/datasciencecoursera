#############################################################################################
## subsetting/managing/ordering data

set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X
X <- X[sample(1:5),] #change row order
X
X$var2[c(1,3)] = NA #modify var2 data
X

#######################
## subset

X[,1] #subset column 1
X[,"var1"] #subset column var1
X[1:2,"var2"] #subset row  1 to 2 of column var2
X[(X$var1 <= 3 & X$var3 > 11),] #subset rows where var1 <=3 AND var3 > 11
X[(X$var1 <= 3 | X$var3 > 15),] #subset rows where var1 <=3 OR var3 > 15
X[which(X$var2 > 8),] #subset only rows where var2 > 8, without NAs (X[X$var2 > 8,] returns NAs)

#######################
## sort&order

sort(X$var1) #sorting
sort(X$var1,decreasing=TRUE) #sorting decresingly
sort(X$var2,na.last=TRUE) #sorting with NAs last
X[order(X$var1),] #order rows by column
X[order(X$var1,X$var3),]  #order rows by columns

#######################
## using plyr

library(plyr); library(dplyr) # plyr should be loaded BEFORE dplyr

arrange(X,var1) # sort by var1
arrange(X,desc(var1)) # sort by var1 decresing

#######################
## creating data

X$var4 <- rnorm(5)
X
Y <- cbind(X,rnorm(5))
Y

#######################
## summarizing data

if(!file.exists("./data")) {
  dir.create("./data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv")#,method="curl")
restData <- read.csv("./data/restaurants.csv")

##read data
head(restData,n=3) #leading data
tail(restData,n=3) #trailing data

##get qualitative and quantitative summary of data set
summary(restData) #summary of all data
str(restData) #technical description of the data

##data distribution / count
quantile(restData$councilDistrict,na.rm=TRUE) #give quantile distribution
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9)) #check percentages
table(restData$zipCode,useNA="ifany") #summarize factors zipcode (count)
table(restData$councilDistrict,restData$zipCode) #create matrix councilDistrict*zipCode with summary factor (count)

##check NAs
sum(is.na(restData$councilDistrict)) #count NAs
any(is.na(restData$councilDistrict)) #check if exists a NA
all(restData$zipCode > 0) #check if all data are NAs

##row and column sums
colSums(is.na(restData)) #count NAs in each column
all(colSums(is.na(restData))==0) #check if all columns are NA free

##find specifics
table(restData$zipCode %in% c("21212")) #get a table summary counting values equals to values of the vector
table(restData$zipCode %in% c("21212","21213")) #get a table summary counting values equals to values of the vector
restData[restData$zipCode %in% c("21212","21213"),] #filter data depending on the vector

##cross tab
data(UCBAdmissions) #load dataset
DF = as.data.frame(UCBAdmissions)
summary(DF) #get summary of data
xt <- xtabs(Freq ~ Gender + Admit,data=DF) #create cross tab of the frequency by gender and admitance result
xt

##flat tables
warpbreaks$replicate <- rep(1:9, len = 54) # add a column to the dataset
xt = xtabs(breaks ~.,data=warpbreaks) # create cross table on all columns based on breaks values
xt
ftable(xt) #summarize the flat table ftable(xt,row.vars = c("tension","wool"))

##size of a dataset
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units="Mb") #size in Mb

#######################
## creating new variables

if(!file.exists("./data")) {
  dir.create("./data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv")#,method="curl")
restData <- read.csv("./data/restaurants.csv")

##create indexes
s1 <- seq(1,10,by=2)
s1
s2 <- seq(1,10,length=3)
s2
x <- c(1,3,8,25,100)
seq(along = x)

##subset variables
restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland") #add column for filter/counter
table(restData$nearMe) #count by nearMe

restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE) #create column for incorrect zipcode < 0
table(restData$zipWrong,restData$zipCode < 0) #count by zipwrong/check if zip is wrong

#grouping subsets
restData$zipGroups <-
    cut(restData$zipCode,
        breaks=quantile(restData$zipCode)) #create column with quantile distribution of the zip code
table(restData$zipGroups) #count over zip code repartition
table(restData$zipGroups,restData$zipCode) #summarize count of zipgroups per zipcode

#another subset/grouping method
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode,g=4) #group zipcodes in 4 quantiles
table(restData$zipGroups)

##factor variables
restData$zcf <- factor(restData$zipCode) #create a factor column with the zipcode
restData$zcf[1:10]
class(restData$zcf)

yesno <- sample(c("yes","no"),size=10,replace=TRUE) #generate random vector with yes/no
yesnofac <- factor(yesno,levels=c("yes","no")) #transform vector to factor, setting the primary level yes
relevel(yesnofac,ref="yes") #modify the reference level to yes (default would be le first in alphanum order)
as.numeric(yesnofac) #transform it to a number vector

library(Hmisc)
restData$zipGroups = cut2(restData$zcf,g=4)
str(table(restData$zipGroups))

library(Hmisc); library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

# abs(x) absolute value
# sqrt(x) square root
# ceiling(x) ceiling(3.475) is 4
# floor(x) floor(3.475) is 3
# round(x,digits=n) roun(3.475,digits=2) is 3.48
# signif(x,digits=n) signif(3.475,digits=2) is 3.5
# cos(x), sin(x) etc.
# log(x) natural logarithm
# log2(x), log10(x) other common logs
# exp(x) exponentiating x














