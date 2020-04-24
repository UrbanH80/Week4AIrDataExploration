# Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)
library(ggplot2)

#get NEI with only motor vehicles
SCC.mov <- SCC[grep("[Vv]ehicle",SCC$EI.Sector),]   #grep for finding motor vehicle values
NEI.mov <- subset(NEI, NEI$SCC %in% SCC.mov$SCC)  #subsetting NEI for rows in NEI that are also in SCC.mov


#Filter by year
mov.em <- NEI.mov %>%
        group_by(year) %>%    
        summarize(sumEmissions = sum(Emissions, na.rm = TRUE)) 


#Initial call to ggplot
g <- ggplot(data = mov.em, aes(year, sumEmissions))

#printing and formatting plot
g+geom_point(color = "red", size = 5)+   #reminder: alpha= .5 is way to make semi-transparent
        ggtitle("Emissions from Motor Vehicles")+
        xlab("Year")+
        ylab("Emissions (tons)")+
        geom_smooth(method="lm")


#Save to PNG
png(file="plot5.png")
g <- ggplot(data = mov.em, aes(year, sumEmissions))
g+geom_point(color = "red", size = 5)+   #reminder: alpha= .5 is way to make semi-transparent
        ggtitle("Emissions from Motor Vehicles")+
        xlab("Year")+
        ylab("Emissions (tons)")+
        geom_smooth(method="lm")
dev.off() 