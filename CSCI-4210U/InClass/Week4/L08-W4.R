# ==============================================================================
# CSCI 4210U - Information Visualization: Introduction to Tidyverse
# ==============================================================================
# This script covers Lecture 08 concepts:
# 1. Tidy Data (Structure and Rules)
# 2. Tibbles (The modern data frame)
# 3. dplyr (The grammar of data manipulation)
#    - filter(), arrange(), select(), mutate()
# ==============================================================================

# Prerequisites: We need the tidyverse package loaded.
if(!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)

# ==============================================================================
# PART 1: Tidy Data
# ==============================================================================
# Tidy data is a consistent way to organize tabular data
# The three rules of tidy data are
# 1. Every column is a variable.
# 2. Every row is an observation.
# 3. Every cell is a single value.

# Example: The 'diamonds' dataset
# This is a built-in dataset in ggplot2 (part of tidyverse).
# It follows tidy principles:
#  Columns like 'carat', 'cut', 'price' are variables
#  Rows represent specific individual diamonds (observations)
#  Cells contain single values (e.g., the carat of the 2nd diamond)

print("--- Head of Diamonds Dataset ---")
print(head(diamonds))


# ==============================================================================
# PART 2: Tibbles
# ==============================================================================
# A "tibble" (tbl_df) is a modern reimagining of the data.frame
# It keeps the good parts of data frames but discards annoying features.
#
# Key differences
# 1. It doesn't change variable names or types automatically.
# 2. It doesn't do partial matching.
# 3. It complains more (e.g., if a variable doesn't exist), helping you catch bugs.
# 4. It has an enhanced print() method (shows types like <dbl>, <ord>)

# Checking classes 
print("--- Class Checks ---")
print(class(diamonds))      # Shows "tbl_df", "tbl", "data.frame"
print(is_tibble(diamonds))  # Returns TRUE


# ==============================================================================
# PART 3: Coding Challenge 1 (Setup)
# ==============================================================================
print("--- Coding Challenge 1 ---")
# Task:
# 1. Install the package "nycflights13"
# 2. Load the package
# 3. View the help docs

# Solution:
if(!require(nycflights13)) install.packages("nycflights13")
library(nycflights13)

# Let's look at the 'flights' tibble from this package
# Notice the shorthand for column types: <int> (integer), <dbl> (double), <chr> (string) 
?flights
print(flights)

# Printing tips: You can specify how many rows to print
print(flights, n = 5)


# ==============================================================================
# PART 4: dplyr - The Grammar of Data Manipulation
# ==============================================================================
# dplyr provides "verbs" to solve data manipulation challenges
# We will cover: filter, arrange, select, and mutate.

# ------------------------------------------------------------------------------
# VERB 1: filter() - Operates on Rows
# ------------------------------------------------------------------------------
# filter() picks observations (rows) based on their values
# Syntax: filter(data, expression)

# Example: Filter flights by month and day (Jan 1st) 
jan1_flights <- filter(flights, month == 1, day == 1)
print("--- Flights on Jan 1st ---")
print(jan1_flights)

# --- Coding Challenge 2 ---
print("--- Coding Challenge 2 ---")
# Task: Print flights in January that occurred after the 15th

# Solution
# We use a logical expression: month == 1 AND day > 15
challenge2 <- filter(flights, month == 1, day > 15)
print(head(challenge2))
challenge3 <- filter(flights, month == 1 | day > 15)

# (Nov OR Dec) AND (Late Arrival)
filter(flights, (month == 11 | month == 12) & arr_delay > 0)



# ------------------------------------------------------------------------------
# VERB 2: arrange() - Operates on Rows
# ------------------------------------------------------------------------------
# arrange() changes the ordering of the rows
# If you provide multiple columns, subsequent columns break ties

# Example: Arrange by year, then month, then day 
sorted_flights <- arrange(flights, year, month, day)

# Example: Reverse sorting using desc() 
rev_sorted_flights <- arrange(flights, desc(day))
print("--- Flights sorted by day descending ---")
print(head(rev_sorted_flights))


# ------------------------------------------------------------------------------
# VERB 3: select() - Operates on Columns
# ------------------------------------------------------------------------------
# select() picks variables (columns) based on their names
# It is useful for narrowing down a wide dataset.

# Example: Select specific columns 
selected <- select(flights, year, month, day)

# Example: Select a range of columns using ':' 
range_selected <- select(flights, year:day)

# Example: Select everything EXCEPT a range using '!' 
not_dates <- select(flights, !(year:day))
print("--- Flights without date columns ---")
print(head(not_dates))


# ------------------------------------------------------------------------------
# VERB 4: mutate() - Operates on Columns
# ------------------------------------------------------------------------------
# mutate() adds new variables that are functions of existing variables
# By default, it adds new columns at the end of the dataset

# First, let's create a smaller dataset so we can see the results easier 
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
flights_sml

# Example: Calculate 'gain' (time made up in air) and 'speed' 
# Note: You can refer to new variables (like 'gain' or 'hours') immediately inside 
# the same mutate call
mutated_flights <- mutate(flights_sml,
                          gain = arr_delay - dep_delay,
                          hours = air_time / 60,
                          gain_per_hour = gain / hours
)

print("--- Mutated Flights (see end columns) ---")
print(head(mutated_flights))


# ==============================================================================
# PART 5: Coding Challenge 3 (Putting it all together)
# ==============================================================================
print("--- Coding Challenge 3 ---")
# Task []
# 1. Return subset of flights by carriers: Hawaiian (HA), Delta (DL), US Airways (US).
# 2. From these, keep only columns: carrier, origin, dest, and any column containing "time".
# 3. Confirm the final tibble size is 68988 x 9

# Solution
# We use the pipe operator |> to chain the filter and select commands together.
# %in% checks if the value exists in the list c("HA", "DL", "US").

flight_hdu <- filter(flights, carrier %in% c("HA", "DL", "US")) |>
  select(carrier, origin, dest, contains("time"))

# Check dimensions
print("--- Dimensions of Challenge 3 Result ---")
print(dim(flight_hdu)) # Should be 68988 x 9 
