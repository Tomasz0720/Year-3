##### Lecture 14
graphics.off()

library(tidyverse)
library(scales)
library(RColorBrewer)

#### 1. Color Theory Refresh ####
# RGB is not perceptually uniform; unit changes don't correspond to human perception
# HCL (Hue, Chroma, Luminance) is preferred 
# - Hue: The "color" (0-360 wheel). Not perceived as ordered
# Chroma: The purity of the color (0 is grey)
# Luminance: The lightness (0 is black, 1 is white)





#### 2. Continuous Color Scales ####
# Used for 2D surfaces or continuous variables 

# Viridis: Perceptually uniform, color-blind safe, and B&W friendly
# faithfuld: 2D density data of geyser eruptions
ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  # geom_raster: Creates a heatmap using colored tiles
  geom_raster() +
  # scale_fill_viridis_c: Continuous, color-blind safe, and B&W friendly scale
  scale_fill_viridis_c(option = "magma") # Options: 'magma', 'inferno', 'plasma', 'viridis'



# scale_fill_distiller
# faithfuld: 2D density data of geyser eruptions 
ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  # geom_raster: Draws a heatmap surface using colored tiles 
  geom_raster() +
  # scale_fill_distiller: Interpolates discrete ColorBrewer palettes for continuous data 
  scale_fill_distiller(palette = "Blues")
# scale_fill_fermenter(): Use this for binned data (quantized ranges).
# scale_fill_brewer(): Use this only for discrete (categorical) data.





#### 3. Discrete Color Scales ####
# Categorical data requires distinct colors
# Default is scale_fill_discrete() -> scale_fill_hue()

bars <- ggplot(mpg, aes(class, fill = class)) + geom_bar()

# Qualitative palettes: Suited for unordered data like 'Race' or 'Class'
bars + scale_fill_brewer(palette = "Set1") 

# Sequential/Diverging: Suited for ordered or mid-range focused data 
RColorBrewer::display.brewer.all() # View all palettes 

# Grayscale: Essential for black and white printing
bars + scale_fill_grey()





#### 4. Guides: Axes and Legends ####
# Guides provide the inverse mapping: visual -> data
# Position Scale -> Axis | Color Scale -> Legend

# Modification via guides() or scale arguments
ggplot(mpg, aes(displ, hwy, colour = cyl)) +
  geom_point() +
  guides(
    x = guide_axis(title = "Engine Displacement (L)"), 
    colour = guide_legend(title = "Cylinders")       
  )




# scale_fill_viridis_d
ggplot(faithfuld, aes(waiting, eruptions, fill = cut(density, 5))) +
  geom_raster() +
  scale_fill_viridis_d(option = "magma")
