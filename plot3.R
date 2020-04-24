#plot for each point type

# Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)
library(ggplot2)


#Filter by year
balt.yrtp.em <- NEI %>%
        filter(fips == "24510") %>%
        group_by(year, type) %>%    
        summarize(balt.yrtp.em = sum(Emissions, na.rm = TRUE)) 

#Initial call to ggplot
g <- ggplot(data = balt.yrtp.em, aes(year, balt.yrtp.em))

#printing and formatting plot
g+geom_point(color = "red", size = 5)+facet_grid(.~type)+   #reminder: alpha= .5 is way to make semi-transparent
        ggtitle("Total Baltimore Emissions by Year")+
        xlab("Year")+
        ylab("Emissions (tons)")+
        geom_smooth(method="lm")



#Save to PNG
png(file="plot3.png")
g <- ggplot(data = balt.yrtp.em, aes(year, balt.yrtp.em))
g+geom_point(color = "red", size = 5)+facet_grid(.~type)+   #reminder: alpha= .5 is way to make semi-transparent
        ggtitle("Total Baltimore Emissions by Year")+
        xlab("Year")+
        ylab("Emissions (tons)")+
        geom_smooth(method="lm")
dev.off() 