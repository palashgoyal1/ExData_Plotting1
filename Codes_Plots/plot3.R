

lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))

myData <- read.table(file = "household_power_consumption.txt", sep = ";", skip = lines[1]-1, nrows = length(lines))

heading <- read.table(file = "household_power_consumption.txt", sep = ";", nrows = 1)

heading <-as.character(unlist(heading))
names(myData) <- heading


## Making an extra empty column in the data frame myData
myData["concant"] <- NA

## Default paste sep=" "
v<- paste(myData[[1]],myData[[2]])

## strptime takes date and time in the exact way mentioned in the variable ‘v’, including slash and space : check more on ?strptime
vv<- strptime(v, "%e/%m/%Y %H:%M:%S")

myData$concat <- as.POSIXct(vv)


png("plot3.png",width = 480, height = 480)

## Plotting without data
plot(myData$concat, myData$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n")

# Making legend at top
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch='-', col=c("black", "red", "blue"), pt.cex=2)

# Drawing lines one-by-one
lines(myData$concat, myData$Sub_metering_1, col="black")
lines(myData$concat, myData$Sub_metering_2, col="red")
lines(myData$concat, myData$Sub_metering_3, col="blue")

dev.off()
