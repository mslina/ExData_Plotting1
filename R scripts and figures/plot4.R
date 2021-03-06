library(data.table)
library(tidyverse)

if(!file.exists("./household_power_consumption.zip")){
        link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(link, "./household_power_consumption.zip")}

if(!file.exists("./household_power_consumption.txt")){
        zipF <- "./household_power_consumption.zip"
        unzip(zipF)
        rm(list = ls())}

df <- fread("household_power_consumption.txt") %>% filter(Date %in% c("1/2/2007", "2/2/2007"))

df <- unite(df, DateTime, Date, Time, sep = " ")
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")
df[2:8] <- as.data.frame(lapply(df[2:8], as.numeric))

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

plot(df$DateTime, df$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")
plot(df$DateTime, df$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")
plot(df$DateTime, df$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering"); 
        lines(df$DateTime, df$Sub_metering_2, col = "red"); 
        lines(df$DateTime, df$Sub_metering_3, col = "blue"); 
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
                                    "Sub_metering_3"),
               col=c("black","red", "blue"), lty = 1, cex = 0.9, bty = "n")
plot(df$DateTime, df$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off()