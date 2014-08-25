library(ggplot2)
## Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png(filename = "plot2-3.png")
#create data frame based for totals per year and per a type
bytdata<-data.frame("year"=character(),"type"=character(),"total"=numeric(),stringsAsFactors=FALSE)
for (y in unique(NEI$year)){
    ydat<-subset(NEI,NEI$year==y&NEI$fips == "24510")
        for (t in unique(ydat$type)){
            total<-sum(subset(ydat,ydat$type==t)$Emissions)
            tdat<-data.frame("year"=character(),"type"=character(),"total"=numeric(),stringsAsFactors=FALSE)
            tdat[1,1]<-y
            tdat[1,2]<-t
            tdat[1,3]<-total
            bytdata<-rbind(bytdata,tdat)
        }
}
 
#plot totals
ggplot(data=bytdata, aes(x=year, y=total, group=type, color=type)) + geom_line()+geom_point()+labs(title = "Total Emission per Type Baltimore City 1999-2008") + labs( y = "Total Emissions")

dev.off() 