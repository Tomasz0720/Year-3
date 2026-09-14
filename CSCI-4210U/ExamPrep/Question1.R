# Given

edu_data <- data.frame(
  state_name = c("california", "texas", "new york", "florida",
                 "illinois", "ohio", "georgia", "michigan",
                 "pennsylvania", "north carolina"),
  bachelors_pct = c(35.0, 30.7, 37.8, 31.5,
                    34.9, 28.9, 32.5, 29.1,
                    33.7, 33.4),
  avg_salary_k = c(82, 58, 74, 55, 67, 52, 56, 54, 63, 51)
)



state_capitals <- data.frame(
  city = c("Sacramento", "Austin", "Albany", "Tallahassee",
           "Springfield", "Columbus", "Atlanta", "Lansing",
           "Harrisburg", "Raleigh"),
  lon = c(-121.49, -97.74, -73.76, -84.28,
          -89.65, -82.99, -84.39, -84.55,
          -76.88, -78.64),
  lat = c(38.58, 30.27, 42.65, 30.44,
          39.78, 39.96, 33.75, 42.73,
          40.27, 35.78)
)

# ----------------------------

library(maps)
library(ggplot2)
library(tidyverse)

# Get the map data (polygons for each state)
us_map <- map_data("state")
us_map

# Join the map data state polygons with the edu_data which has column "state_name" so that dataset has polygons for the state.
us_map_joined <- left_join(us_map, edu_data, by = c("region" = "state_name"))


ggplot() + 
  geom_polygon(data = us_map_joined, # Use the polygon data from us_map_joined.
               aes(x = long, # x is long column.
                   y = lat,  # y is lat column.
                   group = group, # A single state can have multiple polygons because of things like islands. They are all connected by group.
                   fill = bachelors_pct), # fill based on column bachelors_pct.
               colour = "white") + # Colour of the lines between states
  
  
  geom_point(data = state_capitals, # Add data points at the locations of each state capital.
             aes(x = lon, # x is lon.
                 y = lat), # y is lat.
             colour = "red", shape = 18, size = 5) + # Make the colour of the point red, use shape 10 (dot).
  
  geom_text(data = state_capitals, # Add labels at each of the state capitals
             aes(x = lon, # x is lon.
                 y = lat, # y is lat.
                 label = city), # Label is column "city"
             vjust = -1, size = 3, fontface = "italic") + # Shift the label up by one, set the size to 3, font italic.
  
  
  scale_fill_gradient(low = "grey90", high = "darkgreen", name = "Bachelor's %") + 
  
  coord_map() + # Change the projection.
  
  theme_void() + # Remove gridlines.
  
  labs(title = "Bachelor's Degree Attainment by US State",
       caption = "Percentage of population with a bachelor's degree -- capital cities shown as red diamonds.") # Add a title.












