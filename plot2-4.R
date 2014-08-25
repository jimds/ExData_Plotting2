## Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Find Coal Combuston-Related Emissions
SCCComb<-SCC[with(SCC,grepl("[Cc]oal", Short.Name)&grepl("[Cc]ombustion", Short.Name)),]

# subset data to coal combuston-related emissions
NEICoal<-subset(NEI,NEI$SCC %in% SCCComb[,1])
## open png file
png(filename = "plot2-4.png")


## plot totals against years
plot(unique(NEICoal$year),sapply(unique(NEICoal$year),function(x){sum(subset(NEICoal,NEICoal$year==x)$Emissions)}),type='l',xlab='Year',ylab='Total Emissions', main='Total Coal Combuston-Related Emissions 1999-2008')
## close png file
dev.off() 