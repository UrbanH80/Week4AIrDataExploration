#Initial data download
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile <- "download.zip"

if(!file.exists(destfile)) {
        download.file(url, 
                      destfile = destfile, 
                      method = "curl")
        unzip(destfile, exdir = ".")
}



## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#using dplyr to get data frame in correct format
library(dplyr)

# summarize with dplyr
EmbyYr <- NEI %>%  # specify dataframe
        group_by(year) %>%     # Outputs full df, but orders df by year, makes groups "around" years in NEI
        summarize(EmbyYr = sum(Emissions, na.rm = TRUE))    # creates dataframe with var Emissions and group_by variable (obs are years)
                                                            # note: can only pass one value to summarize, ie need sum or other ftn

#build plot by year
plot(EmbyYr, main="Total Recorded USA pm25 Emissions", ylab ="Emissions (tons)", xlab="Year", lwd=10, col="green")


#Save to PNG
png(file="plot1.png")
plot(EmbyYr, main="Total Recorded USA pm25 Emissions", ylab ="Emissions (tons)", xlab="Year", lwd=10, col="green")
dev.off() 