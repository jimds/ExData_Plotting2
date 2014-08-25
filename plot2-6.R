library(ggplot2)
## Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Find Vehicle-Related Emissions
SCCVeh<-SCC[with(SCC,grepl("[vV]eh*", Short.Name)),]

# subset data to Vehicle-Related Emissions
NEIVeh<-subset(NEI,NEI$SCC %in% SCCVeh[,1])
## open png file
png(filename = "plot2-6.png",width = 720)

## create new datframe containing totals for each city
ploydata<-data.frame("year"=character(),"type"=character(),"total"=numeric(),stringsAsFactors=FALSE)
for (y in unique(NEIVeh$year)){
    bdat<-subset(NEIVeh,NEIVeh$year==y&NEIVeh$fips == "24510")
    btotal<-sum(subset(bdat,bdat$type==t)$Emissions)
    btdat<-data.frame("year"=character(),"place"=character(),"total"=numeric(),stringsAsFactors=FALSE)
    btdat[1,1]<-y
    btdat[1,2]<-'Baltimore City'
    btdat[1,3]<-btotal
    ploydata<-rbind(ploydata,btdat)
    
    cdat<-subset(NEIVeh,NEIVeh$year==y&NEIVeh$fips == "06037")
    ctotal<-sum(subset(cdat,cdat$type==t)$Emissions)
    ctdat<-data.frame("year"=character(),"place"=character(),"total"=numeric(),stringsAsFactors=FALSE)
    ctdat[1,1]<-y
    ctdat[1,2]<-'Los Angeles County'
    ctdat[1,3]<-ctotal
    ploydata<-rbind(ploydata,ctdat)
       
    }

##plot against years
ggplot(data=ploydata, aes(x=year, y=total, group=place, color=place)) + geom_line()+geom_point()+labs(title = "Total Vehicle Related Emissions in Baltimore City and Los Angeles County 1999-2008") + labs( y = "Total Emissions")


## close png file
dev.off() 
