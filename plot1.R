library('lubridate')
library('data.table')

setwd("/Users/onRu/Documents/Methodology/Data Science courses/Exploratory Data Analysis/FirstProject")
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "./Data/household_power_consumption.zip"
dataFile <- "./Data/household_power_consumption.txt"
##
if (!file.exists(dataFile)) {
  download.file(downloadURL, zipFile, method = "curl")
  unzip(zipFile, overwrite = T, exdir = "./Data")
}
##
plotData <- read.table(dataFile, header=T, sep=";", na.strings="?")

## set time variable##
dataset1 <- plotData[plotData$Date %in% c("1/2/2007","2/2/2007"),] ##this leaves the two dates that are asked for in the question##
SetTime <-strptime(paste(dataset1$Date, dataset1$Time, sep=" "),"%d/%m/%Y %H:%M:%S") ##converting date and time variables##
dataset1 <- cbind(SetTime, dataset1) ##binding converted variables to the rest of the dataset1##
dataset1$DateTime<-dmy(dataset1$Date)+hms(dataset1$Time)

##setting up the .png file and plotting the histogram for Global Active Power ##
png(filename='/Users/onRu/Documents/Methodology/Data Science courses/Exploratory Data Analysis/FirstProject/plot1.png',width=480,height=480,units='px')
hist(dataset1$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()