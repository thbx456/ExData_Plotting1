if(!dir.exists("/Users/tbaker/Desktop/ExData_Plotting1")){
        dir.create("/Users/tbaker/Desktop/ExData_Plotting1")
        setwd("/Users/tbaker/Desktop/ExData_Plotting1")
}
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

 plot(consumptiondata$Global_active_power ~ consumptiondata$Datetime, type = "l",
                           ylab = "Global Active Power (kilowatts)", xlab = "Datetime")
 dev.copy(png, file = "Plot2.png", height = 480, width = 480)
 dev.off()