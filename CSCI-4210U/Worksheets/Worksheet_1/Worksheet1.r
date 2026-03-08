# 1. Load the libraries: readxl and tidyverse
# 2. Use read_xlsx() to load the data, skipping the first 5 lines of input (see ?read_xlsx) [1 pt]
# 3. Rename column 1 to ‘month’ and column 3 to ‘energy’. [1 pt]

library(readxl)
library(tidyverse)

data <- read_xlsx("bc_trade.xlsx", skip = 5) |>
  rename(month = 1, energy = 3)

