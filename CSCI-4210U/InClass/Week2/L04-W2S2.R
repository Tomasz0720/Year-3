############################################################
# CSCI 4210U – Information Visualization
# Lecture 04 - R Basics 2 (Scripts, Packages, Data Structures)
# Topics:
# 1) R scripts + running code
# 2) Packages (install vs library)
# 3) Vectors + type coercion
# 4) Subsetting vectors
# 5) Data frames + subsetting
# 6) Logicals + boolean operators
# 7) Querying with boolean logic (mtcars)
#
# This script is designed to be executed line-by-line in RStudio
# (Ctrl+Enter / Cmd+Enter) OR run all at once.
############################################################


############################################################
# 1) SCRIPTS: why we use them
############################################################
# Scripts let you:
# - reuse code
# - debug more easily
# - keep your work organized
#
# Note: objects you create (variables, functions) can remain in memory
# after the script finishes (in your R session), until you restart R.

# Quick sanity print
print("Hello from Lecture 04 script!")


############################################################
# 2) PACKAGES: install vs load (attach)
############################################################
#install.packages("tidyverse") #downloads the package ONCE (per machine).
#library(tidyverse) #loads/attaches it for your CURRENT R session.
#
# In a lecture, it's useful to show both, but typically you comment out
# install.packages after it's installed.

# install.packages("tidyverse")  # <- run once, then comment it out
library(tidyverse)            # <- run each time you start RStudio

# If tidyverse is loaded, you can run a ggplot example like this:
ggplot(mtcars, aes(mpg, wt, colour = cyl)) + geom_point()


############################################################
# 3) VECTORS (Atomic vectors): 1D, ordered, homogeneous
############################################################

# Create a sequence using ":" (colon)
a_sequence <- 5:10
print(a_sequence) # shows the values
a_sequence         # Also shows the values

# Vectors can grow/shrink; c() concatenates (combines) values
d <- c(70, 80, 90)
d
d <- c(1:6, 9, -4, d, 10)
print(d)

# Check if something is a vector
print(is.vector(d))

# Type coercion in R:
# If you mix types in a vector, R will coerce to a "common" type.
x <- 1:5
print(x)

x <- c(x, "hello")   # numeric + character => everything becomes character
print(x)
print(typeof(x))     # "character"


############################################################
# Coding challenge 1:
# Create a function square_it that squares all values in a vector,
# with a default vector 1:10
############################################################

# Function definition:
square_it <- function(x = 1:10) {
  # x is expected to be numeric (vector of numbers)
  # x^2 is vectorized: it applies to all elements at once
  x^2
}

# Demonstrate function:
print(square_it())            # uses default 1:10
print(square_it(c(2, 4, 6)))  # custom input


############################################################
# 4) SUBSETTING A VECTOR (indexing)
############################################################

# seq() can generate sequences with step size
v <- seq(from = 1, to = 30, by = 3)
print(v)

# Access element at index 3 (R is 1-indexed, unlike many languages)
print(v[3])

# Access elements 1 through 5
print(v[1:5])

# Access specific indices using a vector of indices
print(v[c(1, 3, 5)])


############################################################
# 5) DATA FRAMES: 2D, columns can have different types
############################################################

# Built-in dataset: iris
View(iris) # Opens spreadsheet viewer in RStudio (optional)

# Create a data frame manually
# with columns named: "ids", "names", "ages"
df <- data.frame(
  ids = 1:5,
  names = c("Andy", "Sophie", "Avni", "Naeroa", "Chyou"),
  ages = c(23, 19, 38, 52, 43)
)

print(df)

# Dimensionality: rows, columns
print(dim(df))   # c(rows, cols)

# Important: each column is a vector
print(typeof(df$ids))
print(typeof(df$names))
print(typeof(df$ages))


############################################################
# 6) SUBSETTING DATA FRAMES (row, column)
############################################################

# General format:
# df[rows, cols]
# Leaving rows blank means "all rows"
# Leaving cols blank means "all columns"

# All rows, first column
print(df[, 1])

# First row, all columns
print(df[1, ])

# Rows 1 and 5, columns 2 through 3
print(df[c(1, 5), 2:3])


############################################################
# Class challenge 2:
# Using iris dataset, print out rows 1:5, columns 1, 3 and 5 only.
############################################################
# iris rows 1:5, columns 1, 3, 5:
print(iris[1:5, c(1, 3, 5)])


############################################################
# 7) LOGICALS (Booleans in R)
############################################################

# Basic relational operation
print(3 < 4)  # TRUE

# Create a numeric vector and compare
d2 <- 1:7
print(d2)

# Which elements are less than 5?
logical_vec <- d2 < 5
print(logical_vec)

# Logical subsetting:
# Use TRUE/FALSE vector to keep only the TRUE positions
print(d2[logical_vec])

# You *can* subset with an explicit TRUE/FALSE vector (not recommended for long vectors)
print(d2[c(FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE)]) # keeps index 3 only


############################################################
# 8) BOOLEAN OPERATORS
############################################################
# In R:
# &  = AND
# |  = OR
# !  = NOT
# (These are vectorized operators; they work element-wise on vectors.)

print(3 < 4 & 5 > 2)     # TRUE
print(!TRUE | 5 < 2)     # FALSE


############################################################
# 9) QUERYING A REAL DATASET WITH BOOLEAN LOGIC (mtcars)
############################################################

# mtcars is built in (1974 Motor Trend US magazine dataset)
 ?mtcars   # Opens help page (optional)

# Show the first 6 rows
print(head(mtcars))

# Goal:
# Identify 4-cylinder vehicles with mileage below 25 MPG
# Explanation:
# - mtcars$cyl == 4  creates a logical vector
# - mtcars$mpg < 25  creates a logical vector
# - Combine them with & (AND)
# - Use the result to subset rows
inefficient_4cyl <- mtcars[mtcars$cyl == 4 & mtcars$mpg < 25, ]
print(inefficient_4cyl)

# Optional: show just a couple columns to keep it readable
print(inefficient_4cyl[, c("mpg", "cyl", "wt", "hp")])


############################################################
# End of script
############################################################
print("Done. Objects like square_it, df, v, etc. are now in memory.")
