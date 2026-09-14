# =============================================================================
# Lecture 22 - Maps 4: County Maps, Simple Features & Overlaying Data
# CSCI 4210U - Information Visualization
# =============================================================================

# In this session, we will learn about:
#   1. County-level choropleth maps (finer geographic detail than states)
#   2. Simple features (sf) - the modern standard for geospatial data in R
#   3. Overlaying multiple layers (state borders, cities, labels) on a map

# Load required libraries
library(tidyverse)    # Core data manipulation and visualization
library(maps)         # Provides map data
library(socviz)       # Contains county_map and county_data
library(sf)           # Simple features for geospatial data
library(ggthemes)     # Extra themes for ggplot2, including theme_map()
# install.packages("sf")       # Run this if sf is not installed
# install.packages("ggthemes") # Run this if ggthemes is not installed


# =============================================================================
# PART 1: County-Level Maps
# =============================================================================

# In L21, we mapped data at the STATE level. But the US has a finer
# geographic division: COUNTIES.
#
# A county is an administrative/political subdivision of a state.
# There are over 3,000 counties in the US, giving us much more detail.
#
# The socviz package provides two relevant datasets:
#   - county_map  : lat/lon polygon data for all US counties
#                   (already projected to Albers equal-area projection)
#   - county_data : survey data at the county level (demographics, etc.)
#
# To combine them, we use a FIPS code as the key.
# A FIPS code is a unique numeric identifier assigned to every US state
# and county by the federal government.


# --- Step 1: Join county map and county data ---
head(county_map)
# DESCRIPTION OF YOUR COUNTY_MAP COLUMNS:
# 1. long:   The X-coordinate (projected longitude) for the boundary points.
# 2. lat:    The Y-coordinate (projected latitude) for the boundary points.
# 3. order:  The sequence number telling R how to connect the dots in order.
# 4. hole:   Logical (TRUE/FALSE); indicates if the area is a "hole" inside 
#            a polygon (like a lake or an enclave).
# 5. piece:  Used for counties with multiple parts (like islands); each 
#            distinct landmass is a different "piece."
# 6. group:  The unique identifier for the specific polygon shape being drawn.
# 7. id:     The 5-digit FIPS code (e.g., '01001'); this is the standard 
#            geographic ID used by the US Census and for data merging.


head(county_data)
# DESCRIPTION OF COUNTY_DATA COLUMNS:
# 1. id:            The 5-digit FIPS code; used to join this data with the map.
# 2. name:          The name of the county (e.g., Autauga County).
# 3. state:         The 2-letter state abbreviation (e.g., AL for Alabama).
# 4. census_region: The broad US region (e.g., South, West, Northeast).
# 5. pop_dens:      Population density (people per sq mile) as a categorical range.
# 6. pct_black:     The percentage of the population identifying as Black/African American.
# 7. pop:           The total population count for that specific county.
# 8. female:        The percentage of the population identifying as female.
# 9. white / black: The percentage breakdown of these racial demographics.
# 10. travel_time:  The average commute time (in minutes) for residents.
# 11. land_area:    The physical size of the county in square miles.
# 12. hh_income:    The median household income for the county.
# 13. votes_dem/gop: Raw vote counts for Democratic/Republican candidates in 2016.
# 14. per_dem/gop:  The percentage of the vote for each party in 2016.
# 15. diff_2016:    The margin of victory/difference between the two main parties.



d_county_map <- left_join(county_map, county_data, join_by(id)) |>
  as_tibble() |>
  rename(lon = long)

# Take a look at the data
d_county_map
glimpse(d_county_map)


# --- Step 2: Create a county-level choropleth map of population density ---
ggplot(d_county_map, aes(x = lon, y = lat, group = group, fill = pop_dens6)) +
  geom_polygon(color = NA) +
  scale_fill_brewer(palette = "Blues", name = "Population\nper sq. mile") +
  coord_equal() +
  theme_map() +
  theme(legend.position = "right") +
  ggtitle("US county-level population density")

# Explanation:
#   - fill = pop_dens6 : a categorical variable with 6 bins of pop. density
#   - geom_polygon(color = NA) : no borders between counties (too many!)
#   - scale_fill_brewer() : uses a sequential blue palette
#   - coord_equal() : preserves aspect ratio (data already projected)




# =============================================================================
# PART 2: Simple Features (sf)
# =============================================================================

# The polygon maps we've created so far work well, but geographic data
# can have complicated structures. Representing everything as (x, y) points
# has its limitations.
#
# Real-world mapping systems use "simple features" - an ISO standard
# produced by the Open Geospatial Consortium.
#
# The sf package (2018) implements this standard in R.

# What are simple features?
# -------------------------
# An sf object represents geographic things as "features". Each feature has:
#   - A geometry  : describes WHERE on earth the feature is located
#   - Attributes  : other data associated with the feature (name, population, etc.)
#
# Features are geospatial "objects" (in an OOP sense).
# As objects, you can perform complex geospatial operations, for example:
#   st_intersects() - do two geometries spatially intersect?
#   st_touches()    - do two geometries touch, but not overlap?


# --- sf and ggplot2 ---
# The tidyverse team has adopted the sf standard. ggplot2 provides:
#   geom_sf()  - plots the geometry of an sf object
#   coord_sf() - ensures all layers use the same Coordinate Reference System (CRS)
#
# A CRS defines the map projection and its parameters (origin, etc.).


# --- Loading sf data ---
# The sf package includes a sample shapefile for North Carolina.
# st_read() reads shapefiles and other geospatial formats into sf objects.

nc <- st_read(system.file("shape/nc.shp", package = "sf"))

# Let's inspect the data
print(nc, n = 3)

# Notice the 'geometry' column - this holds the polygon data for each county.
# The data also includes information on live births and sudden infant deaths
# (SIDS) for 1974-1978 and 1979-1984.


# --- Plotting sf data with ggplot2 ---
# With sf objects, ggplot2 automatically knows how to draw the geometries.

ggplot(nc) +
  geom_sf(aes(fill = BIR79)) +
  scale_fill_viridis_c(name = "Live births") +
  coord_sf(crs = st_crs(4326))
# coord_sf(crs = st_crs(3857))
# coord_sf(crs = st_crs(2163))
# coord_sf(crs = st_crs(2264))

# Explanation:
#   - geom_sf() automatically uses the 'geometry' column
#   - fill = BIR79 : colors each county by the number of live births in 1979
#   - scale_fill_viridis_c() : a perceptually uniform color scale
#   - coord_sf(crs = st_crs(4326)) : uses WGS 84 (standard GPS) projection


# =============================================================================
# Converting Existing Data to sf Format
# =============================================================================

# Much existing geospatial data is NOT in sf format.
# The sf package can convert it using st_as_sf().
oldData <- map("county")
glimpse(oldData)


# Here we load US county data from the maps package and convert it to sf.
d_county <- st_as_sf(map("county", plot = FALSE, fill = TRUE))

# Take a look
d_county

# The result is an sf object with an 'ID' column (county name) and geometry.


# --- Joining county-level survey data ---
# Our d_county has county names but not FIPS codes.
# The maps package provides county.fips to bridge that gap.

# Step 1: Join with county.fips to get FIPS codes
# Step 2: Join with county_data to get survey data
head(county.fips)
d_county
county_data

d_county <- d_county |>
  inner_join(county.fips, join_by(ID == polyname)) |>
  left_join(county_data, join_by(fips == fips))

d_county

# --- Visualize: Average travel time to work by county ---
ggplot(d_county) +
  geom_sf(aes(fill = travel_time), color = NA) +
  scale_fill_viridis_c(name = "Avg. travel\ntime (min)") +
  coord_sf() +
  theme_map() +
  theme(legend.position = "right") +
  ggtitle("Average travel time to work by US county")


# =============================================================================
# PART 3: Overlaying Data on Maps
# =============================================================================

# Our county map shows travel time, but it would be nice to also show:
#   - State borders (for geographic reference)
#   - City locations (to see if urban areas have longer commutes)
#   - City name labels
#
# We would expect urban areas to have longer commute times than rural areas.
# Let's see if that's true by overlaying cities onto our travel time map.


# --- Step 1: Add state borders ---
# Load state boundary data and convert to sf format
d_state <- st_as_sf(map("state", plot = FALSE, fill = TRUE))


# --- Step 2: Prepare city data ---
# We'll use maps::us.cities, which has city names, populations, and coordinates.
# We don't want to overlay every city in the US, just bigger cities.
# Let's restrict to cities with a population over 400,000.
# We also need to drop cities in Alaska and Hawaii (not on our map).

d_cities <- st_as_sf(
  us.cities,
  coords = c("long", "lat"),   # Which columns hold the coordinates
  crs = 4326,                   # WGS 84 coordinate reference system
  remove = FALSE                # Keep the original long/lat columns
) |>
  filter(
    !(country.etc %in% c("AK", "HI")),   # Drop Alaska and Hawaii
    pop > 4e5                              # Only cities with pop > 400,000
  )

# Take a look at our filtered cities
d_cities


# --- Step 3: Build the layered map ---
# We'll combine all layers: counties, state borders, cities, and city labels.
# To add city names we use geom_sf_label().

ggplot() +
  # Layer 1: County-level travel time (filled polygons)
  geom_sf(data = d_county, aes(fill = travel_time), color = NA) +
  scale_fill_viridis_c(name = "Avg. travel\ntime (min)") +

  # Layer 2: State borders (unfilled, just the outlines)
  geom_sf(data = d_state, fill = NA, color = "white", linewidth = 0.3) +

  # Layer 3: City locations (points)
  geom_sf(data = d_cities, color = "red", size = 1.5) +

  # Layer 4: City name labels
  geom_sf_label(data = d_cities, aes(label = name),
                size = 2, nudge_y = 0.5) +

  # Projection and theme
  coord_sf() +
  theme_map() +
  theme(legend.position = "right") +
  ggtitle("Travel time to work with city overlays")

# Explanation of the layers:
#   - geom_sf(d_county)  : draws county polygons filled by travel time
#   - geom_sf(d_state)   : overlays state borders in white
#   - geom_sf(d_cities)  : plots red dots at city locations
#   - geom_sf_label()    : adds text labels with city names
#   - Each layer uses the SAME coordinate system thanks to coord_sf()
