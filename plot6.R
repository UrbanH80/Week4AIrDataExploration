# Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)
library(ggplot2)

#get NEI with only motor vehicles
SCC.mov <- SCC[grep("[Vv]ehicle",SCC$EI.Sector),]   #grep for finding motor vehicle values
NEI.mov <- subset(NEI, NEI$SCC %in% SCC.mov$SCC)  #subsetting NEI for rows in NEI that are also in SCC.mov


#Filter by year Baltimore
mov.em.b <- NEI.mov %>%
        filter(fips == "24510") %>%
        group_by(year) %>%    
        summarize(sumEmissions = sum(Emissions, na.rm = TRUE)) 
mov.em.b <- cbind(mov.em.b, "City" = rep("Baltimore", 4))  #adding city variable


#Filter by year Los Angeles
mov.em.LA <- NEI.mov %>%
        filter(fips == "06037") %>%
        group_by(year) %>%    
        summarize(sumEmissions = sum(Emissions, na.rm = TRUE))         
mov.em.LA <- cbind(mov.em.LA, "City" = rep("Los Angeles", 4))    #adding city variable
        
#combine B and LA summaries
com <- rbind(mov.em.b, mov.em.LA)
   
#Initial call to ggplot
g <- ggplot(data = com, aes(year, sumEmissions, col=City))

#print and format ggplot
g + geom_point(size = 5, alpha = .5)+
        geom_smooth(method="lm")+
        xlab("Year")+
        ylab("Emissions (tons)")+
        ggtitle("Motor Vehicle Emissions")+
        theme(legend.position="top")


dev.copy(png, "plot6.png")
dev.off()

#Save to PNG   #####TURNED OFF, TRYING SHORTHAND METHOD
#png(file="plot6.png")
#g <- ggplot(data = com, aes(year, sumEmissions, col=City))
#g + geom_point(size = 5, alpha = .5)+
#        geom_smooth(method="lm")+
#        xlab("Year")+
#        ylab("Emissions (tons)")+
#        ggtitle("Motor Vehicle Emissions")+
#        theme(legend.position="bottom")
#dev.off() 