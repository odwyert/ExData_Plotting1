##creates plot concerning Global Active Power from dates Feb 1 and Feb 2 2007 
##and saves it to plot2.png file

#read data into data frame from file using sql statement to filter during the read
require ("sqldf")
myFile <- "household_power_consumption.txt"
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql(myFile, sql=mySql, sep=";")
#below used only for testing
#myFile2 <- "household_power_consumption2.txt"
#write.table(myData, file=myFile2, row.names=FALSE, col.names=TRUE, sep=";", quote=FALSE)

#add column for POSIXlt Date-time to be used in other plots
newDate<-strptime(paste(myData[,1], myData[,2]), format="%d/%m/%Y %H:%M:%s")
myData[, "DateTime"]<-data.frame(d=as.data.frame.vector(newDate))

#create and save histogram to plot1.png file
png(filename="plot1.png")
hist(myData$Global_active_power, col="Red", main = "Global Active Power", 
           xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()

