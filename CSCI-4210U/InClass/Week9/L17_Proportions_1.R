# =============================================================================
# CSCI 4210U – Information Visualization
# Lecture 17: Proportions 1 – Pie Charts
# =============================================================================
# OUTLINE:
#   1. Pie chart basics (what they are, how they work)
#   2. Creating a pie chart in ggplot2
#   3. Fixing common issues (color, ordering)
# =============================================================================

# Load required libraries
library(tidyverse)   # includes ggplot2, dplyr, tibble, etc.
library(RColorBrewer) # ColorBrewer palettes


# =============================================================================
# SECTION 1: PIE CHART BASICS
# =============================================================================

# --- What is a pie chart? ---
# Pie charts represent PROPORTIONS.
# This means the sum of all your categories should total 1 (or 100%).
#
# The first known pie chart was published by William Playfair in 1801.
# He also invented the bar chart and line graph!
#
# --- How does a pie chart encode data? ---
# Pie charts visualize values through ARC ANGLE (a proportion of 360° or π rad).
# Compare to bar graphs, which visualize values through BAR LENGTH.
#
# Arc angle = (value / total) × 360°
#
# Example: if a category has 25% of the total → arc angle = 90°

# Quick illustration of arc angle math:
total_votes <- 831  # total number of respondents in our upcoming dataset
# A category with 172 votes would have this arc angle (in degrees):
(172 / total_votes) * 360


# =============================================================================
# SECTION 2: PIE CHARTS IN GGPLOT2 – CONCEPTUAL FOUNDATION
# =============================================================================

# --- Coordinate systems: Cartesian vs. Polar ---
#
# Cartesian:  every point is defined by (x, y)
# Polar:      every point is defined by (r, θ)  [radius, angle]
#
# KEY INSIGHT: A pie chart is just a STACKED BAR chart with its coordinate
# system changed from Cartesian to Polar!
#
# In a stacked bar chart:
#   - x-axis has one bar (x = "")
#   - y-axis stacks the proportions on top of each other
#
# When you apply coord_polar(theta = "y"), ggplot maps the y-axis values
# to ANGLES instead of heights → the bar becomes a circle → pie chart!


# =============================================================================
# SECTION 3: CREATE THE DATA
# =============================================================================

# Data from a FlowingData.com poll: "What data-related field interests you most?"
# 831 total responses

d <- tibble(
  Area  = c("Statistics", "Design", "Business", "Cartography",
            "Information Science", "Web Analytics", "Programming",
            "Engineering", "Mathematics", "Other"),
  Votes = c(172, 136, 135, 101, 80, 68, 50, 29, 19, 41)
)

# Inspect the data
print(d)
sum(d$Votes)  # should be 831


# =============================================================================
# CODING CHALLENGE 1: Scale data and build a bar chart
# =============================================================================

# TASK:
#   - Pie charts need proportional data that sum to 100%
#   - Add a new column VotesScaled that scales the votes correctly
#   - Set aesthetics: x = "", y = VotesScaled, fill = Area
#   - Create a stacked bar graph with geom_bar()

# --- SOLUTION ---

# Step 1: Add VotesScaled column (votes as a percentage of total)
d <- d |>
  mutate(VotesScaled = Votes / sum(Votes) * 100)

d$VotesScaled

# Check: should sum to 100
sum(d$VotesScaled)

# Step 2: Create a stacked bar chart
# x = ""  → single bar (no real x categories)
# y = VotesScaled → height = percentage
# fill = Area  → each segment coloured by category
ggplot(d, aes(x = "", y = VotesScaled, fill = Area)) +
  geom_bar(stat = "identity")   # stat="identity" means "use the y values as-is"

# This is your stacked bar. It is the FOUNDATION of our pie chart.


# =============================================================================
# SECTION 4: FROM STACKED BAR → PIE CHART
# =============================================================================

# --- Step 1: Add coord_polar() to get a BULLSEYE chart ---
# coord_polar() maps the coordinate system to polar coordinates.
# By default, it maps the X axis to angle → gives a bullseye (not what we want)
d
ggplot(d, aes(x = "", y = VotesScaled, fill = Area)) +
  geom_bar(stat = "identity") +
  coord_polar()   # <-- this gives a bullseye!


# --- Step 2: Map THETA to y to get a proper PIE chart ---
# Setting theta = "y" tells ggplot to map the Y axis (our proportions)
# to the angle in polar coordinates → proportions become arc sizes

# Also need:
#   width = 1  → removes the default 10% gap between bar edges
#               (without this you get an ugly grey gap slice)

d
ggplot(d, aes(x = "", y = VotesScaled, fill = Area)) +
  geom_bar(stat = "identity") +  
  coord_polar(theta = "y")                    # theta="y" maps y → angle


# =============================================================================
# SECTION 5: READABILITY PROBLEMS WITH OUR PIE CHART
# =============================================================================

# This pie chart has THREE readability problems:
#
# PROBLEM 1: Too many categories (10 slices is too many for a pie chart)
# PROBLEM 2: Default ggplot2 color scheme doesn't work well with 10 colors
# PROBLEM 3: No ordering of arc widths or color gradation
#
# Let's fix each problem...

# --- HOW DOES THE DEFAULT COLOR SCHEME WORK? ---
# ggplot2 picks evenly-spaced hues around the HCL color wheel.
# This works for ~8 colors max; beyond that, colors become hard to distinguish.


# =============================================================================
# CODING CHALLENGE 2: Fix colors using ColorBrewer
# =============================================================================

# TASK:
#   - Replot the pie chart
#   - Remove axis labels with xlab() and ylab() (or scale_x/y)
#   - Add a scale_fill_brewer() layer
#   - Try different palettes

# --- SOLUTION ---

# First, build a base plot object we can reuse:
p <- ggplot(d, aes(x = "", y = VotesScaled, fill = Area)) +
  geom_col(width = 1) +           # geom_col() is shorthand for geom_bar(stat="identity")
  coord_polar(theta = "y") +
  scale_x_discrete(name = NULL) + # removes x-axis label
  scale_y_continuous(name = NULL) # removes y-axis label

# p <- ggplot(d, aes(x = "", y = VotesScaled, fill = Area)) +
#  geom_col(width = 1) +
#  coord_polar(theta = "y") +
#  theme(axis.title = element_blank())

# Try different ColorBrewer palettes:
p + scale_fill_brewer(palette = "BrBG")      # Brown-Blue-Green (diverging)
p + scale_fill_brewer(palette = "PiYG")      # Pink-Yellow-Green (diverging)
p + scale_fill_brewer(palette = "Spectral")  # Rainbow-ish (diverging)
p + scale_fill_brewer(palette = "Blues")     # Sequential blues — NOTE: only 9 max!
p + scale_fill_brewer(palette = "Greens")    # Sequential greens — NOTE: only 9 max!

# OBSERVATION: Blues and Greens give a WARNING → they only support up to 9 colors
# but we have 10 categories! → this hints at PROBLEM 1 (too many categories)


# =============================================================================
# SECTION 6: MAKING YOUR OWN COLOR PALETTE
# =============================================================================

# Since we have 10 categories and ColorBrewer maxes at 9 for sequential palettes,
# we have two options:
#   Option A: Generate our own palette via color interpolation
#   Option B: Modify the alpha (transparency) aesthetic

# --- OPTION A: Color interpolation with colorRampPalette() ---

# colorRampPalette(c("color1", "color2"))(n)
# → takes two (or more) endpoint colors
# → interpolates n colors between them
# → returns a vector of n hex color codes

# Simple example: 10 shades from blue to red
colorRampPalette(c("blue", "red"))(10)

# We can use ColorBrewer colors as endpoints!
# brewer.pal(n, "PaletteName") gives you n hex codes from a named palette


# =============================================================================
# CODING CHALLENGE 3: Build a custom Blues palette with 10 colors
# =============================================================================

# TASK:
#   - Find how many colors the "Blues" palette supports (brewer.pal.info)
#   - Get those hex codes with brewer.pal()
#   - Use colorRampPalette() to extend to 10 colors
#   - Apply to the pie chart with scale_fill_manual()

# --- SOLUTION ---

# How many colors does Blues support?
brewer.pal.info["Blues", ]$maxcolors   # → 9

# Get the 9 Blues hex codes
brewer.pal(n = 9, "Blues")

# Interpolate to 10 colors using those 9 as a gradient
pal <- colorRampPalette(brewer.pal(9, "Blues"))(10)
pal  # print the 10 hex codes

# Apply to our pie chart
p + scale_fill_manual(values = pal)

# Better! But the colors are still hard to distinguish among similar shades.


# =============================================================================
# SECTION 7: ALPHA TRANSPARENCY AS AN ALTERNATIVE
# =============================================================================

# OPTION B: Use a SINGLE fill color, but map ALPHA (transparency) to the data
#
# Recall: aesthetics we can map to data:
#   - size, shape, color/fill, alpha (transparency)
#
# Here we keep one fill color and let alpha vary with VotesScaled
# → bigger slices are darker / more opaque, smaller slices are lighter

ggplot(d, aes(x = "", y = VotesScaled, fill = Area, alpha = VotesScaled)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  xlab(NULL) +
  ylab(NULL)

# PROBLEM: ggplot adds TWO legends now — one for fill, one for alpha
# We only want the fill legend → suppress the alpha legend


# =============================================================================
# SECTION 8: REMOVING AN UNWANTED LEGEND
# =============================================================================

# When you map a second aesthetic, ggplot automatically creates a second legend.
# Use guides() to suppress it:
#   guides(alpha = 'none')  → hides the alpha legend

ggplot(d, aes(x = "", y = VotesScaled, fill = Area, alpha = VotesScaled)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  xlab(NULL) +
  ylab(NULL) +
  guides(alpha = 'none')   # <-- removes the alpha legend


# =============================================================================
# SECTION 9: FIXING PROBLEM 3 — ORDERING THE PIE CHART
# =============================================================================

# Right now, the pie slices appear in alphabetical order.
# A well-designed pie chart should go from LARGEST to SMALLEST slice
# → easier for the eye to compare relative sizes
# → alpha transparency also looks more logical (dark → light)

# Let's try sorting the tibble rows first:
d2 <- d |>
  arrange(desc(VotesScaled))   # sort by descending proportion
d2

# Now replot
ggplot(d2, aes(x = "", y = VotesScaled, fill = Area, alpha = VotesScaled)) +
  geom_bar(stat = "identity") +
  coord_polar(theta = "y") +
  xlab(NULL) +
  ylab(NULL) +
  guides(alpha = 'none')



# =============================================================================
# SECTION 10: UNDERSTANDING FACTOR LEVELS (CLASS QUESTION)
# =============================================================================

# CLASS QUESTION: What aesthetic controls the pie slice ORDER?
#   → The FILL aesthetic maps Area to colors and ORDER

# Check the data type of Area:
class(d2$Area)     # "character"
class(d$Area)      # also "character"

# Even after arrange(), the slice order didn't change.
# WHY?
#
# When ggplot maps a character/factor variable to fill, it uses
# FACTOR LEVELS to determine the order.
#
# By default, factor levels are created in ALPHABETICAL order.
# So even though our tibble rows are sorted, the levels are still A-Z.
#
# arrange() sorts ROWS in the tibble, but it does NOT change FACTOR LEVELS.
# (Our data was already in descending order alphabetically anyway —
#  so arrange() had no visible effect here!)


# =============================================================================
# SECTION 11: SORTING FACTOR LEVELS
# =============================================================================

# SOLUTION: Explicitly set the factor level ORDER when creating the factor.
# Since d is already sorted by Votes descending, we can use:
#
#   factor(x, levels = ...)
#
# We wrap with rev() because coord_polar() plots from the top going clockwise,
# so reversing the level order gives us largest-first going clockwise.

d2 <- d |>
  arrange(desc(VotesScaled)) |> # Sort it, no level.
  mutate(Area = factor(Area, levels = rev(Area))) # Add the level, considers the array thats sorted as the level. 

# Alternative: directly on the original tibble
d$Area <- factor(d$Area, levels = rev(d$Area))

# Now replot — slices should be sorted largest → smallest
ggplot(d2, aes(x = "", y = VotesScaled, fill = Area, alpha = VotesScaled)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  xlab(NULL) +
  ylab(NULL) +
  guides(alpha = 'none')

# Much better! The ordering makes the chart more readable.
# Next lecture (L18) we will continue polishing this pie chart and then
# move on to proportions over time (stacked area charts).


# =============================================================================
# SUMMARY OF KEY CONCEPTS FROM L17
# =============================================================================
#
# 1. Pie charts = stacked bar charts with coord_polar(theta = "y")
#
# 2. Data must be PROPORTIONAL (sum to 100%):
#    mutate(VotesScaled = Votes / sum(Votes) * 100)
#
# 3. geom_bar(stat = "identity", width = 1) + coord_polar(theta = "y")
#    is the ggplot2 recipe for a pie chart
#
# 4. scale_fill_brewer() applies ColorBrewer palettes
#    colorRampPalette() extends palettes to more colors
#
# 5. Alpha transparency can encode data:
#    aes(alpha = VotesScaled)
#    Use guides(alpha = 'none') to hide the extra legend
#
# 6. arrange() sorts ROWS; it does NOT change factor LEVEL order
#    Use factor(x, levels = ...) to explicitly control plotting order
#
# =============================================================================
