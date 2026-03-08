# Tomasz Puzio - 100904335
# 2026/02/09
# In-Class Activity
# Week 5

# ==============================================================================
# CLASS ACTIVITY: The Grammar of Graphics in Action (10 Mins)
# ==============================================================================

# INSTRUCTIONS:
# 1. Look for the '_______' blanks in the code below.
# 2. Replace them with the correct ggplot2 functions or variable names.
# 3. Run the code chunks to verify your plots look correct.

# ==============================================================================

# ------------------------------------------------------------------------------
# TASK 0: Setup
# ------------------------------------------------------------------------------

# We need to load our tools.
library(ggplot2)
library(dplyr) # Needed for the data joining task later

# ------------------------------------------------------------------------------
# TASK 1: The Warm Up (2 Minutes)
# ------------------------------------------------------------------------------

# GOAL: Create a basic scatterplot using the 'mpg' dataset.
# REQ:  Map Displacement (displ) to x, Highway Mileage (hwy) to y.
#       Color the points by Class (class).
# REF:  Slide 6 & 21

mpg

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = class)) + 
  geom_point() +
  labs(title = "Warm Up: MPG by Displacement")

# ------------------------------------------------------------------------------
# TASK 2: The Data Wrangling Challenge (4 Minutes)
# ------------------------------------------------------------------------------

# GOAL: Plot the body temperature of two beavers over time.
# PROBLEM: The data is split into two dataframes: 'beaver1' and 'beaver2'.
# REF:  Slide 22

# STEP A: Join the data
# Use bind_rows() to combine them.
# The '.id' argument creates a new column to distinguish beaver 1 from 2.

all_beavers <- bind_rows("Beaver 1" = beaver1, "Beaver 2" = beaver2, .id = "beaver_id")

# Check if it worked (you should see a 'beaver_id' column now)
head(all_beavers)

# STEP B: Visualize it
# - Use the combined 'all_beavers' data.
# - Map 'time' to x-axis.
# - Map 'temp' to y-axis.
# - Use 'beaver_id' to color the points so we can tell them apart.

ggplot(data = all_beavers, aes(x = time, y = temp, colour = beaver_id)) +
  geom_point() +
  labs(title = "Beaver Body Temperature Analysis",
       x = "Time of Observation",
       y = "Body Temp (C)")

# ------------------------------------------------------------------------------
# TASK 3: The "Geom" Challenge (2 Minutes)
# ------------------------------------------------------------------------------

# GOAL: The scatterplot above is hard to read. Let's try a different GEOM.
# REQ:  Instead of points, use a "Smooth" line to summarize the trend.

ggplot(all_beavers, aes(x = time, y = temp, colour = beaver_id)) +
  geom_smooth() +  # <--- Change this function to draw a smooth line
  labs(title = "Smoothed Trend of Beaver Temps")

# ------------------------------------------------------------------------------
# TASK 4: The "Aesthetics" Challenge (Bonus)
# ------------------------------------------------------------------------------

# GOAL: Recreate the 'Midwest' plot from the slides.
# DATA: 'midwest'
# REQ:  x = percprof (Percent Professional)
#       y = percchildbelowpovert (Percent Child Poverty)
#       color = inmetro (Is it a metro area?) -> WRAP THIS IN factor()!

ggplot(midwest, aes(x = percprof, y = percchildbelowpovert, colour = factor(inmetro))) +
  geom_point() +
  labs(x = "% Professional Degree", 
       y = "% Child Poverty",
       colour = "Metro Area")
