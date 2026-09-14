# Tomasz Puzio - 100904335

library(ggplot2)
library(scales)

# 1

# 1. Make a scatterplot of Year (x) vs. Population (y), with a smoothing regression fit of colour “darkgrey”.
on_plot1 <- ggplot(df_on, aes(x = Year, y = Population)) +
  geom_point() +
  geom_smooth(color = "darkgrey", se = FALSE) +
  
  scale_x_continuous(
    # 2. Limit the x-axis from 2010 to 2020.
    limits = c(2010, 2020),
    
    # 3. Use pretty breaks on the x-axis.
    breaks = pretty_breaks()
  ) +
  
  scale_y_continuous(
    # 4. Use comma labels on the y-axis, with a scale of 1000.
    labels = label_comma(scale = 1000),
  ) +
  
  # 5. Give your graph and y-axis appropriate titles.
  labs(
    title = "Ontario Population, 2010-2020",
    x = "Year",
    y = "Total population"
  )

on_plot1

# 2.

# 6. Update point colour (pop_change).
on_plot2 <- ggplot(df_on, aes(x = Year, y = Population, colour = pop_change)) +
  geom_point() +
  geom_smooth(colour = "darkgrey", se = FALSE) +
  scale_x_continuous(
    limits = c(2010, 2020),
    breaks = pretty_breaks()
  ) +
  scale_y_continuous(
    labels = label_comma(scale = 1000)
  ) +
  
  # 7. Use the colorbrewer scale to colour the points using the “PuRd” palette.
  scale_colour_distiller(
    palette = "PuRd",
    
    # 8. Give the color scale a name, set the limits to (5,NA), with breaks of (5, 10, 15).
    name = "Pop change",
    limits = c(5, NA),
    breaks = c(5, 10, 15)
  ) +
  labs(
    title = "Ontario Population over Time, Coloured by Yearly Change",
    x = "Year",
    y = "Total population"
    
  )

on_plot2

