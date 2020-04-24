##Baltimore City, Maryland (fips == "24510")

# Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#using dplyr to get data frame in correct format
library(dplyr)

# summarize with dplyr
balt.embyyr <- NEI %>%  # specify dataframe
        filter(fips == "24510") %>%    #filter on Baltimore, don't forget %>% that's was passes info to next lines
        group_by(year) %>%     # Outputs full df, but orders df by year, makes groups "around" years in NEI
        summarize(balt.embyyr = sum(Emissions, na.rm = TRUE))   


#build plot by year
plot(balt.embyyr, main="Total Recorded Baltimore pm25 Emissions", ylab ="Emissions (tons)", xlab="Year", lwd=10, col="green")


#Save to PNG
png(file="plot2.png")
plot(balt.embyyr, main="Total Recorded Baltimore pm25 Emissions", ylab ="Emissions (tons)", xlab="Year", lwd=10, col="green")
dev.off() 
