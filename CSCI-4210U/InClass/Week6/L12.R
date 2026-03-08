# ==============================================================================
# LECTURE 12: Time series, Axes, and Scales 
# Topics: Bar graphs, Time series, Axes, Output, Scales 
# ==============================================================================

library(ggplot2)
library(dplyr)
library(tibble)

# ------------------------------------------------------------------------------
# 1. BAR GRAPHS 
# Bar graphs come in two flavors. The first expects you to have unsummarized data.
# The other expects you to have summarized data.
# ------------------------------------------------------------------------------

# Unsummarized: each observation contributes one unit to the height (count) .
# Example using the diamonds dataset with cut .
ggplot(diamonds, aes(x = cut)) +
  geom_bar() +
  ggtitle("Unsummarized bar plot: diamonds by cut") 

# Summarized: expects that y contains counts, means, etc. 
diamonds_summary <- diamonds |> count(cut, name = "n") 
diamonds_summary

ggplot(diamonds_summary, aes(x = cut, y = n)) +
  geom_bar(stat = "identity") +
  ggtitle("Summarized bar plot: diamonds by cut") 

# Stacked, filled, and dodged bar charts.
ggplot(diamonds, aes(x = cut, fill = clarity)) +
  geom_bar() +
  ggtitle("Stacked bar chart: cut by clarity") 
#good or bad?

ggplot(diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "fill") +
  ggtitle("Filled bar chart (proportions): cut by clarity")

ggplot(diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge") +
  ggtitle("Dodged bar chart: cut by clarity") 

# Potential pitfalls:
# - Avoid too many categories (overcrowded bars).
# - Stacked bars with many levels can be hard to interpret.


# ------------------------------------------------------------------------------
# 2. TIME SERIES: Line vs. Path 
# Line plots connects data in order of the x-axis variable (left to right).
# Path plots join them in the order that they appear in the dataset.
# ------------------------------------------------------------------------------

# Example using economics dataset.
############################################################
# DATASET: economics (US Macroeconomic Data)
# ----------------------------------------------------------
# date     : Monthly timestamp (1967 - 2015)
# pce      : Consumer spending (billions $)
# pop      : Total population (thousands)
# psavert  : Personal savings rate (%)
# uempmed  : Median weeks unemployed (duration)
# unemploy : Number of unemployed (thousands)
############################################################
economics
data(economics, package = "ggplot2")

# Basic time series plot.
ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line() +
  ggtitle("Number of unemployed (thousands) over time") 

# Class discussion: Let's look at two unemployment graphs: unemployment rate (%) and median number of weeks unemployed.
# What do looking at these two variables tell us?
# We can see that by comparing these two graphs that something is different about 
# the peak in 2010 (great recession 2007-2013)

# Add unemployment rate to the economics dataset 
economics <- economics |>
  mutate(unemprate = unemploy / pop) 

# Path plot: To examine the relationship, we draw them both on the same plot
ggplot(economics, aes(x = unemprate, y = uempmed)) +
  geom_path() +
  geom_point() 

ggplot(economics, aes(x = unemprate, y = uempmed)) +
  geom_line() +
  geom_point() 

# Path vs line: A line plot connects values from smallest(x) to largest(x), not by their order in the data frame
# This creates an unwanted a sawtooth pattern
# Line graph, points connected by increasing value of x (ignores row order) 
# Path graph, points connected by their row order 

# Improving our path plot: We lose track of the start and end points in the full unemployment data due to the number of line crossings

# Coding challenge 1: 
# 1. Recreate the original path plot
# 2. Have the color of the points change with the date, and keep the lines fixed at grey

ggplot(economics, aes(x = unemprate, y = uempmed)) +
  geom_path(color = "grey50") +
  geom_point(aes(color = date)) +
  ggtitle("Contrasting unemployment rate and duration")


# ------------------------------------------------------------------------------
# 3. AXES 
# The functions xlab() and ylab() allow you to set the axis labels
# Axis limits can be set with xlim() and ylim()
# For continuous axes, NA can be used to set only one limit
# ------------------------------------------------------------------------------

# Add axis labels 
ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1/3) +
  xlab("city driving (mpg)") +
  ylab("highway driving (mpg)")

# Remove the axis labels with NULL 
ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 0.33) +
  xlab(NULL) +
  ylab(NULL) 


# Scatter plot, jittering (randomizing) 
# x-position slightly
ggplot(mpg, aes(cty, hwy)) +
  geom_jitter(alpha = 1/3) +
  xlab("city driving (mpg)") +
  ylab("highway driving (mpg)")

ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.05)

# Set limits on categorical & continuous axes
ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.05) +
  xlim("f", "r") + #"kk"
  ylim(20, 30)

# Set limits on categorical & continuous axes 
# For continuous, use NA to set only one limit 
ggplot(mpg, aes(drv, hwy)) +
  geom_point() +
  ylim(NA, 40) + #what happens if we replace NA with 0
  ggtitle("Highway mpg vs drive, limited to max 40 mpg")

# Class discussion: What's the difference between removing data (with ylim)
# and zooming (with coord_cartesian)? 

# What will happen to our path plot with the following axis limit?
ggplot(economics, aes(x = unemprate, y = uempmed)) +
  geom_path(color = "grey50") +
  geom_point(aes(color = date)) +
  xlim(NA, 0.04) +
  ggtitle("Contrasting unemployment rate and duration") 


ggplot(economics, aes(x = unemprate, y = uempmed)) +
  geom_path(color = "grey50") +
  geom_point(aes(color = date)) +
  coord_cartesian(xlim = c(NA, 0.04)) +
  ggtitle("Contrasting unemployment rate and duration") 



# ------------------------------------------------------------------------------
# 4. OUTPUT 
# ------------------------------------------------------------------------------
#
# You can save a plot to a variable and manipulate it as an object
p <- ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point() +
  ggtitle("Fuel efficiency by engine displacement and class")

summary(p) 
p$data 
print(p)

# Save png to disk 
ggsave("plot.png", plot = p, width = 5, height = 5) 
# You can also save your plot object with save() or saveRDS(), as with any other R object


# ------------------------------------------------------------------------------
# 5. SCALES 
# Scales control the mapping from data to aesthetics
# Formally, each scale is a function from a region in data space... 
# (scale) to a region in aesthetic space (the range of the scale).
# The axis or legend is the inverse function (guide): 
# it allows you to convert visual properties back to data
# A scale is required for every aesthetic used on the plot
# ------------------------------------------------------------------------------

# What actually happens implicitly
# ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(colour = class)) +
#   scale_x_continuous() + scale_y_continuous() + scale_colour_discrete() 

# If you want to override the defaults, you'll need to add the scale yourself
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_continuous("Displacement (litres)") +
  scale_y_continuous("Highway miles per gallon") +
  ggtitle("Fuel efficiency by engine size and class with explicit scales") 

