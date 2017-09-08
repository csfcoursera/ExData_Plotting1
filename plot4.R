#Read text file
d <- read.table("household_power_consumption.txt", sep = ';', header = TRUE, stringsAsFactors = FALSE)
d$Global_active_power <- as.numeric(d$Global_active_power)
d$Sub_metering_1 <- as.numeric(d$Sub_metering_1)
d$Sub_metering_2 <- as.numeric(d$Sub_metering_2)
d$Sub_metering_3 <- as.numeric(d$Sub_metering_3)

#Create new field to combine date and time
d$DT <- paste(as.Date(d$Date, "%d/%m/%Y"), d$Time)
d$DT <- strptime(d$DT, "%Y-%m-%d %H:%M:%S")
d$Date <- as.Date(d$Date, "%d/%m/%Y")
d <- d[d$Date >= '2007-02-01', ]
d <- d[d$Date <= '2007-02-02',]

png(filename = c('plot4.png'))
par(mfrow = c(2,2))
plot(d$DT, y = d$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')

plot(d$DT, y = d$Voltage, type = 'l', xlab = 'dateTime', ylab = 'Voltage')

plot(d$DT, y = d$Sub_metering_1, type = 'l', xlab = '',
     ylab = 'Energy sub metering', 
     ylim = range(c(d$Sub_metering_1, d$Sub_metering_2, d$Sub_metering_3)))
lines(d$Sub_metering_2, col = 'red')
par(new = TRUE)
plot(d$DT, y = d$Sub_metering_2, type = 'l', xlab = '', axes = TRUE, col = 'red',
     ylab = 'Energy sub metering', 
     ylim = range(c(d$Sub_metering_1, d$Sub_metering_2, d$Sub_metering_3)))
par(new = TRUE)
plot(d$DT, y = d$Sub_metering_3, type = 'l', xlab = '', axes = FALSE, col = 'blue',
     ylab = 'Energy sub metering', 
     ylim = range(c(d$Sub_metering_1, d$Sub_metering_2, d$Sub_metering_3)))
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = 1, col = c('black', 'red', 'blue'))

plot(d$DT, y = d$Global_reactive_power, type = 'l', xlab = 'dateTime', ylab = 'Global_reactive_power')


dev.off()
