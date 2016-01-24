## plot5.R
## Requires "summarySCC_PM25.rds" and "Source_Classification_Code.rds" to be in the working directory
## depend on ggplot2

## Check if pm25 data are present in workspace and read it if not 
if (!"pm25" %in% ls()) {
      pm25 <- readRDS("summarySCC_PM25.rds")
}
## Check if scc_code data are present in workspace and read it if not
if (!"scc_code" %in% ls()) {
      scc_code<- readRDS("Source_Classification_Code.rds")  
}

## Subset data for Baltimore city
pm25_Baltimore <- subset( pm25,  pm25$fips == "24510" )

## For the exercise, Motor vehicle sources are defined as Mobile - On-Road from the SCC code EI.Sector

## subset Mobile On-Road (not Non-Road) from scc_code
onRoad <- unique( grep( "[^n]on-road", scc_code$EI.Sector, ignore.case = TRUE, value = TRUE) )

## subset scc_code for coal realted sources
scc_onRoad <- subset( scc_code, EI.Sector %in% onRoad)

## subset pm25_Baltimore based on SCC codes for motor vehicles
pm25_Baltimore_Motor <- subset( pm25_Baltimore, pm25_Baltimore$SCC %in% scc_onRoad$SCC )

## Create plot5.png using ggplot2 
library(ggplot2)
g <- ggplot( pm25_Baltimore_Motor, aes(x = as.factor(year), y = Emissions) ) + 
      geom_bar( stat = "summary", fun.y = "sum", position = "dodge" ) +  
      ggtitle( expression( "PM"[2.5]*" Emissions from motor vehicles in Baltimore City 1999-2008") ) +
      labs( x = "Year", y = expression('Total PM'[2.5]*" Emissions") ) 
## Export plot as png
png( filename = "plot5.png", width = 480, height = 480, units = "px" )
print(g)
dev.off()