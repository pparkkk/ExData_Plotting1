#Reading in data into R
#Note that only the interested data (between 2007-02-01 and 2001-02-02) is read
data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", 
                   na.strings = "?", skip = 66637, nrows = 2880)
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                 "Voltage", "Global_intensity", "Sub_metering_1", 
                 "Sub_metering_2", "Sub_metering_3")

#Paste the Date and Time column together and format it
t <- paste(data$Date, data$Time)
data$Date <- strptime(t, "%d/%m/%Y %H:%M:%S")
data$Time <- NULL       #remove the Time column

#setting up the layout
png(filename = "plot4.png", height = 480, width = 480)
par(mfrow = c(2,2))
par(oma = c(0,0,0,0))
par(mar = c(5,4,3,2))

#top-left plot is the plot2
plot(data$Date, data$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = "")

#top-right plot
plot(data$Date, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

#bottom-left plot is the plot3
plot(data$Date, data$Sub_metering_1, type = "n",xlab = "", 
     ylab = "Energy sub metering")
points(data$Date, data$Sub_metering_1, type = "l")
points(data$Date, data$Sub_metering_2, type = "l", col = "red")
points(data$Date, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.95
       , bty = "n")

#bottom-right plot
plot(data$Date, data$Global_reactive_power, type = "l", ylab = 
         "Global_reactive_power", xlab = "datetime")
axis(2, at = c(0.1,0.3,0.5))
dev.off()
