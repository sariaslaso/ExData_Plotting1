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


# plot 2

png(filename = "plot2.png", width = 480, height = 480)
with(data, plot(DateAndTime, Global_active_power, type = "l", 
                xlab = "", 
                ylab = "Global Active Power (kilowatts)"))

dev.off()