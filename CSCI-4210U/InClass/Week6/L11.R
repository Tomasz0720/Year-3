# ==============================================================================
# LECTURE 11: ggplot2 - 3 
# Topics: Aesthetic mappings, Facetting, Individual geoms, Collective geoms 
# ==============================================================================

library(ggplot2)
library(dplyr)

# ------------------------------------------------------------------------------
# 1. AESTHETIC MAPPINGS 
#
# Common aesthetics:
# - Color: The border colour of the geom (point, line, path, text, density).
# - Fill: The filled surface area of the geom (bar, density, label, polygon).
# - Size: The suggestions that some aesthetic maps to the size of the glyph for corresponding geoms.
# - Shape: Aesthetics for point geoms or shapes.
# - Linetype: A type of line (blank, nil, solid, dashed, dotted, dotdash, longdash, twodash).
# - Alpha: Transparency of the geom (0-transparent, 1-opaque).
#
# Notes:
# A separate scale is created for each aesthetic that is mapped.
# Scales convert data values to aesthetics.
# If you map a value, it must be in 'aes' or 'scale_*' functions.
# ------------------------------------------------------------------------------

# Color vs. fill 
#fill vs Color 
#fill
diamonds
ggplot(diamonds, aes(x = cut, fill = cut)) +
  geom_bar() +
  ggtitle("Diamonds by cut with fill") 

#color 
ggplot(diamonds, aes(x = cut, colour = cut)) +
  geom_bar() +
  ggtitle("Diamonds by cut with color")

 # Different aesthetics and multiple mappings
ggplot(diamonds, aes(x = depth, y = price, colour = cut, shape = cut)) +
  geom_point() +
  ggtitle("Price vs depth by cut") 
 
# Alpha transparency 
# DATASET: faithful (Old Faithful Geyser, Yellowstone)
# ------------------------------------------------------------------------------
# Variable: eruptions (x) | Duration in minutes (approx. 2 or 4.5 min peaks)
# Variable: waiting   (y) | Time to next eruption (approx. 50 or 80 min peaks)
# Variable: density   (z) | The relative probability of (x, y) occurring. 

faithfuld
ggplot(faithful, aes(x = waiting, y = eruptions)) +
  geom_point(color = "maroon", alpha = 0.5) +
  ggtitle("Raw Data: Each dot is one eruption")
#how would you interpret this visualization? 


ggplot(faithfuld, aes(waiting, eruptions, alpha = density)) +
  geom_raster(fill = "maroon") 
# which one? 

#both?
ggplot(faithful, aes(x = waiting, y = eruptions)) +
  geom_point(alpha = 0.3) +
  geom_density_2d(color = "maroon") +
  ggtitle("Density Contours over Raw Data")

# Line type 
ggplot(diamonds, aes(x = depth, fill = cut, colour = cut, linetype = cut)) +
  geom_density(alpha = 0.2, na.rm = TRUE) +
  xlim(58, 68) +
  ggtitle("Distribution (Kernel Density Estimate) of diamonds dataset") 

# --- SCALES AND AESTHETICS (Theory) ---
# ggplot2 converts data (e.g., 'f', 'r', '4') into aesthetics (e.g., salmon, blue, green) with a scale.
# - Categorical data (factors) map to a discrete aesthetics (e.g., shapes, color, linetype).
# - Continuous data (numbers) map to continuous aesthetic (size, x, y, position, alpha).
# There is one scale for each aesthetic mapping in a plot.
# The scale also creates an axis or legend (technically a guide)...to determine the aesthetic encoding used for the data.


# ------------------------------------------------------------------------------
# 2. FACETTING 
# Facetting is another technique for distinguishing categorical variables.
# It creates tables of graphics by splitting the data into subsets and displaying 
# the same graph parameters for each subset.
# 
# Types of facet functions:
# - facet_null(): A single plot, the default
# - facet_wrap(): "wraps" a 1D panel of panels into 2D, using ~
# - facet_grid(): produces a 2D grid of panels defined by row, col variables
# ------------------------------------------------------------------------------

# Example: facet_wrap()
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() 

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() 

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~class) 

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  facet_wrap(~class) 

# Use ncol, nrow in facet_wrap() 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~class, nrow = 2) 

# Example: facet_grid()
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(drv ~ cyl) 
#which categori has the best fuel consumption 

# facet_grid() with . 
#grid vs wrap
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(. ~ cyl) 

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~cyl) 

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(drv ~ .) 

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~drv) 

# facet_grid() with margins 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(. ~ cyl, margins = TRUE) 

#------------------------------------------------------------------------------
# --- CODING CHALLENGE 1 --- 
# Using the mpg dataset, create a scatterplot of displ(x) and hwy(y).
# Create a wrapped facet, splitting the data by vehicle class, with 3 columns.

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~class, ncol = 3)


# --- CLASS DISCUSSION --- 
# What happens if you try facetting by a continuous variable, say cty? 

mpg
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() + 
  facet_wrap(~cty, ncol = 3)

# Why did it work? 
# Convert cty to factors and plot it again. What's ggplot doing? 
# Note: this will work even with doubles, so be careful; you could hang your machine.
#------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# 3. INDIVIDUAL GEOMS 
# The following geoms are the basic building blocks of ggplot2. 
# Each of the following geoms are two dimensional and require both x and y aesthetics.
#
# Geoms:
# - geom_area(): An area plot. This is a line plot filled to the y-axis (filled lines). Multiple groups stacked.
# - geom_bar(stat="identity"): A bar graph. Multiple bars will be stacked.
# - geom_line(): A line plot. The group aesthetic determines which are connected. Lines connect for left to right.
# - geom_point(): Creates a scatter plot.
# - geom_polygon(): Draws polygons, which are filled paths. Each vertex of the polygon requires a separate row.
# - geom_rect(), geom_tile(), geom_raster(): Draws rectangles. T...y vary based on their location specification, and display speed.
# ------------------------------------------------------------------------------


 
# ------------------------------------------------------------------------------
# 4. COLLECTIVE GEOMS & GROUPING 
# Geoms can be roughly divided into individual and collective geoms.
# Individual - draws a distinct graphical object for each observation (row).
# Collective - Displays multiple observations with one geometric object (e.g., boxplot, polygon).
# 
# The group aesthetic is mapped to the interaction of all discrete variables in the plot.
# ------------------------------------------------------------------------------

#Oxboys Dataset
# Source: nlme package
# DESCRIPTION: 
# Longitudinal data tracking the heights of 26 schoolboys in Oxford 
# measured on 9 occasions over approximately two years.
#
# VARIABLES:
#   1. Subject (Factor) : Unique ID for each of the 26 boys.
#   2. age     (Numeric): Standardized age (centered around 0).
#   3. height  (Numeric): Height of the boy in centimeters (cm).
#   4. Occasion (Ordered): Integer (1 to 9) representing the visit number.
data(Oxboys, package = "nlme") #?
Oxboys

# Example: height vs age with points colored by Subject
ggplot(Oxboys, aes(x = age, y = height, color = Subject)) +
  geom_point() 

# Height vs age with smoothing line
ggplot(Oxboys, aes(x = age, y = height)) +
  geom_point(alpha = 0.3) +
  geom_smooth()

# Situation 1: default grouping
# Distinct color and group for each subject by default
# Try: 
# predict the output without running the code? 
ggplot(Oxboys, aes(x = age, y = height)) +
  geom_line()

#how to separate them (facet_Wrap)
ggplot(Oxboys, aes(x = age, y = height)) +
  geom_line() +
  facet_wrap(~Subject)

ggplot(Oxboys, aes(x = age, y = height, group = Subject)) +
  geom_line() +
  geom_point(alpha = 0.3) 

# A global trend using geom_smooth()
ggplot(Oxboys, aes(x = age, y = height)) +
  geom_point() +
  geom_smooth() 

# Situation 2: Changing grouping
# Suppose we want separate smooth for each subject
ggplot(Oxboys, aes(x = age, y = height, group = Subject)) +
  geom_point() +
  geom_smooth(se = FALSE) 

# Nope... Using the same grouping in both layers, we get a separate smooth per subject, which is not what we wanted
ggplot(Oxboys, aes(x = age, y = height, group = Subject)) +
  geom_point() +
  geom_line() +
  geom_smooth() 

# Better: we need to restrict our group aesthetic to only desired geom_line() layer
ggplot(Oxboys, aes(x = age, y = height)) +
  geom_point() +
  geom_line(aes(group = Subject), alpha = 0.2) +
  geom_smooth()




# --- SITUATION 3: Overriding the default grouping 
# Some plots have a discrete x scale, but you still want to draw lines connecting across groups
ggplot(Oxboys, aes(Occasion, height)) +
  geom_boxplot() 

# the lines are drawn within each occasion, not across each subject
ggplot(Oxboys, aes(Occasion, height)) +
  geom_boxplot() +
  geom_line(colour = "Blue", alpha = 0.5) #grouped by occasion by default

ggplot(Oxboys, aes(x = age, y = height)) +
  geom_line() 

ggplot(Oxboys, aes(Occasion, height)) +
  geom_line(colour = "Blue", alpha = 0.5) #grouped by occasion by default


# Coding challenge 3: Using Oxboys, can you recreate our boxplot, with geom_line() grouped by Subject? 

ggplot(Oxboys, aes(Occasion, height)) +
  geom_boxplot() +
  geom_line(aes(group = Subject), colour = "Blue", alpha = 0.5)

