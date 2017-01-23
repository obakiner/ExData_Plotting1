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

## plotting the energy sub metering graph with the legend##
png(filename='/Users/onRu/Documents/Methodology/Data Science courses/Exploratory Data Analysis/FirstProject/plot3.png',width=480,height=480,units='px')
plot(dataset1$DateTime,dataset1$Sub_metering_1,type='l',col='black',xlab='',ylab='Energy sub metering')
lines(dataset1$DateTime,dataset1$Sub_metering_2,col='red')
lines(dataset1$DateTime,dataset1$Sub_metering_3,col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty='solid', cex = 0.25)
dev.off()