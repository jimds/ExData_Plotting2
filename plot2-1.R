## Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## open png file
png(filename = "plot2-1.png")
## plot totals against years
plot(unique(NEI$year),sapply(unique(NEI$year),function(x){sum(subset(NEI,NEI$year==x)$Emissions)}),type='l',xlab='Year',ylab='Total Emissions', main='Total Emissions 1999-2008')
## close png file
dev.off() 