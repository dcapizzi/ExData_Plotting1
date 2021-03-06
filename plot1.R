# This file creates a single chart from the household power 
# consumption data set in the UCI Machine Learning Repository, summarizing data 
# for February 1-2, 2007. Variables analyzed are a histogram of Global Active Power variable.

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
png("plot1.png", width = 480, height = 480) # Set png file name / size

hist(as.numeric(subdata$Global_active_power), # Set histogram of global active power variable
     col="red", main = "Global Active Power", # Color the histogram red, set title
     xlab = "Global Active Power (kilowatts)", # Set x-axis
     ylim = c(0,1200), # Set y-axis
     cex.axis=.8) # Resize axis labels

# Turns off graphics device and saves image in working directory
dev.off()
