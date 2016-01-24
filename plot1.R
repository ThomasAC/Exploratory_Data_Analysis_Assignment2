## plot1.R 

## Requires "summarySCC_PM25.rds" to be in the working directory
## Check if data are present in workspace and read it if not 
if (!"pm25" %in% ls()) {
      pm25 <- readRDS("summarySCC_PM25.rds")
}

## Compute total emissions for each year
pm25_sumByYear <- with( pm25, tapply( Emissions, year, sum, na.rm = TRUE ))

## Creates barplot as plot1.png
png( filename = "plot1.png", width = 480, height = 480, units = "px" )
barplot( pm25_sumByYear, names.arg = names( pm25_sumByYear), 
         main = expression("Total PM"[2.5]*" Emissions by Year"), 
         col  ="black", ylim = range(0, 8e6), 
         ylab = expression("Total PM"[2.5]*" Emissions"), xlab = "Year" )
dev.off()