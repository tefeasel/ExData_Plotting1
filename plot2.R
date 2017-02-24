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

#Plot2
png("plot2.png", width = 480, height = 480)
plot(data2$DateTime, data2$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()