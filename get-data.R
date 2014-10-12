## packages
rm(list = ls())
if(!require("data.table")) install.packages("data.table"); library(data.table)
if(!require("lubridate" )) install.packages("lubridate" ); library(lubridate )

## parameters
download.from <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    data.dir  <- "data"
download.to   <- "household_power_consumption.zip"
   unzip.to   <- "household_power_consumption.txt"

## full file paths
unzip.from <- file.path(data.dir, download.to)
 read.from <- file.path(data.dir,    unzip.to)

## create file structure
if(!file.exists( data.dir )) dir.create(data.dir)
if(!file.exists(unzip.from)) download.file(download.from, unzip.from)
if(!file.exists( read.from)) unzip(unzip.from, exdir = data.dir)

## hpc: household power consumption. if it already exists, skip this.
if(!exists("hpc")) {

        ## determine rows to skip.
        ## see tip from Niels Kierulf at https://class.coursera.org/exdata-007/forum/thread?thread_id=19#post-182
        ## here using the fabulous lubridate package for dates:
        ## http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html
        start     <- fread(read.from, nrows = 1)
        skip.from <- dmy_hms(paste(start$Date, start$Time))
        skip.to   <- ymd("2007-02-01")
        skip.rows <- interval(skip.from, skip.to) / dminutes(1) + 1
        
        ## read data, set names and parse datetimes.
        ## here as before, using the data.table package to read and manipulate data.
        hpc <- fread(
                  read.from
                , skip = skip.rows
                , nrows = 60 * 24 * 2
                , header = F
                , na.strings = "?"
                , stringsAsFactors = F
                )
        setnames(hpc, names(start))
        hpc[, datetime:=dmy_hms(paste(Date, Time))]
        
        ## clean up date / import temp variables
        rm(list = c("start", "skip.from", "skip.to", "skip.rows"))
}

## attach hpc and clean up variables
attach(hpc)
rm(list = c("data.dir", "download.from", "download.to", "read.from"
        , "unzip.from", "unzip.to")
)

## create lists of meter zones and standard colors for legends
meter.zones  <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
meter.colors <- c("black", "red", "blue")

## create wrapper functions with default values, to tidy up graphics code
hplot  <- function(..., xlab = "") plot(..., x = hpc$d, type = "l", xlab = xlab)
hlines <- function(...) lines(..., x = hpc$datetime)
hlegend<- function(...) legend(..., x = "topright", lty = 1)