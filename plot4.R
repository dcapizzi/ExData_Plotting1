# This file creates a 4-caption plot of data from the household power 
# consumption data set in the UCI Machine Learning Repository, summarizing data 
# for February 1-2, 2007. Variables analyzed are Global Active Power, Voltage, 
# entergy submetering, and global reactive power.

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

# Sets plot details and canvas of 4 plotting elements
png("plot4.png", width = 480, height = 480)  # Set png file name / size
par(mfrow=c(2,2)) # Sets canvas of 4 plots (2x2)

# Plot 1: Global Active Power line graph over datetime

with(subdata, 
     plot(datetime, 
     Global_active_power, 
     type="l", 
     xlab="", 
     ylab= "Global Active Power")
      )

# Plot 2: Voltage line chart over datetime
with(subdata,
     plot(datetime, 
          Voltage, 
          type="l")
)

# Plot 3: Engery Submetering

with(subdata,  # Creates plot of variable 1 in black
     plot(datetime,
          Sub_metering_1,
          type="l",
          xlab = "",
          ylab= "Energy sub metering")
)

with(subdata, # Adds plot of variable 2 in red
     lines(datetime,
           Sub_metering_2,
           col="red")
)

with(subdata, # Adds plot of variable 3 in blue
     lines(datetime,
           Sub_metering_3,
           col="blue")
)

legend("topright", # Adds legend in top right
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1,1,1),
       bty = "n"
)

# Plot 4: Global reactive power
with(subdata,  # Adds plot of Global reactive power
     plot(datetime, 
          Global_reactive_power, 
          type="l")
)

# Turns off graphics device and saves image in working directory
dev.off()