# Tomasz Puzio - 100904335

library(ggplot2)
library(dplyr)
library(tidyverse)

# 1-3
starwars_bmi <- starwars |>
  # 1. Filter species to those that: end with “man”, or start with either G, D, or W. You’ll need to use the str_detect() in combination with regular expressions.
  filter(str_detect(species, "^[GDW]|man$")) |>
  
  # 2. Calculate the BMI for each character. Then, create a mean BMI for each species (you should have 6 species).
  mutate(bmi = mass/(height/100)^2) |>
  group_by(species) |>
  summarize(mean_bmi = mean(bmi, na.rm = TRUE)) |>
  
  # 3. Create a new column is_bigger, coded with ‘yes’ if BMI > 30, otherwise ‘no’.
  mutate(is_bigger = if_else(mean_bmi < 30, 'no', 'yes'))

# 4-5
# 4. Create a bar graph of your data, with species (x), Mean BMI (y), and BMI>30 (colour).
ggplot(starwars_bmi, aes(x = species, y = mean_bmi, fill = is_bigger)) +
  geom_col() +
  # 5. Give your plot meaningful axes and a title.
  labs(x = "species",
       y = "Body mass index (kg/m^2)",
       fill = "BMI > 30",
       title = "The biggest species in Star Wars")