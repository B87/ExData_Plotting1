## GETTING THE TIDY DATA

##set directory
setwd("C:/Users/Bernat/Desktop/MOOCS/Exploratory_Data_Analysis/exdata-data-household_power_consumption")
#read data
rawdata<-read.table("household_power_consumption.txt", header=TRUE, sep=";"
                    ,stringsAsFactors=FALSE)

#transform Date into date class
rawdata$Date<-as.Date(rawdata$Date, format = "%d/%m/%Y")

## Subset from 1/2/2007 to 2/2/2007  
subseting<- function(x,y){rawdata[rawdata$Date >= x & rawdata$Date <= y,]}
x<- as.Date("2007-02-01")
y<- as.Date("2007-02-02")

tidydata<-subseting(x,y)

##transform Time into a time class
tidydata$Time<-as.POSIXct(paste(tidydata$Date,as.character(tidydata$Time)))

## Transform char variables to numeric ones
tidydata$Global_active_power<-as.numeric(as.character(tidydata$Global_active_power))
tidydata$Sub_metering_1<-as.numeric(tidydata$Sub_metering_1)
tidydata$Sub_metering_2<-as.numeric(tidydata$Sub_metering_2)
tidydata$Sub_metering_3<-as.numeric(tidydata$Sub_metering_3)
tidydata$Global_reactive_power<-as.numeric(tidydata$Global_reactive_power)

## PLOT

hist(tidydata$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
## Create a png
dev.copy(png,file="plot1.png")
dev.off()