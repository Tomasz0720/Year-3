# =============================================================================
# Lecture 21 - Maps 3: Joins & Electoral Choropleth Map
# CSCI 4210U - Information Visualization
# =============================================================================

# In this session, we will learn about:
#   1. Joins - how to combine two datasets based on a shared column (key)
#   2. Creating a choropleth electoral map of the 2016 US presidential election

# Load required libraries
library(tidyverse)    # Core data manipulation and visualization
library(maps)         # Provides map data (e.g., US states)
library(socviz)       # Contains the 'election' dataset
library(ggthemes)     # Extra themes for ggplot2, including theme_map()


# =============================================================================
# PART 1: Understanding Joins
# =============================================================================

# Why do we need joins?
# ---------------------
# Often the data we need is split across multiple tables/datasets.
# For example, one table has geographic coordinates (polygons for states),
# and another has electoral results. To visualize them together, we need
# to combine (join) the two tables using a shared column called a "key".


# --- Toy Dataset for Join Operations ---
# Let's create two small tables to understand how joins work.

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

# Take a look at both tables
x
y

# Notice:
#   - 'key' is the column we will use to match rows (the KEY)
#   - 'val_x' and 'val_y' are the data columns (the VALUES)
#   - Keys 1 and 2 appear in BOTH tables
#   - Key 3 appears ONLY in x
#   - Key 4 appears ONLY in y


# =============================================================================
# How Joins Work
# =============================================================================
# A join connects each row in x to zero, one, or more rows in y.
# You can think of each potential match as an intersection of a pair of lines.
# We use "dots" to indicate an actual match. The number of dots = the number
# of matches = the number of rows in the output.


# =============================================================================
# Inner Join
# =============================================================================
# An inner join keeps ONLY the rows where the key exists in BOTH tables.
# Rows with keys that don't match are dropped.

# join_by(key) explicitly tells the function which column to match on.
# By default, join functions look for columns with the same name,
# but it is best practice to be explicit using join_by().

inner_join(x, y, join_by(key))
inner_join(x, y)

# Result: Only keys 1 and 2 are kept (they exist in both x and y).
#   key = 3 is dropped (only in x)
#   key = 4 is dropped (only in y)


# =============================================================================
# Outer Joins
# =============================================================================
# Outer joins keep rows even when there is no match in the other table.
# These joins work by adding an additional "virtual" observation to each table.
# This virtual observation has a key that always matches (if no other key
# matches), and a value filled with NA.
# There are three types:

# --- Left Join ---
# Keeps ALL rows from the LEFT table (x), and brings in matching data from y.
# If there is no match in y, the y columns are filled with NA.
# This is the MOST COMMON join - use it as your default!

left_join(x, y, join_by(key))

# Result: All 3 rows from x are kept.
#   key = 3 has NA for val_y (no match in y)

# --- Right Join ---
# Keeps ALL rows from the RIGHT table (y), and brings in matching data from x.

right_join(x, y, join_by(key))

# Result: All 3 rows from y are kept.
#   key = 4 has NA for val_x (no match in x)

# --- Full Join ---
# Keeps ALL rows from BOTH tables.

full_join(x, y, join_by(key))

# Result: All 4 unique keys are kept.
#   key = 3 has NA for val_y
#   key = 4 has NA for val_x


# =============================================================================
# Joining with Different Column Names
# =============================================================================
# Sometimes the key columns in two tables have different names.
# Use join_by(col_in_x == col_in_y) to handle this.

# Example:
# left_join(x, y, join_by(x_key == y_key))


# =============================================================================
# Class Challenge: nycflights13
# =============================================================================
# Install the nycflights13 package if you don't have it:
# install.packages("nycflights13")

library(nycflights13)

# This package comes with 5 tables: airlines, airports, flights, planes, weather

# Step 1: Create a smaller tibble from flights with selected columns
flights2 <- flights |>
  select(year, time_hour, origin, dest, tailnum, carrier)

flights2
airlines

airports

# Step 2: Left join flights2 with airlines
# This adds the full airline name to each flight record

left_join(flights2, airlines)

# Step 3: Inner join flights2 with airports
# The 'dest' column in flights2 matches the 'faa' column in airports

inner_join(flights2, airports, join_by(dest == faa))


# =============================================================================
# PART 2: Electoral Choropleth Map
# =============================================================================

# Our goal: Create a choropleth map of the 2016 US presidential election,
# where each state is colored by the winning party.

# We have two datasets:
#   d_us      - contains lat/lon polygon data for US states (from maps package)
#   election  - contains 2016 electoral data (from socviz package)
# The problem: these datasets are NOT connected. We need to JOIN them.


# --- Step 1: Prepare the US state map data ---
d_us <- map_data("state") |>
  select(lon = long, lat, group, state = region) |>
  as_tibble()

# Let's take a look
d_us

# --- Step 2: Prepare the election data ---
# The election dataset has state names in Title Case (e.g., "Alabama"),
# but d_us has lowercase names (e.g., "alabama").
# Joins are CASE SENSITIVE, so we must convert to lowercase first.

election <- election |>
  mutate(state = str_to_lower(state))

# Check the result
election

# --- Step 3: Join the spatial and electoral data ---
# We use a left_join to keep ALL rows in d_us (so every polygon point is kept)
# and bring in the election data that matches.

d_us_elec <- left_join(d_us, election, join_by(state == state))

# Let's see what we have
d_us_elec


# --- Step 4: Create the choropleth electoral map ---

# Define party colours: blue for Democrat, red for Republican
party_colors <- c("#0000ff", "#ff0803")

# Build the map
ggplot(d_us_elec, aes(x = lon, y = lat, group = group, fill = party)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "gall", lat0 = 45) +
  scale_fill_manual(values = party_colors) +
  theme(legend.position = "bottom") +
  theme(plot.title = element_text(size = 22)) +
  ggtitle("2016 US presidential election, coloured by state-party win")

# Explanation of the code:
#   - aes(fill = party) : colors each state polygon by the winning party
#   - geom_polygon()    : draws the state polygons; gray90 border between states
#   - coord_map()       : applies the Gall-Peters projection for better shape
#   - scale_fill_manual(): maps party names to our custom blue/red colours

