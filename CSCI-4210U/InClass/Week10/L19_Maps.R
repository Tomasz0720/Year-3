# =============================================================================
# CSCI 4210U – Information Visualization
# Lecture 19: Maps 1
# =============================================================================
# Topics:
#   1. Maps and Statistical Graphics
#   2. Geocoding
#   3. Latitude and Longitude
#   4. Map Projections
#   5. Polygon Maps in R
# =============================================================================

# --- Install missing packages ---
pkgs <- c("tidyverse", "tidygeocoder", "maps", "mapdata", "mapproj",
          "sf", "ozmaps", "rmapshaper", "devtools")
pkgs_new <- pkgs[!pkgs %in% installed.packages()[, "Package"]]
if (length(pkgs_new)) install.packages(pkgs_new)

# socviz is a GitHub-only package
if (!requireNamespace("socviz", quietly = TRUE)) {
  devtools::install_github("kjhealy/socviz")
}


# =============================================================================
# SECTION 1: MAPS AND STATISTICAL GRAPHICS
# =============================================================================

# Maps are a type of statistical graphic — you read them the same way:
#   - You look for patterns, clusters, and spatial trends
#   - Instead of abstract x/y axes, you use LATITUDE and LONGITUDE
#     which correspond to real-world geography

# KEY DIFFERENCE between maps and regular plots:
#   - In a dot plot, the distance between two points is ABSTRACT (no real units)
#   - In a map, the distance between two points is CONCRETE (miles, km, travel time)
#
# This makes maps personally immediate — you immediately relate to locations.
# Think: what was the FIRST thing you searched on Google Maps?

# SCOPE NOTE: Spatial data analysis is a huge field.
#   People earn entire degrees in Geoinformatics, Cartography, and Geography.
#   This course covers the BASICS needed to create useful map visualizations.


# =============================================================================
# SECTION 2: GEOCODING
# =============================================================================

# GEOCODING = transforming a human-readable address into a spatial location
#             (latitude and longitude coordinates)
#
# Analogy: think of DNS (Domain Name System):
#   - You type "www.apple.com" → DNS translates it to an IP like 17.172.224.47
#   - You type "Ontario Tech University" → geocoder translates it to lat/lon
#
# REVERSE GEOCODING = the opposite: given lat/lon, return a human-readable address

library(tidyverse)
library(tidygeocoder)  # for geo() and reverse_geo()




# --- Forward Geocoding: Address → Coordinates ---

# geo() takes a place name and returns lat/lon
# method = "osm" uses OpenStreetMap's free geocoding service (Nominatim)

ad1 <- geo("Ontario Tech University", method = "osm")
ad1
# Returns: address | lat | long

ad2 <- geo("Eiffel Tower", method = "osm")
ad2

# TRY IT: Copy these coordinates into Google Maps to verify!
# Ontario Tech: approximately 43.948, -78.898
# Eiffel Tower: approximately 48.858, 2.294


# --- Reverse Geocoding: Coordinates → Address ---

# reverse_geo() takes lat/lon and returns a human-readable address
reverse_geo(lat = ad1$lat, long = ad1$long, method = "osm")


# --- Round Trip: Address → Coords → Address ---

# You can chain geocoding and reverse geocoding together:
# 1. geo() converts address to lat/lon
# 2. as.list() converts the result to a list
# 3. do.call() passes that list as arguments to reverse_geo()

do.call(reverse_geo, c(as.list(geo("Ontario Tech University", method = "osm")[, 2:3]), # Entire row, column 2, column 3
                       list(method = "osm")))

# This is a "round trip": address → lat/lon → address again
# Useful for verifying geocoding accuracy


# =============================================================================
# SECTION 3: LATITUDE AND LONGITUDE5
# =============================================================================

# Earth's position needs a coordinate system.
# We are familiar with:
#   - Cartesian coordinates (x, y) for flat 2D space
#   - Polar coordinates (r, θ) for 2D space using angle + distance
# Geography uses its own system based on angles.

# --- GEOGRAPHIC COORDINATE SYSTEM ---
# Enables EVERY location on Earth to be specified using two angles:
#   1. LATITUDE  (φ, phi)
#   2. LONGITUDE (λ, lambda)
# (Plus optionally ELEVATION for 3D)


# --- LATITUDE ---
# φ (phi) = the angle between:
#   - the EQUATORIAL PLANE (flat circle through Earth's middle)
#   - a straight line from the point to Earth's CENTER
#
# Range: 0° at the Equator → 90° at the North Pole → -90° at the South Pole
#   - POSITIVE latitude = Northern Hemisphere
#   - NEGATIVE latitude = Southern Hemisphere
#
# Lines of constant latitude are called PARALLELS or "circles of latitude"
# They run EAST–WEST and never intersect each other.


# --- LONGITUDE ---
# λ (lambda) = the angle East or West of the PRIME MERIDIAN (reference line)
#
# Range: 0° at the Prime Meridian → +180° East → -180° West
#   - POSITIVE longitude = Eastern Hemisphere (e.g. Sydney ~+151°)
#   - NEGATIVE longitude = Western Hemisphere (e.g. New York ~-74°)
#
# Lines of constant longitude are called MERIDIANS
# They run NORTH–SOUTH and converge at the poles.
# Each meridian is a "half of an imaginary great circle" terminated by the poles.


# --- WHERE IS THE PRIME MERIDIAN? ---
# The Prime Meridian (0° longitude) runs through:
#   Greenwich, London, UK — specifically the British Royal Observatory.
#
# WHY did Greenwich become the reference?
#   - John Flamsteed (1646–1719) was the first Astronomer Royal at Greenwich
#     and created influential star charts used for navigation.
#   - Nevil Maskelyne (1732–1811) published the Nautical Almanac from Greenwich
#     (a crucial navigation tool for sailors worldwide).
#   - By the time an international standard was needed, Greenwich was already
#     the most widely used reference point — so it was officially adopted.


# --- CLASS QUESTION: Ontario Tech Coordinates ---
# Ontario Tech University: lat = 43.94833, lon = -78.89817
#
# WHY positive latitude?
#   → Ontario Tech is in the NORTHERN hemisphere → latitude is positive
#
# WHY negative longitude?
#   → Ontario Tech is WEST of the Prime Meridian → longitude is negative
#   → It is in the Western Hemisphere

# Quick check using our geocoder:
geo("Ontario Tech University", method = "osm")


# --- ELEVATION ---
# Height above or below a reference surface called the GEOID
# The geoid approximates mean sea level across the globe.
#
# NOTE: This course only covers 2D maps (lat/lon only).
#       We will NOT work with elevation data.


# =============================================================================
# SECTION 4: MAP PROJECTIONS
# =============================================================================

# PROBLEM: Earth is a 3D sphere (actually a slightly flattened ellipsoid).
#          We want to display it on a flat 2D screen or paper.
#          → This requires a MAP PROJECTION.
#
# A map projection is a SYSTEMATIC MATHEMATICAL TRANSFORMATION
# from spherical (lat/lon) coordinates to flat (x/y) coordinates.
#
# FUNDAMENTAL TRUTH: ALL map projections distort reality in some way.
#   You CANNOT perfectly represent a curved surface on a flat plane.
#   (Think of peeling an orange and trying to lay the peel flat — it tears.)
#
# Different projections PRESERVE different properties:
#   - Shape (conformal projections)
#   - Area  (equal-area projections)
#   - Distance
#   - Direction
#   But NOT all of these at once!


# --- MERCATOR PROJECTION ---
# Preserves: shape (conformal) and direction (useful for navigation)
# Distorts:  AREA — regions far from the equator appear MUCH larger than they are
#
# Famous example of Mercator distortion:
#   - Greenland looks as big as Africa
#   - In reality, Africa is ~14× larger than Greenland!
#
# Continents ranked by actual area:
#   1. Asia  2. Africa  3. North America  4. South America
#   5. Antarctica  6. Europe  7. Australia
#
# Google Maps uses Mercator — why?
#   Most people look at Google Maps at STREET LEVEL.
#   At that zoom level, Mercator is highly accurate because distortion is minimal.
#   It also preserves shapes well, so roads look correct.


# --- GALL-PETERS PROJECTION ---
# An EQUAL-AREA projection: every region is shown at its correct relative size.
# Distorts: SHAPE — countries appear stretched or compressed.
#
# Historical/political significance:
#   - Promoted by UNESCO and adopted by British schools
#   - In March 2017, Boston Public Schools became the FIRST US public school
#     district to officially adopt it (to better represent relative country sizes)
#   - The debate between Mercator and Gall-Peters is partly political —
#     Mercator makes the Global North look larger (and thus more "important")


# --- PRACTICAL: Which projection to use in R? ---
# In ggplot2 / maps package, you can specify projections with coord_map()
# We will see this in action in the code section below and in Lecture 20.

# Preview:
library(maps)
library(mapproj)

# We will use:
#   coord_quickmap() — fast approximation, good for most purposes
#   coord_map()      — uses mapproj for formal projections
#   coord_sf()       — from the sf package, the modern standard (Lecture 21+)


# =============================================================================
# SECTION 5: POLYGON MAPS IN R
# =============================================================================

# --- THE MAPPING ECOSYSTEM IN R ---
# Several packages work together:
#   - maps / mapdata   : databases of geographic boundary data
#   - ggplot2          : drawing the maps with geom_polygon()
#   - mapproj          : map projection math for coord_map()
#   - sf               : "simple features" — the modern ISO standard for spatial data
#   - tidygeocoder     : geocoding (forward and reverse)
#   - ozmaps           : Australian maps
#   - rmapshaper       : simplifying complex map boundaries (for performance)
#   - socviz           : Kieran Healy's book companion data (election data, etc.)


# --- POLYGON MAPS: THE SIMPLEST APPROACH ---
# A POLYGON is a closed chain of straight-line segments (edges connecting vertices/corners).
# A map boundary (e.g., a country or state) is represented as a polygon (or multiple polygons).
#
# Workflow:
#   1. Get polygon data: map_data() converts maps package data to ggplot2-friendly format
#   2. Plot with: geom_polygon()
#   3. Fix the aspect ratio: coord_quickmap() or coord_map()


# --- LOADING MAP DATA ---

library(maps)

# Group is like if you have 3 islands, put the pen down, draw one island (ONE GROUP), then pick up the pen and move to the next group, etc.
# Region is the ares inside of the groups.

d_italy <- map_data("italy") |>
  select(lon = long, lat, group, id = region) |>  # rename for clarity
  as_tibble()

head(d_italy)
# Each ROW is one VERTEX (corner point) of a polygon
# The map is drawn by connecting these vertices IN ORDER, within each group


# --- UNDERSTANDING THE FOUR KEY VARIABLES ---
# lon   : longitude of this vertex
# lat   : latitude of this vertex
# group : which polygon (contiguous area) this vertex belongs to
#         (important! — tells ggplot2 when to "lift the pen")
# id    : human-readable name of the region (e.g., "Bolzano-Bozen")
#
# WHY do we need BOTH group AND id?
#   Some geographic units are NON-CONTIGUOUS (not one connected piece).
#   Example: Hawaii consists of multiple separate islands, each a separate polygon.
#   Each island needs its own GROUP (so ggplot lifts the pen between islands),
#   but they all share the same ID ("hawaii").
#   → group = unique polygon identifier
#   → id    = geographic unit name (may map to multiple groups)

# How many unique groups vs unique regions?
d_italy |> summarise(n_groups = n_distinct(group), n_regions = n_distinct(id))


# --- THE "BROKEN" MAP: WHAT HAPPENS WITHOUT group? ---

# WRONG: missing the group aesthetic
# ggplot connects ALL points in order, crossing between different regions
d_italy |>
  ggplot(aes(x = lon, y = lat)) +
  geom_polygon(fill = "lightgrey", colour = "gray12", linewidth = 0.25) +
  coord_quickmap()

# This looks terrible! ggplot connects the last vertex of one region
# to the first vertex of the next region, drawing spurious lines across the map.


# =============================================================================
# CODING CHALLENGE 2: Fix the Italy Plot
# =============================================================================

# The problem: we need to tell ggplot2 which vertices belong to the same polygon
# Solution: add group = group to the aesthetic mapping

# YOUR TURN: Fix the map by adding the group aesthetic
# Hint: add group = group inside aes()

# --- SOLUTION ---
d_italy |>
  ggplot(aes(x = lon, y = lat, group = group)) +   # <-- group aesthetic added
  geom_polygon(fill = "lightgrey", colour = "gray12", linewidth = 0.25) +
  coord_quickmap()

# Now ggplot2 knows to "lift the pen" between different polygons.
# Each group is drawn separately, so no spurious lines cross the map.


# --- WHAT DOES coord_quickmap() DO? ---
# Maps need the correct ASPECT RATIO or they look distorted.
# coord_quickmap() sets the ratio so that:
#   1 degree of latitude ≈ 1 degree of longitude (in the MIDDLE of the plot)
# It is a FAST APPROXIMATION — good enough for most purposes.
# For more accurate projections, use coord_map() (slower) or coord_sf() (modern standard).


# --- EXPLORING OTHER AVAILABLE MAPS ---
# The maps package includes several built-in databases:
#   "world"  — world map
#   "usa"    — USA outline
#   "state"  — US states
#   "county" — US counties
#   "france" — France regions
#   "italy"  — Italy regions
#   "nz"     — New Zealand

# Example: world map
d_world <- map_data("world") |>
  select(lon = long, lat, group, id = region) |>
  as_tibble()

d_world |>
  ggplot(aes(x = lon, y = lat, group = group)) +
  geom_polygon(fill = "lightgrey", colour = "gray12", linewidth = 0.1) +
  coord_quickmap()


# =============================================================================
# SUMMARY: Key Concepts from Lecture 19
# =============================================================================

# 1. Maps ARE statistical graphics — same visual reasoning applies
# 2. Geocoding: address → lat/lon (tidygeocoder::geo())
#    Reverse geocoding: lat/lon → address (tidygeocoder::reverse_geo())
# 3. Latitude (φ): angle N/S of equator; positive = North, negative = South
#    Longitude (λ): angle E/W of Prime Meridian; positive = East, negative = West
# 4. All map projections distort — different projections preserve different properties
#    Mercator: preserves shape/direction, distorts area
#    Gall-Peters: preserves area, distorts shape
# 5. Polygon maps in R:
#    - map_data() to get boundary data (lon, lat, group, id)
#    - geom_polygon() to draw
#    - group aesthetic is CRITICAL (tells ggplot when to lift the pen)
#    - coord_quickmap() to fix aspect ratio
