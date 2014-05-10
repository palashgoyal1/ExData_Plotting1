lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))

myData <- read.table(file = "household_power_consumption.txt", sep = ";", skip = lines[1]-1, nrows = length(lines))

heading <- read.table(file = "household_power_consumption.txt", sep = ";", nrows = 1)

heading <-as.character(unlist(heading))
names(myData) <- heading


## Making an extra empty column in the data frame b
myData["concant"] <- NA

## Default paste sep=" "
v<- paste(myData[[1]],myData[[2]])

## strptime takes date and time in the exact way mentioned in the variable ‘v’, including slash and space : check more on ?strptime
vv<- strptime(v, "%e/%m/%Y %H:%M:%S")

myData$concat <- as.POSIXct(vv)


# This command will come BEFORE the 'par' command
png("plot4.png",width = 480, height = 480)

par(mfrow=c(2,2))

## Put plot2 code here
plot(myData$concat, myData$Global_active_power, ylab="Global Active Power", xlab="", type="n")
lines(myData$concat, myData$Global_active_power)

## plot voltage vs. datetime
plot(myData$concat, myData$Voltage, ylab="Voltage", xlab="datetime", type="n")
lines(myData$concat, myData$Voltage)

## Put plot3 code here
plot(myData$concat, myData$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch='-', col=c("black", "red", "blue"), pt.cex=2)
lines(myData$concat, myData$Sub_metering_1, col="black")
lines(myData$concat, myData$Sub_metering_2, col="red")
lines(myData$concat, myData$Sub_metering_3, col="blue")

## plot global_reactive_power vs. datetime
plot(myData$concat, myData$Global_reactive_power , ylab="Global_reactive_power ", xlab="datetime", type="n")
lines(myData$concat, myData$Global_reactive_power )

dev.off()
