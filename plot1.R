#Read text file
d <- read.table("household_power_consumption.txt", sep = ';', header = TRUE, stringsAsFactors = FALSE)
d$Global_active_power <- as.numeric(d$Global_active_power)

#Create new field to combine date and time
d$DT <- paste(as.Date(d$Date, "%d/%m/%Y"), d$Time)
d$DT <- strptime(d$DT, "%Y-%m-%d %H:%M:%S")
d$Date <- as.Date(d$Date, "%d/%m/%Y")
d <- d[d$Date >= '2007-02-01', ]
d <- d[d$Date <= '2007-02-02',]

png(filename = c('plot1.png'))
hist(d$Global_active_power, xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power', col = 'red')
dev.off()
