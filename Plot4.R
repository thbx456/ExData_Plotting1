if(!file.exists("household_power_consumption.zip")){
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl, destfile = "household_power_consumption.zip",
                      method = "curl")
}
if(!file.exists("household_power_consumption.txt")){
        unzip("household_power_consumption.zip")
}

data <- read.table("household_power_consumption.txt", header = TRUE,
                   sep = ";", quote = '\"', na.strings = "?")

consumptiondata <- na.omit(subset(data, Date %in% c("1/2/2007" , "2/2/2007")))
consumptiondata$Date <- as.Date(consumptiondata$Date, format = "%d/%m/%Y")
consumptiondata$Global_active_power <- as.numeric(consumptiondata$Global_active_power)
datetime <- paste(as.Date(consumptiondata$Date), consumptiondata$Time)
consumptiondata$Datetime <- as.POSIXct(datetime)

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(consumptiondata, {
        plot(Global_active_power ~ Datetime, type = "l", 
             ylab = "Global Active Power (kilowatts)", xlab = "")
        plot(Voltage ~ Datetime, type = "l", 
             ylab = "Voltage (volts)", xlab = "")
        plot( Sub_metering_1 ~ Datetime, type = "l", col = "black", 
              ylab = " Energy sub metering", xlab = "datetime")
        lines(Sub_metering_2 ~ Datetime, col = "red")
        lines(Sub_metering_3 ~ Datetime, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty=1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power ~ Datetime, type = "l",
             ylab = "Global_Reactive_Power (kilowatts)", xlab = "")
})

dev.copy(png, file = "Plot4.png", height = 480, width = 480)
dev.off()