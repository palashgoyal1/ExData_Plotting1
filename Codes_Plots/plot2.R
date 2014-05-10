

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

png("plot2.png", width = 480, height = 480)

# Not putting the data, else it will plot dots
plot(myData$concat, myData$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="n")

# Plotting lines now
lines(myData$concat, myData$Global_active_power)

dev.off()
