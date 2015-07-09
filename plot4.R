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

## Transform factor variables to numeric ones
tidydata$Global_active_power<-as.numeric(as.character(tidydata$Global_active_power))
tidydata$Sub_metering_1<-as.numeric(tidydata$Sub_metering_1)
tidydata$Sub_metering_2<-as.numeric(tidydata$Sub_metering_2)
tidydata$Sub_metering_3<-as.numeric(tidydata$Sub_metering_3)
tidydata$Global_reactive_power<-as.numeric(tidydata$Global_reactive_power)

## PLOT

par(mfcol=c(2,2),mar=c(4,4,3,3), cex.lab=0.8)
##graph (1,1)(plot2)
plot(tidydata$Time,tidydata$Global_active_power,type="l", xlab="", ylab="Global Active Power")
##graph (1,2)(plot3/no box legend)
plot(tidydata$Time,tidydata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(tidydata$Time,tidydata$Sub_metering_1,)
lines(tidydata$Time,tidydata$Sub_metering_2, col="red")
lines(tidydata$Time,tidydata$Sub_metering_3,col="blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),bty= "n",
       lty=c(1,1),col=c("black","red","blue"),cex=0.6)
##graph(2,1)(voltage,time)
plot(tidydata$Time,tidydata$Voltage, type="l", xlab="datetime", ylab="Voltage")
#graph(2,2)(time, global_reactive_power)
plot(tidydata$Time,tidydata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
## Create a png
dev.copy(png,file="plot4.png")
dev.off()