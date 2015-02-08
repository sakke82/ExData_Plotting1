library(dplyr)
# read data from file
bigData <- read.table('./data/exdata_data_household_power_consumption/household_power_consumption.txt', sep = ';', header = TRUE,
                      na.strings = '?')

# change language to english 
Sys.setlocale("LC_TIME", "English") 

# convert variables Date and Time to POSIXct variable DateTime, and add this new to data frame
DateTime <- paste(bigData$Date, bigData$Time)
DateTime <- strptime(DateTime, ' %d/%m/%Y %H:%M:%S')
data <- cbind(DateTime, bigData)

data <- filter(data, DateTime > '2007-02-01') # filter by date
data <- filter(data, DateTime < '2007-02-03')
rm(bigData, DateTime) # remove all unnecessary tables from environment

# create plots and save it as plot4.png
png('plot4.png')
par(mfrow=c(2,2))
plot(data$DateTime, data$Global_active_power, type='o', pch = '.', ylab = 'Global Active Power', xlab='')
plot(data$DateTime, data$Voltage, type='o', pch = '.', ylab='Voltage',xlab='datetime')
plot(data$DateTime,data$Sub_metering_1, type='o', pch='.', xlab = '', ylab = 'Energy Sub metering')
lines(data$DateTime,data$Sub_metering_2, type='o', pch='.', xlab = '', ylab = 'Energy Sub metering', col = 'red')
lines(data$DateTime,data$Sub_metering_3, type='o', pch='.', xlab = '', ylab = 'Energy Sub metering', col = 'blue')
legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col = c('black','red','blue'), lty=1)
plot(data$DateTime, data$Global_reactive_power, type='o', pch='.', xlab='datetime', ylab='Global_reactive_power')
dev.off()