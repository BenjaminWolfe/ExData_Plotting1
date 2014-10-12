## get-data.R downloads, unzips, reads and subsets the data.
## it also creates the "datetime" field and defines a number
## of wrapper functions (they start with h) to simplify the graphics.

## on using external scripts, see note from Community TA Andre Miguel Monteiro
## at https://class.coursera.org/exdata-007/forum/thread?thread_id=19#post-276
## also CTA Steven Barkin at https://class.coursera.org/exdata-007/forum/thread?thread_id=18#post-85

if(!exists("hpc")) source("get-data.R")

## open png, write to it and close.
## use transparent background; try to match margins
png("plot3.png", height = 480, width = 480)
par(bg = NA, mar = c(4, 4, 3, 2), mfrow = c(1, 1))
hplot(Sub_metering_1, col = "black", ylab = "Energy sub metering")
hlines(Sub_metering_2, col = "red")
hlines(Sub_metering_3, col = "blue")
hlegend(col = meter.colors, legend = meter.zones)
dev.off()