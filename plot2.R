# This file creates a single chart from the household power 
# consumption data set in the UCI Machine Learning Repository, summarizing data 
# for February 1-2, 2007. Variables analyzed are Global Active Power over date/time.

# Download and import the data

if (!file.exists("data")) {  # Checks to see if a "data" folder is in the working directory
      dir.create("data")     # If not, creates one
}

if (!file.exists("./data/data.zip")) {  # Checks to see if file is downloaded, if not downloads it
      
      fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileUrl, destfile = "./data/data.zip", method = "curl")
      dateDownloaded <- date()
      unzip("./data/data.zip", exdir = "./data")}

data <- read.csv("./data/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)

# Filter the data for February 1-2, 2007 and add date-time attribute for plots

subdata <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",] # Filters days to be analyzed

datetimestring <- paste(subdata$Date, subdata$Time) # Pastes date / time string together 
subdata$datetime <- strptime(datetimestring,"%d/%m/%Y %H:%M:%S") # Creates POSIXct datetime variable

# Sets plot details
png("plot2.png", width = 480, height = 480)

# Plot line graph with appropriate axes
plot(subdata$datetime,  # Y-variable is datetime 
     subdata$Global_active_power,  # X-variable is global active power
     type="l", 
     xlab="", 
     ylab= "Global Active Power (kilowatts)")

# Turns off graphics device and saves image in working directory
dev.off()
