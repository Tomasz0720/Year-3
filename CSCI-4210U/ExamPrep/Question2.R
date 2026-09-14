library(ggplot2)
library(tidyverse)
library(scales)

diamonds

set.seed(42)
diamond_sample <- diamonds[sample(nrow(diamonds), 2000), ]

diamond_sample

ggplot(diamond_sample, aes(x = carat, y = price, colour = cut)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  
  facet_wrap(~color, nrow = 2) +
  
  scale_y_continuous(labels = label_dollar()) +
  scale_x_continuous(labels = label_number(accuracy = 0.1)) +
  
  scale_colour_viridis_d(name = "Cut Quality") +
  
  labs(
    title = "Diamond Price vs Carat Weight by Cut Quality",
    subtitle = "Faceted by diamond colour grade (D through J)",
    x = "Carat Weight",
    y = "Price (USD)"
  ) +
  
  theme_minimal() +
  
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

