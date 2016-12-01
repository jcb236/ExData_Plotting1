#Set working directory to read dat
setwd("C:/R_Exploratory Data Analysis/data")

# Reading, naming and subsetting power consumption data
consumption <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(consumption) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subconsumption <- subset(consumption,consumption$Date=="1/2/2007" | consumption$Date =="2/2/2007")

# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
subconsumption$Date <- as.Date(subconsumption$Date, format="%d/%m/%Y")
subconsumption$Time <- strptime(subconsumption$Time, format="%H:%M:%S")
subconsumption[1:1440,"Time"] <- format(subconsumption[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subconsumption[1441:2880,"Time"] <- format(subconsumption[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# initiating a composite plot with many graphs
par(mfrow=c(2,2))

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(subconsumption,{
  plot(subconsumption$Time,as.numeric(as.character(subconsumption$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subconsumption$Time,as.numeric(as.character(subconsumption$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subconsumption$Time,subconsumption$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subconsumption,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subconsumption,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subconsumption,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subconsumption$Time,as.numeric(as.character(subconsumption$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})