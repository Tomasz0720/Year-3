# ==============================================================================
# LECTURE 09: Introduction to ggplot2
# CSCI 4210U – Information Visualization
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. PRELIMINARIES & OVERVIEW 
# ------------------------------------------------------------------------------
# We are using the package 'ggplot2'.
# - It is an R package for producing statistical or data-based graphics.
# - It is based on the "Grammar of Graphics" by Leland Wilkinson (2005).
# - It is called "ggplot2" because it is the second version of the package.


library(ggplot2)
library(dplyr) # Loaded for data manipulation (bind_rows) used later

# ------------------------------------------------------------------------------
# 2. THE PHILOSOPHY: A GRAMMAR FOR GRAPHICS 
# ------------------------------------------------------------------------------
# Why use a "grammar"?
# - Think about natural language. Grammar allows us to combine words into 
#   complex sentences, expanding the language's scope.
# - Similarly, the Grammar of Graphics provides rules to create perceivable graphs.
# - It moves us beyond a limited set of fixed charts (like "bar chart" or "pie chart")
#   to an unlimited world of graphical forms.

#  WHAT CAN IT DO? 
# - Practically, it handles fiddly details (legends, error bars, confidence intervals).
# - It is designed to work ITERATIVELY: Start with a raw layer, then add annotations
#   and statistical summaries on top.

# ------------------------------------------------------------------------------
# 3. BASIC EXAMPLE: MPG DATA 
# ------------------------------------------------------------------------------
# ggplot(data, aes(mappings)) + geom_layer()

# We are plotting:
# x = Displacement (displ), y = Highway Mileage (hwy), colour = Drive train (drv)
# \T colour = drv adds the category. Removing it will make them all the same colour, changing it to shape changes the shape instead of colour, size changes the size instead of colour, etc...
mpg

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  labs(x = "Displacement (L)", 
       y = "Highway mileage (mpg)",
       colour = "Drive train",
       title = "Highway fuel economy of 2008 cars")


# Which elements of the code correspond to which visual elements?
# - aes(x, y, colour) -> Maps data to visual properties.
# - geom_point()      -> Determines we are drawing "dots". \T can change to line, polygon, bars, etc...
# - labs()            -> Changes the text labels.

# ------------------------------------------------------------------------------
# 4. DEEP DIVE: THE 7 LAYERS OF THE GRAMMAR 
# ------------------------------------------------------------------------------
# A graph is made of a series of layers, like plastic transparencies stacked
# on top of one another.

# THE 7 GRAMMATICAL ELEMENTS:
# 1. DATA:        The variables we want to visualize.
# 2. AESTHETICS:  Mappings between variables and visual properties (x, y, color, size).
# 3. GEOMETRIES:  (geoms) The visual objects you actually see (points, bars, lines).
# 4. STATISTICS:  (stats) Summaries of the data (e.g., binning, smoothing).
# 5. SCALES:      Map values (e.g., litres) to aesthetic space (pixels/colors).
#                 They also draw the axes and legends
# 6. COORDS:      (Coordinate Systems) Map data to the plane (Cartesian, Polar, Map)
# 7. FACETS:      Break up data into subsets (multiple sub-plots)
# 8. THEME:       Controls non-data ink (font size, background colour)

# WHAT THE GRAMMAR DOES *NOT* DO:
# 1. It does NOT suggest which graphic you *should* use to answer a question.
# 2. It does NOT describe interactivity (it only describes static graphics).

# ------------------------------------------------------------------------------
# 5. UNDERSTANDING GEOMS (Geometric Objects) 
# ------------------------------------------------------------------------------
# Geoms determine the "type" of plot. You must specify the data variables.
# Common Geoms listed in the slides:

# geom_bar()       -> Bars representing statistical properties.
# geom_point()     -> Points (scatterplots).
# geom_line()      -> Connects points with straight lines.
# geom_smooth()    -> A "smoother" line summarizing the data trend.
# geom_histogram() -> A histogram (distribution).
# geom_boxplot()   -> Box-and-whisker diagram.
# geom_text()      -> Text labels on the plot.
# geom_density()   -> Density plot.
# geom_errorbar()  -> Error bars.
# geom_hline()     -> Horizontal line (user-defined).
# geom_vline()     -> Vertical line (user-defined).

# Example: Using geom_smooth instead of geom_point
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(level = 0.95)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(span = 0.2) # \T span is the smoothness of the line. 0.2 is kinda bad because it fits the data too closely

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(
    color = "red",         # Line color
    fill = "blue",         # Confidence interval ribbon color
    linetype = "dashed",   # Line style (dashed, dotted, etc.)
    size = 1.5,            # Thickness of the line
    alpha = 0.2            # Transparency of the ribbon
  )

# ------------------------------------------------------------------------------
# 6. UNDERSTANDING AESTHETICS (aes) 
# ------------------------------------------------------------------------------
# Aesthetics control appearance (size, colour, shape).
# - REQUIRED aesthetics: Needed for the specific geom (e.g., x, y for points).
# - OPTIONAL aesthetics: Can be overridden (e.g., fixed color, transparency).

# NOTE: Aesthetics defined in ggplot() apply to ALL layers. 
#       Aesthetics defined in a geom_() apply ONLY to that layer.

# Example with optional aesthetics (alpha = transparency):
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(alpha = 0.2, colour = "blue") # \T BAD - Transparency represents nothing- darker dots are just other transparent dots layered- no correlation.

#what is wrong here? 

# ------------------------------------------------------------------------------
# 7. CODING CHALLENGE 1: BEAVERS 
# ------------------------------------------------------------------------------
# Task:
# We will explore the relationship between a beaver’s body temperature and time of day.
# 1. Join 'beaver1' and 'beaver2' datasets using bind_rows().
# 2. Use .id to label them "1" and "2".
# 3. Create a scatterplot: x=time, y=temp, colour=beaver.
beaver1
beaver2

# Step 1: Data Manipulation 
beavers <- bind_rows("1" = beaver1, "2" = beaver2, .id = "beaver") # \T Combine beaver1 and beaver2 datasets into a dataset called beaver- adds a column 'beaver' where it adds beaver 1 if the data is from beaver 1, and the same for beaver 2.
beavers
# Step 2: Plotting 
ggplot(beavers, aes(x = time, y = temp, colour = beaver)) + # \T colour is from the column we created, we decided to colour/ seperate the data visually by beaver.
  geom_point() +
  labs(x = "Time of observation", 
       y = "Body temperature (Celcius)",
       colour = "Beaver", 
       title = "Change in beaver daily body temperature",
       subtitle = "Source: P. S. Reynolds (1994)")

# ------------------------------------------------------------------------------
# 8. MIDWEST DATA EXAMPLE 
# ------------------------------------------------------------------------------
# in the deck, but this is the solution provided on Slide 31).

# Data: 'midwest'
# ABOUT THE DATA:
# The 'midwest' dataset is built into ggplot2.
# It contains demographic information for counties in the US Midwest 
# from the 2000 census.

# VARIABLES WE ARE USING:
# 1. x = percprof: Percentage of people with a professional degree (Education).
# 2. y = percchildbelowpovert: Percentage of children below poverty line (Poverty).
# 3. colour = inmetro: A numeric flag (0 = Rural, 1 = Metro area).

midwest

#EXAMPLE 1
#what is wrong with this graph? 
ggplot(midwest, aes(x = percprof, y = percchildbelowpovert, colour = inmetro)) +
  geom_point() +
  labs(x = "% professional degree", 
       y = "% children below poverty line",
       colour = "Metro area", 
       title = "Poverty in the US-midwest",
       subtitle = "Source: 2000 US census")

#Revised version
ggplot(midwest, aes(x = percprof, y = percchildbelowpovert, colour = factor(inmetro))) +
  geom_point() +
  labs(x = "% professional degree", 
       y = "% children below poverty line",
       colour = "Metro area", 
       title = "Poverty in the US-midwest",
       subtitle = "Source: 2000 US census")

#EXAMPLE 2 - boxplot
ggplot(midwest, aes(x = factor(inmetro), y = percchildbelowpovert)) + 
  geom_boxplot(aes(fill = factor(inmetro))) +   # Fill color helps distinguish them
  labs(x = "Metro Area (0=Rural, 1=Metro)", 
       y = "% Child Poverty",
       fill = "Metro Status",
       title = "Distribution of Child Poverty: Metro vs Rural")


#EXAMPLE 3.1 - Violin + boxplot
ggplot(midwest, aes(x = factor(inmetro), y = percchildbelowpovert)) +
  geom_violin(aes(fill = factor(inmetro))) + 
  # Optional: We can overlay a boxplot inside to see the median!
  geom_boxplot(width = 0.1, fill = "white") +
  labs(x = "Metro Area (0=Rural, 1=Metro)", 
       y = "% Child Poverty",
       fill = "Metro Status",
       title = "Violin Plot of Child Poverty",
       subtitle = "White bar inside represents the traditional boxplot")

#EXAMPLE 3.2 - boxplot + violin
# BAD EXAMPLE: Drawing the Boxplot FIRST, then the Violin
ggplot(midwest, aes(x = factor(inmetro), y = percchildbelowpovert)) +
  # Layer 1: The Boxplot (Drawn at the bottom)
  geom_boxplot(width = 0.1, fill = "white") +
  # Layer 2: The Violin (Drawn ON TOP)
  # Result: The violin is solid, so it covers up the boxplot!
  geom_violin(aes(fill = factor(inmetro))) + 
  labs(title = "Mistake: The Violin is hiding the Boxplot!",
       subtitle = "Because geom_violin() was added LAST")

#EXAMPLE 3.3 - boxplot + violin
ggplot(midwest, aes(x = factor(inmetro), y = percchildbelowpovert)) +
  # Layer 1: The Boxplot (Bottom)
  geom_boxplot(width = 0.1, fill = "white") +
  # Layer 2: The Violin (Top)
  # We add 'alpha = 0.5' to make it see-through!
  geom_violin(aes(fill = factor(inmetro)), alpha = 0.5) + 
  labs(title = "Fixed: Using Alpha to see the Boxplot underneath",
       subtitle = "The Violin is on top, but it is transparent.")

# ------------------------------------------------------------------------------
# END OF LECTURE
# ------------------------------------------------------------------------------