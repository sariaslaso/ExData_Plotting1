library(dplyr)
library(lubridate)
library(datasets)

# reading the data

file <- "household_power_consumption.txt"

# We will only be using data from the dates 2007-02-01 and 2007-02-02. One 
# alternative is to read the data from just those dates rather than reading in 
# the entire dataset and subsetting to those dates.

power_consumption_data <-read.csv(file, sep = ";", stringsAsFactors = FALSE, 
                                  na.strings = "?")

red_power_data <- filter(power_consumption_data, 
                         Date == "1/2/2007" | Date == "2/2/2007")

complete <- complete.cases(red_power_data)

data <- red_power_data[complete,] %>%
    mutate(DateAndTime = dmy_hms(paste(Date, Time)))



# plot 3

png(filename = "plot3.png", width = 480, height = 480)

plot(data$DateAndTime, data$Sub_metering_1, type = "l", 
     ylim = c(0, max(data$Sub_metering_1, data$Sub_metering_2)), 
     xlab = "", ylab = "Energy sub metering")
lines(data$DateAndTime, data$Sub_metering_2, type = "l", col = "red")
lines(data$DateAndTime, data$Sub_metering_3, type = "l", col = "blue")

legend("topright",
       col = c("black", "red", "blue"), lty = "solid", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
       #cex = 1.3, text.width = 0.05
)

dev.off()


