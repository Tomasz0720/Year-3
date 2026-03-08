# Tomasz Puzio - 100904335

# 1
# Using the cars dataset built into R, create a scatter plot in base R of speed (x) and dist (y), giving it a title with labelled axes.
plot(cars$speed, cars$dist,
     xlab = "Speed (mph)",
     ylab = "stopping distance (ft)",
     main = "Effect of car speed on stopping distances"
)

# 2.
# Create a simple linear model. Overlay a line of best fit, using red line of weight 2.
linear_model <- lm(dist ~ speed, data = cars)
abline(linear_model, col="red", lwd=2)

# 3.
# Fit a LOESS regression model and then predict values for the data. 
mod <- loess(dist ~ speed, data = cars, span = 0.5, degree = 1)
cars$y_pred_loess <- predict(mod)

# 4.
# Overlay the predicted LOESS model values, using “blue2” and line weight 3.
lines(cars$speed, cars$y_pred_loess, col="blue2", lty=1, lwd=3)

# 5.
# Overlay predicted 95% confidence intervals, using “blue2”, line weight 1, and dashed line type.
pred <- predict(mod, se = TRUE)

# Upper Bound
lines(cars$speed, 
      pred$fit + qt(0.957, pred$df) * pred$se.fit, 
      lty = 2, col = "blue2", lwd = 1)

# Lower Bound
lines(cars$speed,
      pred$fit - qt(0.957, pred$df) * pred$se.fit,
      lty = 2, col = "blue2", lwd = 1)
