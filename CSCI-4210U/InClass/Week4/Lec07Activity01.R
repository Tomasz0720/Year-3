url <- "http://datasets.flowingdata.com/unemployment-rate-1948-2010.csv"
d <- read_csv(url)

plot(x = d$Year, y = d$Value,
     xlab = "Year",
     ylab = "Unemployment Rate",
     main = "Unemployment Rate 1948-2010"
)


m_unemployment <- lm(Value ~ Year, data = d)

abline(m_unemployment, col="red", lwd=2)

summary(m_unemployment)