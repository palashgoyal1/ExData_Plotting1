

# Seleccting the lines no. which satisfy the desired condition
lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))

# Selecting the desired rows as tables
myData <- read.table(file = "household_power_consumption.txt", sep = ";", skip = lines[1]-1, nrows = length(lines))

# Selecting the heading names
heading <- read.table(file = "household_power_consumption.txt", sep = ";", nrows = 1)

# Checking the class of above objects
#class(myData)	
#class(heading)

# 'Heading' is a list object, so using 'unlist' function on it first
heading <-as.character(unlist(heading))
names(myData) <- heading
 
c<- myData[3]
c<- as.numeric(unlist(c))
png("plot1.png",width = 480, height = 480)
hist(c, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)")

dev.off()


# If selecting directly from the desired data set file:
# a<- read.table("subset_data.txt", header=TRUE, sep=';')
# myData<- as.data.frame(a)
