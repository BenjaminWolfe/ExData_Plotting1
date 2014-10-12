## get-data.R downloads, unzips, reads and subsets the data.
## it also creates the "datetime" field and defines a number
## of wrapper functions (they start with h) to simplify the graphics.

## on using external scripts, see note from Community TA Andre Miguel Monteiro
## at https://class.coursera.org/exdata-007/forum/thread?thread_id=19#post-276
## also CTA Steven Barkin at https://class.coursera.org/exdata-007/forum/thread?thread_id=18#post-85

## the source command ensures that all code from get-data.R is run here!
if(!exists("hpc")) source("get-data.R")

## open png, write to it and close.
## use transparent background; try to match margins
png("plot1.png", height = 480, width = 480)
par(bg = NA, mar = c(4, 4, 3, 2), mfrow = c(1, 1))
hist(Global_active_power
        , xlab = "Global Active Power (kilowatts)"
        , main = "Global Active Power"
        , col  = "red"
        )
dev.off()