library(data.table)
library(tidyverse)

if(!file.exists("./household_power_consumption.zip")){
        link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(link, "./household_power_consumption.zip")}

if(!file.exists("./household_power_consumption.txt")){
        zipF <- "./household_power_consumption.zip"
        #outDir <- "./"
        unzip(zipF)
        rm(list = ls())}

df <- fread("household_power_consumption.txt") %>% filter(Date %in% c("1/2/2007", "2/2/2007"))

df <- unite(df, DateTime, Date, Time, sep = " ")
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")
df[2:8] <- as.data.frame(lapply(df[2:8], as.numeric))

png(filename = "plot1.png", width = 480, height = 480)
hist(df$Global_active_power, main = "Global Active Power", 
          xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()