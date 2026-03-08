# Tomasz Puzio - 100904335

# 1
# Load the libraries: readxl and tidyverse.
library(readxl)
library(tidyverse)

# 2-3
# Use read_xlsx() to load the data, skipping the first 5 lines of input.
# Rename column 1 to ‘month’ and column 3 to ‘energy’.
data <- read_xlsx("bc_trade.xlsx", skip = 5) |> 
  rename(month = 1, energy = 3)

# 4
# Create a vector of colour codes. Set months matching June, July, and August to “firebrick”, and all other months to “#cccccc”.
colours <- ifelse(data$month %in% c("Jun", "Jul", "Aug"),
                  "firebrick", "#cccccc")

# 5
# Using Base R graphics only, create a bar graph of the energy column, using Month as x-values. Give your chart a title andlabel both axes. Use the colour codes from #4 to colour your bars and set bar spacing to 0. Set the border to NA. Your final graphic should look like Figure 1 below.
barplot(data$energy,  
        names.arg = data$month, 
        main = "British columbia Energy exports", 
        xlab = "Month", 
        ylab = "Exports ($ thousands)", 
        col = colours, 
        space = 0,
        border = NA)