############################################################
# L11_EXAM_PRACTICE.R
############################################################

library(ggplot2)
library(nlme) # Required for Oxboys data

data(mpg)
data(Oxboys)

# --- 1. AESTHETIC MAPPINGS ---

# Task 1.1: Global vs Local.

# REQUIREMENT: Use 'mpg'. 
# p1: Set color globally to 'class', set size locally to 'cyl'.
# p2: Set size globally to 'cyl', set color locally to 'class'.

p1 <- ggplot(mpg, aes(____)) + geom_point(aes(____))
p2 <- ggplot(mpg, aes(____)) + geom_point(aes(____))

# Task 1.2: Identity vs Mapping.

# REQUIREMENT: 
# p3: Map the string "red" INSIDE aes(). 
# p4: Set the color "red" OUTSIDE aes().

p3 <- ggplot(mpg, aes(displ, hwy)) + geom_point(aes(____))
p4 <- ggplot(mpg, aes(displ, hwy)) + geom_point(____)


# --- 2. FACETING ---

# Task 2.1: Wrap vs Grid.

# REQUIREMENT: 
# p_wrap: Facet by a single variable 'class'.
# p_grid: Facet by a grid of 'drv' (rows) and 'cyl' (columns).

p_wrap <- ggplot(mpg, aes(displ, hwy)) + geom_point() + ____(~____)
p_grid <- ggplot(mpg, aes(displ, hwy)) + geom_point() + ____(____ ~ ____)

# Task 2.2: Constraints.

# REQUIREMENT: Modify p_wrap to force exactly 3 columns and allow "free" y-scales.

p_wrap_free <- p_wrap + facet_wrap(~class, ____ = ____, ____ = "____")


# --- 3. INDIVIDUAL GEOMS ---

# Task 3.1: Geometry Types.

# REQUIREMENT: Using mpg (displ vs hwy), provide the code for:
p_point <- ggplot(mpg, aes(displ, hwy)) + ____()
p_line  <- ggplot(mpg, aes(displ, hwy)) + ____()
p_area  <- ggplot(mpg, aes(displ, hwy)) + ____()

# Task 3.2: Overplotting.
# REQUIREMENT: Create a scatterplot with 80% transparency and a fixed size of 3.

p_alpha <- ggplot(mpg, aes(displ, hwy)) + geom_point(____ = ____, ____ = ____)


# --- 4. GROUPING & COLLECTIVE GEOMS ---

# Task 4.1: Explicit Grouping.
# REQUIREMENT: Use 'Oxboys' (Occasion vs height). 

# p_wrong: A line plot where ggplot connects all points in one "zig-zag".
# p_right: A line plot where each 'Subject' has its own distinct line.

p_wrong <- ggplot(Oxboys, aes(Occasion, height)) + geom_line()
p_right <- ggplot(Oxboys, aes(Occasion, height, group = Subject)) + geom_line()

# Task 4.2: Collective Summaries.

# REQUIREMENT: 
# p_coll1: Create ONE boxplot for the entire 'hwy' column.
# p_coll2: Create multiple boxplots of 'hwy' grouped by 'drv'.

p_coll1 <- ggplot(mpg, aes(x = ____, y = hwy)) + geom_boxplot()
p_coll2 <- ggplot(mpg, aes(x = ____, y = hwy)) + geom_boxplot()

################################