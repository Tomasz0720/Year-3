library(tidyverse)
library(scales)
library(RColorBrewer)
library(ggplot2)

poll_data <- read.csv("poll_data.csv")

poll_data


poll_data[,1] <- as.factor(poll_data[,1])
poll_data[,2] <- as.factor(poll_data[,2])

base <- ggplot(poll_data, aes(x = Issue, y = Proportion, fill = Opinion)) +
  xlab = "Voter issue", ylab = "Percentage"
  geom_bar(stat = "identity")

base + scale_fill_brewer(palette = "Blues", direction = -1) 
