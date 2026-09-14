# =============================================================================
# CSCI 4210U – Information Visualization
# Lecture 18: Proportions 2 – Finishing Pie Charts & Proportions Over Time
# =============================================================================
# OUTLINE:
#   1. Recap & finish fixing pie chart (color simplification, manual alpha)
#   2. Why you shouldn't use pie charts (deficiencies + advantages)
#   3. Other circular chart types
#   4. Proportions over time: stacked area charts
# =============================================================================

# Load required libraries
library(tidyverse)    # ggplot2, dplyr, tibble, etc.
library(RColorBrewer) # ColorBrewer palettes
library(scales)       # provides the alpha() function for manual color+transparency


# =============================================================================
# SECTION 1: SORTING FACTOR LEVELS — RECAP
# =============================================================================

# KEY INSIGHT from L17:
#   arrange() sorts ROWS in the tibble — it does NOT affect factor levels.
#   Factor levels are set ALPHABETICALLY by default when a factor is created.
#   To control plot order, we must explicitly set levels = ...
#
# The pattern:
#   factor(variable, levels = desired_order_vector)
#
# With rev(): because coord_polar goes counterclockwise, reversing the levels
# makes the largest slice appear first (clockwise from top).

# Verify the pie looks sorted
ggplot(d2, aes(x = "", y = VotesScaled, fill = Area)) +
  geom_bar(stat = "identity") +
  coord_polar(theta = "y") +
  xlab(NULL) + ylab(NULL) 

ggplot(d2, aes(x = "", y = VotesScaled, fill = Area, alpha = VotesScaled)) +
  geom_bar(stat = "identity") +
  coord_polar(theta = "y") +
  xlab(NULL) + ylab(NULL) +
  guides(alpha = 'none')


# =============================================================================
# SECTION 2: SIMPLIFYING COLOR — SINGLE FILL + MAPPED ALPHA
# =============================================================================

# Problem: 10 different hues are hard to distinguish and look noisy.
# Solution: Use ONE fill color, and let ALPHA vary with the data.
#   → Largest slices are darker (more opaque), smallest are lighter (more transparent)
#   → Ordered pie + alpha gradient = clean, readable chart

# We also:
#   - Set a specific fill color: "#61041D" (a dark crimson)
#   - Add borders between slices: color = "aliceblue", linewidth = 0.25
#     → thin light borders help the eye see where one slice ends and another begins

ggplot(d2, aes(x = "", y = VotesScaled, alpha = VotesScaled)) +
  geom_bar(
    stat  = "identity",
    fill  = "#61041D",       # fixed fill color (NOT mapped to data)
    color = "white",         # slice border color
    linewidth = 0.25         # thin border
  ) +
  coord_polar(theta = "y") +
  xlab(NULL) +
  ylab(NULL) +
  guides(alpha = FALSE)       # hide the alpha legend (we don't need it)

# This is a significant improvement — but we've lost the category legend.
# The "fill" guide is gone because fill is no longer mapped to Area. ***********
# We need a different approach to get a useful legend back.


# =============================================================================
# SECTION 3: MANUALLY SPECIFYING ALPHA WITH scales::alpha()
# =============================================================================

# The problem with mapping alpha via aes(alpha = ...) is that the legend
# shows transparency swatches, which is unintuitive.
#
# BETTER APPROACH:
#   - Map FILL to Area (so we get a proper legend with category names + colors)
#   - Manually encode the transparency INTO the fill hex colors themselves
#   - Use the alpha() function from the {scales} package
#
# scales::alpha(colour, alpha)
#   → takes a color (hex string or name) and an alpha value (0 = transparent, 1 = opaque)
#   → returns a new hex color string with the alpha channel baked in
#
# Example:
scales::alpha("#61041D", 0.5)  # → semi-transparent version of #61041D

# We want each slice to have the SAME hue but DIFFERENT transparency.
# Transparency should be proportional to VotesScaled.

# Step 1: Normalize VotesScaled to a 0–1 range for alpha values
alpha_values <- d2$VotesScaled / max(d2$VotesScaled)
alpha_values  # check: largest = 1.0, smallest ≈ small fraction

# Step 2: Generate a named vector of colors using alpha()
#   - Each color is the same base hue "#61041D"
#   - Alpha varies per category
color_codes <- scales::alpha(rep("#61041D", nrow(d2)), alpha_values)
color_codes

names(color_codes) <- (d2$Area)  # name them so scale_fill_manual can match
color_codes


# =============================================================================
# CODING CHALLENGE 1: Apply manual alpha colors via scale_fill_manual()
# =============================================================================

# TASK:
#   - Using the alpha() function from scales, manually create a vector of color codes
#   - Pass them in using scale_fill_manual(values = ...)
#   - This way fill IS mapped to Area → we get the category legend back

# --- SOLUTION ---

# Generate alpha-encoded colors for each category
# (normalized so the top category = fully opaque = 1.0)
manual_colors <- scales::alpha(
  colour = rep("#61041D", nrow(d2)),
  alpha  = d2$VotesScaled / max(d2$VotesScaled)
)
names(manual_colors) <- (d2$Area)
manual_colors

# Plot with fill mapped to Area, and scale_fill_manual providing our custom colors
ggplot(d2, aes(x = "", y = VotesScaled, fill = Area)) +
  geom_bar(
    stat      = "identity",
    color     = "white",   # slice borders
    linewidth = 0.25
  ) +
  coord_polar(theta = "y") +
  scale_fill_manual(values = manual_colors) +  # our custom alpha-encoded colors
  xlab(NULL) +
  ylab(NULL)

# Now we have:
#   ✓ Sorted slices (largest → smallest)
#   ✓ Single-hue palette with alpha gradient
#   ✓ Thin borders separating slices
#   ✓ A proper category legend

# --- That's enough of pie charts! Let's discuss their limitations... ---


# =============================================================================
# SECTION 4: WHY YOU SHOULDN'T USE PIE CHARTS
# =============================================================================

# DEFICIENCY 1: Angle/area comparisons are less accurate than length comparisons
# -----------------------------------------------------------------------
# CLASS QUESTION: "For each pie chart, which colour is the largest slice?"
# This is a perceptual challenge — looking at a pie chart and identifying the
# LARGEST slice when multiple slices are similar in size is genuinely hard.

# Let's DEMONSTRATE this with real data. We'll plot the same data as both
# a pie chart AND a bar chart, and compare how easy it is to identify rankings.

# Make a small dataset where slices are close in size (hard to rank in a pie)
demo <- tibble(
  Category = c("A", "B", "C", "D", "E"),
  Value    = c(23, 19, 21, 18, 19)   # similar values — hard to rank by angle!
)

# As a pie chart — try to rank all 5 categories without looking at the numbers:
ggplot(demo, aes(x = "", y = Value, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Set2") +
  xlab(NULL) + ylab(NULL) +
  ggtitle("Pie chart — can you rank all 5 slices?")

# As a bar chart — NOW try to rank them:
ggplot(demo, aes(x = reorder(Category, -Value), y = Value, fill = Category)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "Set2") +
  xlab("Category") + ylab("Value") +
  ggtitle("Bar chart — ranking is immediate")

# KEY INSIGHT: The bar chart answer is IMMEDIATELY obvious.
# The pie chart answer requires careful examination.
# This is because humans judge LENGTH much more accurately than ANGLE or AREA.
# Humans are BETTER at judging differences in LENGTH than in ANGLE or AREA.
# This is why bar charts are generally preferred: the eye can quickly compare
# bar heights/lengths with high accuracy.
#
# In a pie chart, you compare ARC ANGLES (or areas), which is inherently harder.
# Example: can you tell which slice is larger when two slices look similar?
#   → Bar chart: immediately obvious
#   → Pie chart: requires squinting and guessing

# DEFICIENCY 2: Only effective for ~4–5 slices
# -----------------------------------------------------------------------
# Beyond 4–5 categories, a pie chart becomes cluttered:
#   - Needs data labels, colors, or textures to be readable
#   - Unsuitable for large datasets
#   - Compare to a bar chart, which scales gracefully to many categories

# DEFICIENCY 3: Takes up more space than a bar chart
# -----------------------------------------------------------------------
# A pie chart is circular and always needs an accompanying legend.
# A bar chart can encode the category names directly on the axis.
# → bar chart is often more space-efficient

# DEFICIENCY 4: Color problems for colorblind readers
# -----------------------------------------------------------------------
# Approximately 10% of men and 0.6% of women have red-green color blindness.
# Color perception also DECREASES with age.
# Using many different hues in a pie chart makes it inaccessible for these readers.
# (Think of the Ishihara color test plates — the number 74 is invisible to
#  some colorblind people who see 21 instead.)
#
# This issue applies to ALL graphics, not just pie charts.
# Best practice: use colorblind-friendly palettes (e.g., viridis, ColorBrewer)


# PIE CHART ADVANTAGES
# -----------------------------------------------------------------------
# Pie charts do have ONE documented advantage:
# When comparing a SINGLE SLICE to the WHOLE PIE, and that slice is close
# to 25% or 50%, research shows pie charts can OUTPERFORM bar charts.
# The circle makes it easy to see "roughly a quarter" or "roughly half".


# RULES OF THUMB (Nathan Yau)
# -----------------------------------------------------------------------
# "You can use pie charts without any problems as long as you know their limitations:
#  Keep your data organized, and don't put too many wedges in one pie."
#
# IN GENERAL: Avoid pie charts whenever possible.
# We spent time improving them because it exposed valuable visualization concepts
# (coordinate systems, color palettes, factor levels, alpha transparency).


# =============================================================================
# SECTION 5: OTHER CIRCULAR CHART TYPES
# =============================================================================

# There are other circular charts worth knowing about:
#
# DONUT CHART
#   - Like a pie chart but with a hole in the middle
#   - The hole can display a summary number or label
#   - Create in ggplot by adjusting xlim() with coord_polar
#
# WIND ROSE
#   - Circular histogram showing directional data (e.g., wind direction + speed)
#   - Common in meteorology
#
# RADAR CHART (Spider chart)
#   - Shows multivariate data on axes radiating from a center point
#   - Available via ggplot extension: ggradar
#   - https://exts.ggplot2.tidyverse.org/ggradar.html

# Quick donut chart example (extending our pie):
ggplot(d2, aes(x = 2, y = VotesScaled, fill = Area)) +
  geom_bar(stat = "identity") +
  coord_polar(theta = "y") +
  scale_fill_manual(values = manual_colors) +
  xlim(0.5, 2.5) +   # the xlim creates the hole in the middle
  xlab(NULL) + ylab(NULL)


# =============================================================================
# SECTION 6: PROPORTIONS OVER TIME
# =============================================================================

# So far we've visualized STATIC proportional data (one pie chart = one snapshot).
# But what if your proportional data CHANGES OVER TIME?
#
# Examples:
#   - Monthly polls: how do opinions shift month to month?
#   - US population age distribution: how does it shift decade to decade?
#
# For this, we use a STACKED AREA CHART:
#   - Horizontal axis = TIME
#   - Vertical axis = proportion (0 to 100%)
#   - Each "layer" = one category, stacked on top of the others
#   - The filled areas show how each category's share changes over time
#
# Think of it as: multiple time-series lines stacked, with the gaps filled in.


# =============================================================================
# SECTION 7: STACKED AREA CHART — uspopage DATA
# =============================================================================

# Dataset: US population by age group, 1860–2005
# Source: gcookbook package

# Install the package if not already installed, then load the data
if (!requireNamespace("gcookbook", quietly = TRUE)) {
  install.packages("gcookbook")
}
data(uspopage, package = 'gcookbook')

# Inspect the structure
glimpse(uspopage)
head(uspopage)
# Columns:
#   Year     – calendar year
#   AgeGroup – age bracket (e.g., "0-4", "5-9", ...)
#   Thousands – population in thousands for that year/age group

# Basic stacked area chart
ggplot(uspopage, aes(x = Year, y = Thousands, fill = AgeGroup)) +
  geom_area()

# geom_area() fills the area under each line and stacks them.
# ggplot automatically stacks the areas because they share the same x values.


# =============================================================================
# CODING CHALLENGE 2: Style the stacked area chart
# =============================================================================

# TASK: Update the graphic to:
#   - Set the border color to "black"
#   - Increase linewidth to 0.2
#   - Set alpha to 0.4
#   - Use the "Blues" ColorBrewer palette
#   - Reverse the legend ordering

# --- SOLUTION ---

ggplot(uspopage, aes(x = Year, y = Thousands, fill = AgeGroup)) +
  geom_area(
    colour    = "black",  # border color between layers
    linewidth = 0.2,      # thin borders
    alpha     = 0.4       # semi-transparent fills
  ) +
  scale_fill_brewer(palette = "Blues") +
  guides(fill = guide_legend(reverse = TRUE))  # reverse legend so oldest age on top

# guide_legend(reverse = TRUE) flips the legend order to match the visual stack
# (youngest age group is at the bottom of the chart, oldest at the top)


# =============================================================================
# SECTION 8: RESCALING DATA TO PROPORTIONS
# =============================================================================

# PROBLEM: Right now the y-axis shows THOUSANDS of people, not percentages.
# The sum of all age groups for a given year ≠ 100.
# We want a fully proportional stacked area where y goes from 0 to 1 (or 0-100%).
#
# This is DIFFERENT from our earlier VotesScaled calculation.
#   - Before: we scaled ALL values at once (total sum across everything)
#   - Now: we need to scale values WITHIN EACH YEAR separately
#
# Two approaches:


# --- OPTION 1: Scale the data manually with group_by() + mutate() ---
#
# group_by(Year) creates groups — one per year
# mutate() then calculates WITHIN each group (not across all rows)
# NOTE: mutate() keeps all rows (doesn't collapse like summarise())
uspopage
uspopage |>
  group_by(Year) |>
  mutate(Thousands = Thousands / sum(Thousands)) |>   # scale within each year
  ggplot(aes(x = Year, y = Thousands, fill = AgeGroup)) +
  geom_area(colour = "black", linewidth = 0.2) +
  scale_fill_brewer(palette = "Blues") +
  guides(fill = guide_legend(reverse = TRUE))

# Now each year's proportions sum to 1.0 (100%)
# The y-axis now represents PROPORTION of total population


# --- OPTION 2: Let ggplot rescale automatically with position = "fill" ---
#
# position = "fill" tells geom_area() to NORMALIZE each x position to sum to 1
# This is more concise — no need to transform the data first!

uspopage |>
  ggplot(aes(x = Year, y = Thousands, fill = AgeGroup)) +
  geom_area(
    colour    = "black",
    linewidth = 0.2,
    position  = "fill"   # <-- ggplot handles the rescaling automatically
  ) +
  scale_fill_brewer(palette = "Blues") +
  guides(fill = guide_legend(reverse = TRUE))

# Both options produce the same result.
# Option 2 is more concise; Option 1 is more explicit and lets you inspect
# the rescaled values (useful for debugging or further analysis).


# =============================================================================
# SUMMARY OF KEY CONCEPTS FROM L18
# =============================================================================
#
# 1. SORTING FACTOR LEVELS:
#    factor(var, levels = desired_order)
#    arrange() only sorts rows, not factor levels!
#
# 2. SIMPLIFYING PIE CHART COLOR:
#    - Single fill color + alpha mapped to data = clean sequential encoding
#    - geom_bar(..., fill="#hex", color="aliceblue", linewidth=0.25)
#
# 3. MANUAL ALPHA WITH scales::alpha():
#    scales::alpha(colour, alpha) bakes transparency into color hex codes
#    Use with scale_fill_manual(values = ...) for a proper legend
#
# 4. PIE CHART DEFICIENCIES:
#    - Angle/area harder to judge than length
#    - Max ~4-5 slices
#    - Takes more space than bar charts
#    - Color problems for colorblind readers (~8% of men)
#
# 5. PIE CHART ADVANTAGES:
#    - Effective when one slice is ~25% or ~50% of total
#
# 6. STACKED AREA CHART:
#    geom_area() + stacking = proportions over time
#
# 7. RESCALING BY GROUP (two approaches):
#    Option 1: group_by(Year) |> mutate(y = y / sum(y))
#    Option 2: geom_area(position = "fill")   [ggplot handles it]
#
# 8. REVERSE LEGEND:
#    guides(fill = guide_legend(reverse = TRUE))
#
# =============================================================================

