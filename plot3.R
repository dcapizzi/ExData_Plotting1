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
png("plot3.png", width = 480, height = 480)

with(subdata, # Creates plot of variable 1 in black
     plot(datetime,
          Sub_metering_1,
          type="l",
          xlab = "",
          ylab= "Energy sub metering")
     )

with(subdata,  # Adds plot of variable 2 in red
      lines(datetime,
            Sub_metering_2,
            col="red")
      )

with(subdata, # Adds plot of variable 3 in blue
     lines(datetime,
            Sub_metering_3,
            col="blue")
     )

legend("topright",  # Adds legend in top right
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1,1,1)
       )

# Turns off graphics device and saves image in working directory
dev.off()