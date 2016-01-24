## plot2.R
## Requires "summarySCC_PM25.rds" to be in the working directory

## Check if data are present in workspace and read it if not 
if (!"pm25" %in% ls()) {
      pm25 <- readRDS("summarySCC_PM25.rds")
}

## Subset data for Baltimore city
pm25_Baltimore <- subset( pm25,  pm25$fips == "24510" )

## Compute total emissions for each year
pm25_Baltimore_sumByYear <- with( pm25_Baltimore, tapply( Emissions, year, sum, na.rm = TRUE ))

## Creates barplot as plot2.png
png( filename = "plot2.png", width = 480, height = 480, units = "px" )
barplot( pm25_Baltimore_sumByYear, names.arg = names( pm25_Baltimore_sumByYear ), 
         main = expression('Total PM'[2.5]*" Emissions by year in Baltimore"), 
         col  ="black", ylim = range(0, 4000), 
         ylab = expression('Total PM'[2.5]*" Emissions"), xlab = "Year" )
dev.off()
