############################################################
# CSCI 4210U – Information Visualization
# Lecture 03: Design + R Intro + Functions
#
# Topics reflected from the lecture slides:
#  a) Getting started with R (sequences, variables, assignment, array-based programming)
#  b) Functions in R (positional vs tagged arguments, default arguments, best practices)
#


############################################################
# Part 1 — Getting started with R (console basics)
############################################################

# In RStudio:
# - Console: where code runs
# - Script editor: where you *write* code (recommended)
# - Environment: shows your variables
# - Plots/Help/Packages: outputs, docs, etc.

############################################################
# 1A) Creating sequences
############################################################

# Colon operator creates a sequence of integers with step +1 (or -1).
100:130

# Indexing is 1-based in R (first element is index 1).
# Example: get the 14th value of 100:130
x <- 100:130
x[14]

# Example: get the 25th value
x[25]

# output? 
x[202]

# seq(from, to, by) is more flexible than the colon operator.
seq(1, 5)                    # 1 2 3 4 5
seq(from = 1, to = 20, by = 3)

# You can also specify length instead of 'to'.
seq(from = 0, by = 2, length.out = 5)  # first five even numbers starting at 0

#seq(from = 0, to = 4, by = 2, length.out = 5)  # Output?

############################################################
# 1B) Variable names
############################################################

# Variable names can contain:
# - letters [a-z, A-Z]
# - numbers [0-9]
# - period '.'
# - underscore '_'
# Must start with a letter or period.

age <- 48
my_value <- 10
my.value <- 11

############################################################
# 1C) Assignment with <-
############################################################

# In R, the standard assignment operator is <- (you will see = sometimes too).
d <- seq(from = 1, to = 20, by = 3)
d

############################################################
# 1D) Array-based (vectorized) programming
############################################################

# R is vectorized: operations you write for scalars typically apply element-wise to vectors.
die <- 1:6
die / 2

# More examples:
die + 10
die ^ 2

# Element-wise operations between vectors of the same length:
a <- c(1, 2, 3)
b <- c(10, 20, 30)
a + b

############################################################
# 1E) Coding challenge (from slides)
############################################################

# In ONE line:
# - Create a sequence of first five even numbers
# - Multiply them by 3
# - Square them

(3 * seq(from = 0, length.out = 5, by = 2))^2

############################################################
# Part 2 — Functions in R (sample + arguments)
############################################################

############################################################
# 2A) sample(): random sampling
############################################################

# sample(x, size, replace = FALSE, prob = NULL)
#
# x        : vector to sample from (required)
# size     : how many draws (default = length(x))
# replace  : TRUE means you can draw the same value multiple times
# prob     : probabilities per element in x (default = NULL = uniform)

# Example: draw 4 numbers from 1..10 WITH replacement
set.seed(1)  # makes randomness reproducible for teaching
sample(1:10, size = 4, replace = TRUE)

#sample(1:3, size = 5, replace = FALSE) # Output? 

# Try without replacement (default replace = FALSE):
sample(1:10, size = 4)

############################################################
# 2B) Positional vs tagged (named) arguments
############################################################

# Positional arguments: meaning is decided by position.
# Tagged arguments: meaning is decided by the name; order doesn't matter.

# These are equivalent:
sample(1:10, size = 4, replace = TRUE)
sample(x = 1:10, 4, TRUE)
sample(size = 4, replace = TRUE, x = 1:10)

############################################################
# 2C) Default arguments (why you can omit things)
############################################################

# If size is omitted, it defaults to length(x).
sample(1:4)

# If replace is omitted, it defaults to FALSE.
sample(1:4, size = 2)

# With replacement:
sample(1:4, size = 3, replace = TRUE)

# With replacement AND weighted probabilities:
# Here: faces 2 and 4 are more likely than 1 and 3 (probabilities must match x length)
sample(1:4, size = 4, replace = TRUE, prob = c(0, 0.5, 0, 0.5))

############################################################
# 2D) Best practice note (from slides)
############################################################

# Best practice:
# - Use tags for clarity (especially when a function has many parameters)
# - Respect positional order when you DO use positional parameters
# - Omit parameters when defaults are fine

############################################################
# Part 3 — Structure of an R function
############################################################

# General pattern:
# name <- function(arg1, arg2 = default_value, ...) {
#   # body
#   return(result)  # return() is optional if last line is the value
# }

############################################################
# 3A) Write a simple function that uses seq()
############################################################

# Example: first_n_even() returns the first n even numbers starting at 0.
first_n_even <- function(n = 5) {
  # n: how many even numbers to generate
  seq(from = 0, by = 2, length.out = n)
}

first_n_even()       # default n = 5
first_n_even(10)     # n = 10

############################################################
# 3B) A function that combines steps (like the coding challenge)
############################################################

even_transform <- function(n = 5, mult = 3) {
  # Generates first n even numbers (0,2,4,...), multiplies by 'mult', then squares.
  # Returns the transformed vector.
  (mult * seq(from = 0, by = 2, length.out = n))^2
}

even_transform()
even_transform(n = 8, mult = 2)

############################################################
# 3C) Make a small wrapper around sample() for teaching
############################################################

roll_die <- function(n = 1, replace = TRUE) {
  # Rolls a standard 6-sided die n times.
  # replace = TRUE is realistic because each roll is independent.
  sample(x = 1:6, size = n, replace = replace)
}

set.seed(2)
roll_die()
roll_die(10)

############################################################
# 3D) Slightly more advanced: weighted die
############################################################

weighted_die_roll <- function(n = 10, prob = rep(1/6, 6), replace = TRUE) {
  # Rolls a die with custom probabilities.
  #
  # prob: probabilities for faces 1..6 (must sum to 1)
  # replace: keep TRUE (rolling a die is “with replacement”)
  
  if (length(prob) != 6) stop("prob must be length 6")
  if (abs(sum(prob) - 1) > 1e-8) stop("prob must sum to 1")
  
  sample(x = 1:6, size = n, replace = replace, prob = prob)
}

set.seed(10)
weighted_die_roll()                    # fair die by default
weighted_die_roll(n = 5)               # fewer rolls
weighted_die_roll(n = 12, prob = c(0.05, 0.05, 0.05, 0.05, 0.1, 0.7))  # loaded die

############################################################
# End of script
############################################################

