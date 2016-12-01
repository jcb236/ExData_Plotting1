#Set working directory to read dat
setwd("C:/R_Exploratory Data Analysis/data")

# Reads and subsets power consumption data
consumption <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(consumption) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subconsumption <- subset(consumption,consumption$Date=="1/2/2007" | consumption$Date =="2/2/2007")

# Transforms the date and time variables from characters into date and time numeric values
subconsumption$Date <- as.Date(subconsumption$Date, format="%d/%m/%Y")
subconsumption$Time <- strptime(subconsumption$Time, format="%H:%M:%S")
subconsumption[1:1440,"Time"] <- format(subconsumption[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subconsumption[1441:2880,"Time"] <- format(subconsumption[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# Calls the basic plot functions and puts the three submetered devices
# into one plot with each one differentiated from the other
plot(subconsumption$Time,subconsumption$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subconsumption,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subconsumption,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subconsumption,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# annotating graph
title(main="Energy sub-metering")