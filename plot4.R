##creates r plots concerning Global Active Power, Energy Usage sub-metering,
##Global Reactive Power, and Voltage from dates Feb 1 and Feb 2 2007 
##and saves them in a 2 by 2 matrix to plot4.png file

#read data into data frame from file using sql statement to filter during the read
require ("sqldf")
myFile <- "household_power_consumption.txt"
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql(myFile, sql=mySql, sep=";")
#below used only for testing
#myFile2 <- "household_power_consumption2.txt"
#write.table(myData, file=myFile2, row.names=FALSE, col.names=TRUE, sep=";", quote=FALSE)

#add column for POSIXlt Date-time
newDate<-strptime(paste(myData[,1], myData[,2]), format="%d/%m/%Y %H:%M:%s")
myData[, "DateTime"]<-data.frame(d=as.data.frame.vector(newDate))

#create and save plots to plot4.png file
png(filename="plot4.png")
par(mfrow=c(2,2))
#plot 1
plot(myData[,10], myData[,3], ylab="Global Active Power", xlab="", type="l")
#plot 2
plot(myData[,10], myData[,5], ylab="Voltage", xlab="datetime", type="l")
#plot 3
plot(range(myData[,10]), range(myData[,7]), ylab="Energy sub metering", xlab="", 
     type="n")
legend("topright", lwd=1, col=c("Black", "Blue", "Red"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
lines(myData[,10], myData[,7])
lines(myData[,10], myData[,8], col="Red")
lines(myData[,10], myData[,9], col="Blue")
#plot 4
plot(myData[,10], myData[,4], ylab="Global_reactive_power", xlab="datetime", type="l")
dev.off()