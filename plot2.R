##  Create plot2.png 

# Check working directory and set it to a proper path to carry out assignment work 
getwd()
setwd("./Coursera- Data Science Specilization/Exploratory_Analysis")

# Include all required packages through library function
library(lubridate)
library(dplyr)

# check to see if the existing tidy data set exists; if not, make it...
if (!file.exists('./power_consumption_dir/household_power_consumption.txt')) {
  
  # download the source file from the provided link and unzip it
  fileUrl<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(fileUrl, destfile='./power_consumption.zip')
  unzip('./power_consumption.zip',exdir='power_consumption_dir',overwrite=TRUE)
} else print("File already exist. ")

## Read power consumption data file into a dataframe variable

file_name <- './power_consumption_dir/household_power_consumption.txt'
pc_df <- read.table(text = grep("^[1,2]/2/2007", readLines(file_name), value = TRUE), 
                    col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
                                  "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)


# Generating second hist to show relationship between Gloabl active power  
pc_dt <- tbl_df(pc_df)
pc_dt_1 <- pc_dt %>% mutate(date_tm = ymd_hms(paste(as.Date(pc_df$Date, format = "%d/%m/%Y"), Time)))

plot(pc_dt_1$Global_active_power ~ pc_dt_1$date_tm, type = "l", 
     ylab = "Global Active Power (Kilowatts", xlab = "")


dev.copy(png, file = "plot2.png")
dev.cur()
dev.off()
