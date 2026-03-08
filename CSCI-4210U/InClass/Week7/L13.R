##### Lecture 13 

# graphics.off() ensures all previous plots are closed 
graphics.off()


# tidyverse contains ggplot2; patchwork is used to combine plots side-by-side 
library(tidyverse)
library(patchwork) 


#### 1. The Grammar of Scales ####

# CONCEPT: A scale is a function from data space (the domain) to aesthetic space (the range)
# Every aesthetic used on the plot (x, y, colour, etc.) requires a scale

# Example 1: Implicit Scales
# ggplot2 AUTOMATICALLY adds DEFAULT scales "under the hood"
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(colour = class))


# Example 2: EXPLICIT Scales
# This is the full version of the code above, showing the default functions 
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(colour = class)) + 
  scale_x_continuous() +    # Maps continuous values to the X axis 
  scale_y_continuous() +    # Maps continuous values to the Y axis 
  scale_colour_discrete()   # Maps categorical data to discrete colors 

# Updated Example: Discrete X and Continuous Colour
ggplot(mpg, aes(x = class, y = hwy)) + 
  geom_point(aes(colour = displ)) + 
  scale_x_discrete() +        # Maps categorical data ('class') to discrete X axis positions
  scale_y_continuous() +      # Maps continuous data ('hwy') to the Y axis
  scale_colour_continuous()   # Maps numeric data ('displ') to a continuous color gradient





ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(colour = class)) + 
  scale_x_continuous() +    # Maps continuous values to the X axis 
  scale_y_continuous() +    # Maps continuous values to the Y axis 
  scale_colour_discrete()   # Maps categorical data to discrete colors 

# Example 3: Overriding Defaults
# Naming scheme: scale_ + [primary aesthetic] + [scale name] 
# Instead of a linear scale, this transforms the x-axis to a logarithmic scale (base 10).
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(colour = class)) +
  scale_x_log10() + # Maps data to a log-10 scale 
  scale_colour_brewer() # Uses ColorBrewer palettes instead of defaults 

# scale_x_sqrt() Applies a square root transformation.
# scale_x_reverse() Flips the axis so that values decrease as you move from left to right
# scale_x_continuous(trans = "...")

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(colour = class)) +
  scale_x_log10(limits = c(1.6, 100)) + # Maps data to a log-10 scale 
  scale_colour_brewer()                 # Uses ColorBrewer palettes instead of defaults 





#### 2. Position Scales & Computed Variables ####

# Position scales control where visual entities are located on the plot
# scale for y can be calculated (implicitly or explicitly)
# Sometimes aesthetics map to 'computed variables' (like 'count' in a histogram)

# geom_histogram() computes a count variable automatically
ggplot(mpg, aes(x = displ)) + 
  geom_histogram()


# Equivalent to manual specification using after_stat()
ggplot(mpg, aes(x = displ, y = after_stat(count))) + 
  geom_histogram()





#### 3. Limits, Zooming, and Breaks ####

# CONCEPT: Maintaining Graphical Integrity.
# Both facets in ax facet_wrap automatically share the same axis limits
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() +
  facet_wrap(~year)

# TRAP: If you treat plots separately, their limits will differ by default
p_1999 <- mpg |> filter(year == 1999) |> ggplot(aes(x = displ, y = hwy)) + geom_point()
p_1999
p_2008 <- mpg |> filter(year == 2008) |> ggplot(aes(x = displ, y = hwy)) + geom_point()
p_2008

# Notice the misleading axes when combined side-by-side (x and y axis):
p_1999 + p_2008 

# FIX: Set limits manually so the plots are visually comparable 
# WARNING: Setting limits in a scale sets values outside the range to NA (data loss)
p_1999 <- p_1999 + 
  scale_x_continuous(limits = c(1, 7), name = "Engine displ (L)") +
  scale_y_continuous(limits = c(10, 45), name = "Highway mileage (MPG)")

p_2008 <- p_2008 + 
  scale_x_continuous(limits = c(1, 7), name = "Engine displ (L)") +
  scale_y_continuous(limits = c(10, 45), name = "Highway mileage (MPG)")

# Now they share a consistent visual language:
p_1999 + p_2008





# TRUE ZOOM: Use coord_cartesian() to zoom in without removing data points 
# This is preferred if you don't want to distort the underlying data
# The magnifying glass effect: It acts like a magnifying glass.
# All the data points are still there, but you are only looking at a specific section of the "canvas"
# Statistical integrity
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() +
  scale_x_continuous()

#coord_cartesian
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() +
  coord_cartesian(xlim = c(4, 7), ylim = c(20, 45))





ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() +
  scale_x_continuous()


# BREAKS AND LABELS:
# 'Breaks' control tick mark locations; 'Labels' control the text on those ticks
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() +
  scale_x_continuous(
    # 1. BREAKS: Map specific data values to major tick marks
    breaks = c(2, 4.5, 6), 
    # 2. LABELS: Text strings for those ticks (must match break count).
    labels = c("Small", "Medium", "Large"), 
    # 3. MINOR BREAKS: Grid lines without labels to help track values
    minor_breaks = c(2.5, 3.5)
  )





# ADVANCED SCALES: The 'scales' package provides helpers for automated breaks
economics
economics |> 
  # Focus on a specific timeframe (pre-1970) for clarity
  filter(date < lubridate::ymd("1970-01-01")) |> 
  ggplot(aes(x = date, y = pce)) + 
  geom_line() + 
  
  # scale_x_date handles date-specific formatting
  scale_x_date(
    "NULL",                                      # NULL removes the X-axis title 
    breaks = scales::breaks_width("3 months"), # Forces a major tick every 3 months / 7 days
    labels = scales::label_date_short()        # Dynamic labels (e.g., "1968", "Feb") 
  ) + 
  
  # scale_y_continuous handles standard numeric data
  scale_y_continuous(
    "Personal consumption expenditures",       # Sets the Y-axis title directly
    breaks = scales::breaks_extended(n = 6),   # Smart algorithm picks ~8 "pretty" breaks 
    labels = scales::label_dollar()            # Automatically adds '$' and commas 
  )
