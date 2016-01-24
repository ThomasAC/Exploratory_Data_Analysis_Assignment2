## plot4.R
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

## Identify coal related sources from scc_code
coal <- unique( grep( "coal", scc_code$EI.Sector, ignore.case = TRUE, value = TRUE) )
## subset scc_code for coal realted sources
scc_coal <- subset( scc_code, EI.Sector %in% coal)
## subset pm25 based on SCC oces for coal related sources
pm25_coal <- subset( pm25, pm25$SCC %in% scc_coal$SCC )

## Create plot4.png using ggplot2
library(ggplot2)
g <-ggplot( pm25_coal, aes(x = as.factor(year), y = Emissions) ) + 
      geom_bar( stat = "summary", fun.y = "sum", position = "dodge" ) +  
      ggtitle( expression( "PM"[2.5]*" Emissions in US from (Coal Combustion Sources) 1999-2008") ) +
      labs( x = "Year", y = expression('Total PM'[2.5]*" Emissions") ) 
## Export plot as png
png( filename = "plot4.png", width = 480, height = 480, units = "px" )
print(g)
dev.off()
