## plot3.R
## Requires "summarySCC_PM25.rds" to be in the working directory
## depend on ggplot2

## Check if data are present in workspace and read it if not 
if (!"pm25" %in% ls()) {
      pm25 <- readRDS("summarySCC_PM25.rds")
}

## Subset data for Baltimore city
pm25_Baltimore <- subset( pm25,  pm25$fips == "24510" )

## create barplot plot3.png using ggplot2
library(ggplot2)
g <- ggplot( pm25_Baltimore, aes(x = as.factor(year), y = Emissions, fill = type) ) + 
      geom_bar( stat = "summary", fun.y = "sum", position = "dodge" ) +
      scale_fill_manual( values=c("steelblue", "yellow2", "springgreen", "violetred")) +      
      ggtitle( expression( "PM"[2.5]*" Emissions in Baltimore per type from 1999 to 2008") ) +
      labs( x = "Year", y = expression('Total PM'[2.5]*" Emissions") ) 

## Export plot as png
png( filename = "plot3.png", width = 480, height = 480, units = "px" )
print(g)
dev.off()
