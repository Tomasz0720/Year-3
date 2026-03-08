# ==============================================================================
# LECTURE 10: ggplot2 (Part 2) - Aesthetics, Layers, and Factors
# CSCI 4210U – Information Visualization
# ==============================================================================

# PREREQUISITES: Load necessary libraries
library(ggplot2)
library(dplyr)      # For data manipulation
library(forcats)    # For 'gss_cat' dataset used in later challenges

# ------------------------------------------------------------------------------
# SECTION 1: AESTHETICS (The Theory)
# ------------------------------------------------------------------------------
# WHAT ARE AESTHETICS? 
# - In math, a "graph" is just abstract nodes and edges (not visible).
# - "Aesthetics" (from Greek 'aisthētikós': sensory perception) are what turn 
#   abstract math into visible graphics.
# - They control the appearance of elements: color, size, shape, position.

# GLOBAL VS LOCAL AESTHETICS 
# 1. Global: Specified in ggplot(). Applies to ALL layers.
# 2. Local:  Specified in a geom_layer(). Applies ONLY to that layer.

# Example 1: Global Aesthetics
# Here, x and y are passed down to geom_point
#method 1
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()

#method 2
graphics.off()  # <--- Closes all old plot windows
g <-ggplot(mpg, aes(x = displ, y = hwy))
myGraph <- g + geom_point()
myGraph

# Example 2: Local Aesthetics (Equivalent result)
# Here, x and y are defined only inside the geom
#These override top level plot aesthetics.
graphics.off()  # <--- Closes all old plot windows
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy))

# ------------------------------------------------------------------------------
# CLASS CHALLENGE 0: The Beaver Plot 
# ------------------------------------------------------------------------------
# Context: Using the joined beaver dataset from the previous lecture.
# Task: Update the scatterplot to show a SINGLE smoothed LOESS fit across 
#       all data (instead of one line per beaver).

# (Setup: Recreating the joined dataset from L09)
b <- bind_rows(beaver1, beaver2, .id = 'beaver')

# SOLUTION :
# Notice where we put the colour aesthetic!
# - x and y are GLOBAL (apply to points AND smooth line).
# - colour is LOCAL to geom_point (so only points are colored).
# - geom_smooth has no color aesthetic, so it draws one black line for everything.

ggplot(b, aes(x = time, y = temp)) +
  geom_point(aes(colour = beaver)) +   # Local aes: Only points get color
  geom_smooth() +                      # Inherits x/y, ignores color
  labs(x = "Time of observation", 
       y = "Body temperature (Celcius)",
       colour = "Beaver", 
       title = "Change in beaver daily body temperature",
       subtitle = "Source: P. S. Reynolds (1994)")

# ------------------------------------------------------------------------------
# SECTION 2: MAPPING VS.SETTING (Crucial Concept) 
# ------------------------------------------------------------------------------
# There are two ways to control aesthetics:
# 1. MAPPING (Variable): Inside aes(). Changes based on data.
# 2. SETTING (Specific): Outside aes(). Fixed value (e.g., "red").

# CORRECT: Setting a specific color 
# We want ALL points to be red. We put colour="red" OUTSIDE aes().
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(colour = "red")

# CORRECT: Mapping a variable to color 
# We want color to change based on the 'class' variable. Inside aes().
ggplot(mpg, aes(x = displ, y = cty)) +
  geom_point(aes(colour = class)) # \T Don't need factor because it's not a range of numbers- its words.

# COMMON MISTAKE
# Trying to set a specific color INSIDE aes().
# ggplot thinks "red" is a data category named "red", not the actual color.
ggplot(mpg, aes(displ, cty, colour = "red")) +
  geom_point() 
# Result: It creates a legend entry called "red" but paints it the default pinkish color.

# Reference for all aesthetic specifications: 
# https://ggplot2.tidyverse.org/articles/ggplot2-specs.html

# ------------------------------------------------------------------------------
# CODING CHALLENGE 1 [slide - 18]
# ------------------------------------------------------------------------------
# Task: Create a base ggplot object 'p' with mpg data (x=cty, y=hwy).
# Then create three separate graphs modifying different aesthetics.

# 1. Base Object
p <- ggplot(mpg, aes(x = cty, y = hwy))

# 2. Plot A: Color code by manufacturer
p + geom_point(aes(colour = manufacturer))

# 3. Plot B: Shape by drive train (drv)
p + geom_point(aes(shape = drv))

# 4. Plot C: Size by cylinders (cyl)
p + geom_point(aes(size = cyl))

# \T Returns an empty plot- you only called the function to draw the axis, you didn't add any actual information.
p

# ------------------------------------------------------------------------------
# SECTION 3: THE GGPLOT OBJECT 
# ------------------------------------------------------------------------------
# ggplot2 treats plots as OBJECTS.
# - You can save a plot to a variable.
# - You can add layers to that variable later.

# Step 1: Create the object (defines data and default axes)
myGraph <- ggplot(mpg, aes(x = class, y = hwy))

# Step 2: Add a layer to visualize it
# (Before this step, typing 'myGraph' just shows a blank grey box)
#why no factor(class) ? 
myGraph + geom_boxplot()

# Step 3: Add a title at any time
myGraph + geom_boxplot() + ggtitle("Highway MPG by Class")

myGraph #?
# ------------------------------------------------------------------------------
# \CODING CHALLENGE 2 
# ------------------------------------------------------------------------------
# Task:
# 1. Create ggplot object of vehicle class (x).
# 2. Add a geom_bar() layer.
# 3. Set the 'fill' aesthetic to vary with drive train (drv).
# 4. Add a title.
mpg

g <- ggplot(mpg, aes(class))

g + geom_bar() +  #aes(fill = drv)
  ggtitle("Car class and drive train")

# NOTE: Why did this work?
# We didn't specify a y-axis. geom_bar() automatically counts the rows.
# This leads us to...

# ------------------------------------------------------------------------------
# SECTION 4: LAYERS AND STATISTICAL SUMMARIES 
# ------------------------------------------------------------------------------
# Layers have three purposes:
# 1. Display raw data (EDA).
# 2. Display statistical summary (predictions, counts).
# 3. Add metadata (annotations).

# Statistical Transformations (stats)
# - geom_smooth() calculates a MEAN (line) and SE (ribbon)
# - geom_bar() calculates a COUNT.

# OVERRIDING STATS: stat = "identity" 
# Sometimes your data is ALREADY summarized. You don't want ggplot to count rows.

# Data: Effect rating of drinks
user_rating <- tibble(
  drink = c("a", "b", "c"),
  effect = c(4.2, 9.7, 6.1)
)
user_rating

# We must use stat="identity" to tell ggplot: "Use the number in the 'effect' column, don't count the rows."
ggplot(user_rating, aes(x = drink, y = effect)) +
  geom_bar(stat = "identity")

# HISTOGRAM EXAMPLE 
# Shows distribution (statistical summary is 'binning').
diamonds
ggplot(diamonds, aes(x = depth)) +
  geom_histogram( binwidth = 0.1, na.rm = TRUE) + #aes(fill = cut), \T na.rm = TRUE means if there's a null value it should be removed.
  xlim(58, 68) +
  theme(legend.position = "none")


# ------------------------------------------------------------------------------
# SECTION 5: FACTORS 
# ------------------------------------------------------------------------------
# Factors are used for CATEGORICAL variables (limited groups).
# e.g., Sex (M/F), Month (Jan-Dec).
# In R, they are stored as integers with text labels

# WHY USE THEM? The Sorting Problem 
m <- c("Jan", "Dec", "Apr", "Sep")
sort(m) 
# Result: "Apr", "Dec", "Jan", "Sep" -> Alphabetical! (Not chronological).

# THE FIX: Define Levels 
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

# Create the factor
d <- factor(m, levels = month_levels)
sort(d)
# Result: Jan, Apr, Dec, Sep -> Correct chronological order!

# ------------------------------------------------------------------------------
# CODING CHALLENGE 3 - Slide 44
# ------------------------------------------------------------------------------
# Task using 'gss_cat' dataset:
# 1. Group by income bracket ('rincome').
# 2. Calculate average 'tvhours' (drop NAs).
# 3. Create a scatterplot (income on y, tvhours on x).

# Note: 'rincome' is already a Factor in this dataset, which is why 
# the y-axis will sort somewhat logically (though "Not applicable" often sits at top).
gss_cat

gss_cat |>
  group_by(rincome) |>
  summarise(tvhours = mean(tvhours, na.rm = TRUE)) |>
  ggplot(aes(x = tvhours, y = rincome)) +
  geom_point()

# ------------------------------------------------------------------------------
# END OF LECTURE 10
# ------------------------------------------------------------------------------