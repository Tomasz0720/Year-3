# =============================================================================
# CSCI 4210U – Information Visualization
# Lecture 20: Maps 2
# =============================================================================
# Topics:
#   1. Polygon Maps (deeper look)
#   2. Coordinate Systems (coord_map vs coord_quickmap vs coord_sf)
#   3. Choropleth Maps
#   4. Examining Spatial Data (non-spatial views first!)
#   5. Joining Spatial and Attribute Data
# =============================================================================

# --- Install missing packages ---
pkgs <- c("tidyverse", "maps", "mapproj", "devtools")
pkgs_new <- pkgs[!pkgs %in% installed.packages()[, "Package"]]
if (length(pkgs_new)) install.packages(pkgs_new)

# socviz is a GitHub-only package
if (!requireNamespace("socviz", quietly = TRUE)) {
  devtools::install_github("kjhealy/socviz")
}

library(tidyverse)
library(maps)
library(mapproj)
library(socviz)


# =============================================================================
# SECTION 1: POLYGON MAPS — A DEEPER LOOK
# =============================================================================

# Recall from L19: polygon maps encode geographic boundaries as sequences of
# (lon, lat) vertices, grouped by polygon ID and labeled by region name.

# Let's look closely at the New Zealand data to understand the structure better.

d_nz <- map_data("nz") |>
  select(lon = long, lat, group, id = region) |>
  as_tibble()

d_nz

# NOTE: "nz" in the maps package is just the NORTH ISLAND of New Zealand
# (not the full country — this is a quirk of the data)

# Compare two ways of viewing the same data:

# (a) As a dot plot — each row is just a point
d_nz |>
  ggplot(aes(x = lon, y = lat)) +
  geom_point(size = 0.5) +
  coord_quickmap() +
  labs(title = "New Zealand (North Island) — points")

# (b) As a polygon map — points connected in order, grouped by polygon
d_nz |>
  ggplot(aes(x = lon, y = lat, group = group)) +
  geom_polygon(fill = "lightgrey", colour = "gray12", linewidth = 0.25) +
  coord_quickmap() +
  labs(title = "New Zealand (North Island) — polygon")

# The data is identical — the difference is just HOW we draw it.
# geom_point: shows vertices
# geom_polygon: connects vertices into filled shapes


# =============================================================================
# SECTION 2: COORDINATE SYSTEMS FOR MAPS
# =============================================================================

# There are THREE main coordinate system functions for maps in ggplot2:

# --- coord_quickmap() ---
# The FASTEST option — a simple approximation.
# It adjusts the aspect ratio so that near the CENTER of the plot:
#   1 degree of longitude ≈ 1 degree of latitude (in physical distance)
# Limitation: NOT accurate for large areas or areas near the poles.
# USE WHEN: quick exploration, small regions, or when speed matters.

# --- coord_map() ---
# Uses the mapproj package to apply FORMAL map projections.
# Slower than coord_quickmap() but mathematically accurate.
# Supports many projection types: mercator, gall, albers, lambert, etc.
# USE WHEN: you need a specific projection or higher accuracy.

# --- coord_sf() ---
# From the sf (simple features) package — the MODERN STANDARD.
# Works with sf objects and supports any CRS (Coordinate Reference System).
# This is what professional GIS work in R uses today.
# We will introduce this in a later lecture.

# --- Projection examples with coord_map() ---

p_us_base <- map_data("state") |>
  select(lon = long, lat, group, state = region) |>
  ggplot(aes(x = lon, y = lat, group = group)) +
  geom_polygon(fill = "lightgrey", colour = "gray12", linewidth = 0.1)


library(patchwork)

# 1. MERCATOR: The Navigator's Standard
# Preserves: Shape and angles (local shapes look "natural").
# Distorts: Area (massively inflates landmasses near the poles).
p1 <- p_us_base + 
  coord_map(projection = "mercator") + 
  labs(title = "Mercator", subtitle = "Shape-True / Area-False")

# 2. GALL-PETERS: The Social Justice Standard
# Preserves: Area (Relative sizes are mathematically correct).
# Distorts: Shape (Countries look vertically 'stretched' or squashed).
p2 <- p_us_base + 
  coord_map(projection = "gall", lat0 = 45) + 
  labs(title = "Gall-Peters", subtitle = "Area-True / Shape-False")

# 3. ALBERS: The Statistical Standard (Conic)
# Preserves: Area (Excellent for data density and thematic maps).
# Distorts: Distance (outside of the 39-45 degree 'sweet spot').
# Note: Notice the 'curved' top border acknowledging Earth's shape.
p3 <- p_us_base + 
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) + 
  labs(title = "Albers Conic", subtitle = "Best for US Data/Census")

# 4. LAMBERT: The Aviation Standard (Conic)
# Preserves: Angles and local shapes (conformal).
# Distorts: Area (but much less than Mercator for regional maps).
# Note: Used by pilots because straight lines are close to shortest paths.
p4 <- p_us_base + 
  coord_map(projection = "lambert", lat0 = 39, lat1 = 45) + 
  labs(title = "Lambert Conic", subtitle = "Best for Regional Navigation")

# --- DISPLAY THE COMPARISON ---
# The '/' and '+' syntax comes from the 'patchwork' package
(p1 + p2) / (p3 + p4)


# For US maps, Albers is generally the standard choice in data visualization.


# =============================================================================
# SECTION 3: CHOROPLETH MAPS
# =============================================================================

# CHOROPLETH MAP = a map where geographic areas are COLOURED or SHADED
#                  according to a VARIABLE'S VALUE.
#
# Think of it like a HEATMAP, but instead of a rectangular grid,
# the "cells" are geographic regions (states, countries, counties, etc.)
#
# Choropleths are a STRIKING and intuitive way to show how a variable
# changes across space — the geographic context makes patterns immediately meaningful.
#
# Examples:
#   - Countries shaded by GDP per capita
#   - US states shaded by unemployment rate
#   - Postal codes shaded by average house price


# --- VARYING GEOGRAPHIC GRANULARITY ---
# The same data can be shown at different geographic scales:
#
# STATE-LEVEL map: broad patterns visible — which states voted R vs D?
# COUNTY-LEVEL map: more detail — urban/rural splits within states become visible
#
# Key insight: county-level maps reveal that most states contain BOTH
# heavily Republican (rural) and heavily Democratic (urban) areas.
# State-level maps hide this internal variation!
#
# This is a classic example of the ECOLOGICAL FALLACY:
#   Assuming that patterns at one level of aggregation apply within that unit.


# --- THE ROLE OF COLOUR SCALE ---
# HOW you colour a choropleth dramatically changes what viewers see:
#
# Option 1: Two-colour categorical (e.g., pure red vs pure blue)
#   → Shows which side "won" but hides margin of victory
#
# Option 2: Gradient within each party (light → dark red, light → dark blue)
#   → Shows margin of victory by intensity
#   → No midpoint colour needed (each side has its own scale)
#
# Option 3: Diverging gradient (blue → purple → red through a neutral midpoint)
#   → scale_fill_gradient2() lets you specify the midpoint colour
#   → A midpoint colour changes perception: purple areas appear "neutral" or "contested"
#   → Question to consider: does a purple midpoint HELP or CONFUSE the viewer?
#   → It depends on your question! If you care about closeness, purple is informative.
#     If you care about winner, it adds noise.


# =============================================================================
# SECTION 4: EXAMINING SPATIAL DATA (NON-SPATIAL VIEWS FIRST!)
# =============================================================================

# IMPORTANT PRINCIPLE: Spatial data doesn't ALWAYS need a map.
#
# Start with non-spatial views (scatter plots, bar charts) to:
#   1. Understand the data structure
#   2. Spot patterns and outliers
#   3. Identify questions worth mapping
#   THEN add geographic context with a choropleth.
#
# Why? Maps can be visually compelling but misleading:
#   - Large areas draw the eye even when sparsely populated
#   - Small but densely populated areas (cities) are barely visible
#   A scatter plot treats each unit (state, country) equally.

# --- THE ELECTION DATASET ---
# socviz::election contains 2016 US presidential election results at the STATE level.

?election        # read the documentation
glimpse(election)

# Key variables:
#   state       : state name (lowercase, matches map_data("state"))
#   state_abbr  : abbreviation
#   r_points    : Republican margin (positive = R won, negative = D won)
#   pct_clinton : Clinton's vote share
#   pct_trump   : Trump's vote share
#   ev_dem      : Democratic electoral votes
#   ev_rep      : Republican electoral votes
#   census      : Census region

head(election)

# --- NON-SPATIAL EXPLORATION ---
# Let's look at vote shares before mapping anything

# Scatter: Clinton % vs Trump % by state, coloured by winner
election |>
  # This ensures we are matching the first letter regardless of the full word
  mutate(party_color = case_when(
    str_detect(party, "^D") ~ "Democrat",
    str_detect(party, "^R") ~ "Republican"
  )) |>
  ggplot(aes(x = pct_trump, y = pct_clinton)) +
  geom_point(aes(colour = party_color), size = 3) +
  scale_colour_manual(values = c("Republican" = "red", "Democrat" = "blue")) +
  labs(
    title = "2016 US Presidential Election",
    x = "Trump vote share (%)",
    y = "Clinton vote share (%)",
    colour = "Winning Party"
  )

# What does this tell us?
#   - Strong negative correlation (where Trump did well, Clinton didn't, and vice versa)
#   - Some states are close to 50/50 — competitive swing states
#   - Some states are landslides in one direction

# Dot plot: Republican margin by state (ordered)
election |>
  mutate(state = fct_reorder(state, r_points)) |>
  ggplot(aes(x = r_points, y = state)) +
  geom_point(aes(colour = party)) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  scale_colour_brewer(palette = "Set1", direction = -1) + 
  labs(
    title = "2016 Election: Republican Margin by State",
    x = "R margin (positive = Trump won)",
    y = NULL
  ) +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 6))

# This ordered dot plot clearly shows the spectrum from solid D to solid R.
# Now let's add geographic context with a choropleth.


# =============================================================================
# SECTION 5: JOINING SPATIAL AND ATTRIBUTE DATA
# =============================================================================

# To make a choropleth, we need TWO datasets working together:
#
#   d_us        : the SPATIAL data — lat/lon polygon vertices for each state
#   election    : the ATTRIBUTE data — variables we want to colour by (vote share, etc.)
#
# These two datasets are SEPARATE and must be JOINED before plotting.
# This is a very common situation in mapping!
#
# The JOIN KEY must match between the two datasets:
#   d_us$state  = lowercase state name (e.g., "california")
#   election$state = same lowercase format? Let's check.

# --- STEP 1: Get the spatial data ---

d_us <- map_data("state") |>
  select(lon = long, lat, group, state = region) |>
  as_tibble()

head(d_us)
n_distinct(d_us$state)   # 49 states (Alaska and Hawaii not in maps::state)


# --- STEP 2: Inspect the election data ---

head(election)
# election$state appears to be mixed case: "Alabama", "Alaska", etc.

# Make lowercase to match d_us
election_clean <- election |>
  mutate(state = str_to_lower(state))

head(election_clean)


# --- STEP 3: Understand the join ---
# We want every row in d_us (a vertex) to carry the election data for its state.
# This is a LEFT JOIN: keep all rows from d_us, attach matching election data.
#
# d_us has MANY rows per state (one per vertex), election has ONE row per state.
# The join will REPEAT the election values for every vertex of that state.
# That's exactly what we want — each polygon gets uniformly coloured.

d_map <- d_us |>
  left_join(election_clean, by = "state")

head(d_map)
nrow(d_us)    # same number of rows — every vertex is still there
nrow(d_map)   # same! join matched correctly


# --- STEP 4: Draw the basic choropleth ---

# CODING CHALLENGE 1: Draw the US map first with no data colouring
# White fill, thin black borders
d_map |>
  ggplot(aes(x = lon, y = lat, group = group)) +
  geom_polygon(fill = "white", colour = "gray30", linewidth = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  labs(title = "US States (no data)")


# --- STEP 5: Colour by winner (party) ---

d_map |>
  ggplot(aes(x = lon, y = lat, group = group, fill = party)) +
  geom_polygon(colour = "gray30", linewidth = 0.1) +
  scale_fill_brewer(palette = "Set1", direction = -1) + 
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  labs(title = "2016 US Election: Winner by State", fill = NULL) +
  theme_void()


# --- STEP 6: Colour by margin of victory (continuous) ---

# r_points: positive = Trump won, negative = Clinton won
# Use a DIVERGING colour scale centred at 0 (no winner = neutral colour)

d_map |>
  ggplot(aes(x = lon, y = lat, group = group, fill = r_points)) +
  geom_polygon(colour = "gray30", linewidth = 0.1) +
  scale_fill_gradient2(
    low = "steelblue",   # strongly Democratic
    mid = "white",       # toss-up / no clear winner
    high = "tomato2",    # strongly Republican
    midpoint = 0
  ) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  labs(
    title = "2016 US Election: Margin of Victory by State",
    fill = "R margin"
  ) +
  theme_void() +
  theme(legend.position = "right")




# =============================================================================
# SUMMARY: Key Concepts from Lecture 20
# =============================================================================

# 1. Polygon maps: geom_point vs geom_polygon on the same data — just different geoms
#
# 2. Coordinate systems:
#    coord_quickmap() → fast approximation, good for exploration
#    coord_map()      → formal projections (mercator, albers, lambert, gall, ...)
#    coord_sf()       → modern sf standard (coming in later lectures)
#
# 3. Choropleth maps:
#    → Geographic areas coloured by a variable (like a geographic heatmap)
#    → Can use BINARY colour (winner) or CONTINUOUS scale (margin)
#    → scale_fill_gradient2() for diverging scales with a midpoint
#    → Colour choice significantly affects perception!
#
# 4. Explore spatially BEFORE mapping:
#    → Scatter plots and dot plots first, then contextualise with a map
#    → Maps exaggerate large, sparse areas — non-spatial views treat all units equally
#
# 5. Joining spatial + attribute data:
#    → map_data() gives polygon vertices (spatial)
#    → election gives vote shares (attribute)
#    → left_join() by a shared key (state name) merges them
#    → The join REPEATS attribute values across all vertices of each polygon

