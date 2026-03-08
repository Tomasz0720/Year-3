# ==============================================================================
# CSCI 4210U - Information Visualization: Regression & Smoothing Demo
# ==============================================================================
# This script covers:
# 1. Linear Regression (Simple models, interpretation, and plotting)
# 2. Making Predictions (Interpolation and Extrapolation)
# 3. Nonparametric Regression (LOESS/LOWESS for smoothing)
# 4. Visualizing Confidence Intervals
# ==============================================================================

# Prerequisites
# We need the 'readr' library to load CSVs 
if(!require(readr)) install.packages("readr")
library(readr)

# We will also use the 'mpg' dataset which typically comes with ggplot2.
# If ggplot2 is not loaded, we can load the data directly or use the library.
if(!require(ggplot2)) install.packages("ggplot2")
library(ggplot2) # Loads the 'mpg' dataset

# ==============================================================================
# PART 1: Linear Regression Basics
# Concepts: Fitting a straight line y = B0 + B1x
# ==============================================================================

# [Slide 6] Example: Predict City Mileage (cty) from Engine Size (displ) - Engine displacement 
# The simplest relationship is linear. We use lm() to fit linear models.
# 𝑦= b + a.𝑥
mpg
m_mpg <- lm(cty ~ displ, data = mpg)


# [Slide 6] Visualize the relationship
# We plot the data points and overlay the "line of best fit".
plot(mpg$displ, mpg$cty, 
     xlab = "Engine displacement (Litres)", 
     ylab = "City mileage (mpg)",
     main = "Linear Regression: MPG vs Displacement")

# Overlay the regression line using abline()
abline(m_mpg, col="red", lwd=2)
#lwd - line thickness (default = 1)

# Interpreting the Model
# summary() provides the F-statistic (model fit vs null) and p-values.
# Key metric: R-squared (variance)
# For mpg data, R^2 is typically high (~0.64), indicating a strong linear fit.
summary(m_mpg)
# p - value < 0.05 (statistically significant) 
# The p-value measures the probability that the relationship you see in your data (e.g., engine size affecting gas mileage) happened purely by random chance.
# High p-value: It’s very possible this pattern is just random noise.
# Low p-value: It is extremely unlikely this pattern is random.


# ==============================================================================
# PART 2: Coding Challenge 1 (Unemployment Data)
# ==============================================================================
#slide [9]
print("--- Running Coding Challenge 1 ---")

# 1. Read the data [Slide 9, 43]
url <- "http://datasets.flowingdata.com/unemployment-rate-1948-2010.csv"
d <- read_csv(url)

# 2. Create a scatterplot of Year (x) and Value (y) [Slide 9]
plot(x = d$Year, y = d$Value, 
     main = "US Unemployment Rate (1948-2010)",
     xlab = "Year", ylab = "Rate")

# 3. Create a linear model for Value (y) and Year (x) [Slide 9]
# Note: Syntax is lm(y ~ x)
m_unemp <- lm(Value ~ Year, data = d)

# 4. Overlay a regression line [Slide 9]
abline(m_unemp, col = "red", lwd=2)

# 5. Check model performance 
# Note how low the R-squared is (~0.08). Time and unemployment are 
# only vaguely related linearly.
print(summary(m_unemp))

# This is a very low $R^2$. It means that your linear model (the straight line) 
# explains only ~8.2% of the variance in the data.

# The p-value tells you "Variable X affects Variable Y" (Time affects Unemployment). 
# The R-squared tells you "A straight line describes this effect poorly."


# ==============================================================================
# PART 3: Making Predictions & Coding Challenge 2 [slide 13]
# Concepts: Using the fitted model to predict Y for new X values.
# ==============================================================================
print("--- Running Coding Challenge 2 ---")

# Using predict()
# We can predict values for years that don't exist in our data (Extrapolation).

# 1. Plot data with wider x-axis limits (1948 to 2025) 
plot(x = d$Year, y = d$Value, 
     xlim = c(1948, 2025), 
     main = "Unemployment Prediction (Linear Extrapolation)",
     xlab = "Year", ylab = "Rate")

# 2. Overlay the linear regression fit
abline(m_unemp, col = "red", lwd = 1)

# 3. Generate predictions for 1990:2025
# We must create a new data frame with the *exact same* column names as the model input.
pred_data <- data.frame(Year = 1990:2025)
pred_data
pred_data$Value <- predict(m_unemp, newdata = pred_data)

# 4. Overlay predictions as blue points 
points(pred_data$Year, pred_data$Value, col = "blue", pch = 16, cex = 0.8)

#Good or bad?


# ==============================================================================
# PART 4: Nonparametric Regression (LOESS)
# Concepts: Locally Weighted Scatterplot Smoothing.
# Good when data is "wiggly" and has no simple mathematical form.
# ==============================================================================

# Fitting a LOESS model
# We use loess() instead of lm().
# Key Parameters:
#   span: How much data is used for local smoothing (0 to 1). Higher = smoother.
#   degree: Polynomial order (1 = linear, 2 = quadratic).

# Let's fit a LOESS model to the unemployment data
# We use span = 0.5 (50% of data used for local fit) and degree = 2 (Quadratic)
# span value
m_loess <- loess(Value ~ Year, data = d, span = 0.25, degree = 2)

# Make predictions for the existing years to plot the curve
# Note: unlike abline(), we must generate points and connect them with lines()
d$y_pred_loess <- predict(m_loess)
d$y_pred_loess

# Plotting the LOESS result 
plot(x = d$Year, y = d$Value, col="light grey", 
     main = "LOESS Smoothing (Span=0.5)",
     xlab="Year", ylab="Unemployment (%)")

lines(d$Year, d$y_pred_loess, col="red", lty=3, lwd=3)


# ==============================================================================
# PART 5: Coding Challenge 3 (Comparing Models on MPG Data) - [slides 34]
# ==============================================================================
print("--- Running Coding Challenge 3 ---")

# 1. Create scatter plot with filled points 
plot(x = mpg$displ, y = mpg$hwy, 
     col = "gray40", pch = 16,
     xlab = "Displacement", ylab = "Highway MPG",
     main = "Model Comparison: Linear vs LOESS")

# 2. Create LOESS model (span 0.35, degree 2) 
# Span 0.35 is quite "local" (sensitive to fluctuations)
m_loess_mpg <- loess(hwy ~ displ, data = mpg, span = 0.35, degree = 2)

# 3. Predict highway mileages for range 1.6 to 7.0 
x_pred_range <- seq(1.6, 7.0, by = 0.1)
y_pred_loess <- predict(m_loess_mpg, newdata = data.frame(displ = x_pred_range))

# 4. Overlay predicted LOESS line (Blue) 
lines(x_pred_range, y_pred_loess, col = "blue2", lwd = 2)

# 5. Overlay simple linear regression (Red) 
# Notice how the red line misses the curve at the extremes and the middle.
abline(lm(hwy ~ displ, data = mpg), col = "firebrick", lwd = 2)


# ==============================================================================
# PART 6: Adding Confidence Intervals (95% CI)
# Concepts: Visualizing uncertainty. Where might the "true" mean lie?
# ==============================================================================
print("--- Visualizing Confidence Intervals ---")

# Confidence Interval (CI) is a way to express how much uncertainty there is in your data.
# we usually only measure a small sample (e.g., 20 people), 
# but we want to know the truth about the entire population 
# (e.g., all of Canada). The Confidence Interval tells us the range where the true population value likely falls .

# [Slide 40] Re-load data to be clean
d <- read_csv("http://datasets.flowingdata.com/unemployment-rate-1948-2010.csv")

# Plot setup
plot(x = d$Year, y = d$Value, col="gray40", 
     xlab = "Year", ylab="Unemployment rate (%)",
     main = "LOESS with 95% Confidence Intervals")

# Create Local Regression Model (degree = 1 for locally linear fits)
mod <- loess(Value ~ Year, data = d, span = 0.5, degree = 1)

# [Slide 40] Make predictions WITH Standard Error (se = TRUE)
pred <- predict(mod, se = TRUE)
pred$fit
# Overlay the main fit line
lines(d$Year, pred$fit, col="blue2", lwd = 3)

# [Slide 39-40] Calculate and Draw Confidence Intervals
# Formula: Fit +/- (t-distribution_value * standard_error)
# qt(0.975, df) approximates 1.96 for large samples (95% CI)

# Upper Bound
lines(d$Year, 
      pred$fit + qt(0.975, pred$df) * pred$se.fit, 
      lty = 2, col = "blue") # Dashed line for CI

# Lower Bound
lines(d$Year,
      pred$fit - qt(0.975, pred$df) * pred$se.fit,
      lty = 2, col = "blue")

# [Slide 41] Caveat:
# These intervals show us where the true mean is likely to fall 95% of the time.

