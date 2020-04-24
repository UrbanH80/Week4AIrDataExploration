# Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)
library(ggplot2)

#get NEI with only coal, also convert year to Factor
SCC.coal <- SCC[grep("[Cc]oal",SCC$EI.Sector),]   #grep for finding Coal values
NEI.coal <- subset(NEI, NEI$SCC %in% SCC.coal$SCC)  #subsetting NEI for rows in NEI that are also in SCC.coal


#Filter by year
us.em <- NEI.coal %>%
        group_by(year) %>%    
        summarize(sumEmissions = sum(Emissions, na.rm = TRUE)) 


#Initial call to ggplot
g <- ggplot(data = us.em, aes(year, sumEmissions))

#printing and formatting plot
g+geom_point(color = "red", size = 5)+   #reminder: alpha= .5 is way to make semi-transparent
        ggtitle("Emissions from coal combustion-related sources")+
        xlab("Year")+
        ylab("Emissions (tons)")+
        geom_smooth(method="lm")


#Save to PNG
png(file="plot4.png")
g <- ggplot(data = us.em, aes(year, sumEmissions))
g+geom_point(color = "red", size = 5)+   #reminder: alpha= .5 is way to make semi-transparent
        ggtitle("Emissions from coal combustion-related sources")+
        xlab("Year")+
        ylab("Emissions (tons)")+
        geom_smooth(method="lm")
dev.off() 