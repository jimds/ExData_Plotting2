## Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Find Vehicle-Related Emissions
SCCVeh<-SCC[with(SCC,grepl("[vV]eh*", Short.Name)),]

# subset data to Vehicle-Related Emissions
NEIVeh<-subset(NEI,NEI$SCC %in% SCCVeh[,1])
## open png file
png(filename = "plot2-5.png")


## plot totals against years
plot(unique(NEIVeh$year),sapply(unique(NEIVeh$year),function(x){sum(subset(NEIVeh,NEIVeh$year==x&NEIVeh$fips == "24510")$Emissions)}),type='l',xlab='Year',ylab='Total Emissions', main='Total Vehicle Related Emissions in Baltimore City 1999-2008')
## close png file
dev.off() 
