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
with(consumptiondata, { 
        plot( Sub_metering_1 ~ Datetime, type = "l", col = "black", 
     ylab = " Energy sub metering", xlab = "")
        lines(Sub_metering_2 ~ Datetime, col = "red")
        lines(Sub_metering_3 ~ Datetime, col = "blue")
        })
legend("topright", col = c("black", "red", "blue"), lty=1, lwd = 2, 
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "Plot3.png", height = 480, width = 480)
dev.off()