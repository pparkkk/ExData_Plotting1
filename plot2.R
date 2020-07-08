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

#line graph
png(filename = "plot2.png", height = 480, width = 480)
plot(data$Date, data$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()