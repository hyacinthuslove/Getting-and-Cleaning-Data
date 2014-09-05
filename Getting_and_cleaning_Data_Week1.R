# Coursera = Getting and Cleaning Date

# Set Working Directory
setwd("C:/Coursera/Getting and Cleaning Data")

# Create a data directory to keep all the downloaded data files
if (!file.exists("data")){
  dir.create("data")
}

# Q1 Download a file using download.file

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL,destfile="./data/idaho2006survey.csv")

# Q2 

idaho2006survey <- read.csv(file="./data/idaho2006survey.csv",head=TRUE,sep=",")
x <- subset(idaho2006survey, VAL==24)
nrow(x)

# Q3

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL,destfile="./data/NaturalGasAquisitionData.xlsx", mode="wb")
# Note. Need to change the mode to binary else i.e. mode="wb" there will be problem reading the xlsx file

install.packages("xlsx")
library(xlsx)
filePath ="./data/NaturalGasAquisitionData.xlsx"
NaturalGasAquisitionProgram <- read.xlsx(filePath,sheetIndex=1,header=TRUE)

# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called dat
dat <- read.xlsx(filePath, sheetIndex=1, sheetName=1, rowIndex=18:23, colIndex=7:15,
                 as.data.frame=TRUE, header=TRUE)
head(dat)
sum(dat$Zip*dat$Ext,na.rm=T)

# Q4
# ReadXML
install.packages("XML")
library(XML)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileURL,destfile="./data/restaurants.xml", mode="wb")
filePath ="./data/restaurants.xml"
doc <- xmlRoot(xmlTreeParse(filePath,useInternal=TRUE))

# This will traverse to zipcode of the first record => doc[[1]][[1]][[2]]
# This will grab all zipcodes
RestaurantList <- xpathSApply(doc[[1]][[1]],"//zipcode",xmlValue)
sum(RestaurantList[zipcode==21231]==21231)

# Q5
install.packages("data.table")
library(data.table)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL,destfile="./data/2006microdata.csv", mode="wb")
filePath ="./data/2006microdata.csv"

# using the fread() command load the data into an R object DT
DT = fread(filePath,header=TRUE)
processTime <- vector('numeric')

# Which of the following is the fastest way to calculate the average value of the variable
# mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
ptm <- Sys.time()
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
processTime <- c(processTime, Sys.time() - ptm)

# sapply(split(DT$pwgtp15,DT$SEX),mean)
ptm <- Sys.time()
sapply(split(DT$pwgtp15,DT$SEX),mean)
processTime <- c(processTime, Sys.time() - ptm)

# mean(DT$pwgtp15,by=DT$SEX)
ptm <- Sys.time()
mean(DT$pwgtp15,by=DT$SEX)
processTime <- c(processTime, Sys.time() - ptm)

# DT[,mean(pwgtp15),by=SEX]
ptm <- Sys.time()
DT[,mean(pwgtp15),by=SEX]
processTime <- c(processTime, Sys.time() - ptm)

# rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
ptm <- Sys.time()
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
processTime <- c(processTime, Sys.time() - ptm)

# tapply(DT$pwgtp15,DT$SEX,mean)
ptm <- Sys.time()
tapply(DT$pwgtp15,DT$SEX,mean)
processTime <- c(processTime, Sys.time() - ptm)

processTime
min(processTime)



