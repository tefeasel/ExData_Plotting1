setwd()

library(dplyr)

unzip("household_power_consumption.zip")

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                   stringsAsFactors = FALSE, na.strings = "?")
str(data)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data2 <- filter(data, Date >= "2007-02-01" & Date  <= "2007-02-02")
data2[,c(3:9)] <- apply(data2[,c(3:9)], 2, function(x) as.numeric(x))
data2$DateTime <- strptime(paste(data2$Date, data2$Time, sep = ""),
                           format = "%Y-%m-%d%H:%M:%S")

#Plot4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
#Top left [1,1]
plot(data2$DateTime, data2$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
#Top right [1, 2]
plot(data2$DateTime, data2$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
#Bottom left [2, 1]
plot(data2$DateTime, data2$Sub_metering_1, col = "black", type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(data2$DateTime, data2$Sub_metering_2, col = "red", type = "l")
lines(data2$DateTime, data2$Sub_metering_3, col = "blue", type = "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)
#Bottom right [2,2]
plot(data2$DateTime, data2$Global_reactive_power, xlab = "datetime", type = "l",
     ylab = "Global_reactive_power")
dev.off()