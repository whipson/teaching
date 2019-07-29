library(MASS)
library(tidyverse)
library(kableExtra)
library(plotly)

set.seed(3)

x <- round(rnorm(20, 72, 10))
y <- round(rnorm(20, 5, 2) * .57 + scale(x) * .43, 2)
z <- round(rnorm(20, 0, .75)) * .32 + scale(x) * .14 + scale(y) * .54

data <- data.frame(cbind(x, y, z))

colnames(data) <- c("grades", "selfesteem", "happiness")

data %>%
  ggplot(aes(x = grades, y = selfesteem)) +
  geom_point(size = 5, color = "blue") +
  geom_smooth(method = 'lm', se = FALSE, size = 2) +
  labs(x = "Grades",
       y = "Self-esteem") +
  theme_minimal(base_size = 24)

data %>%
  slice(1:10) %>%
  kable() %>%
  kable_styling("striped", full_width = F) %>%
  column_spec(1:2, bold = T) %>%
  row_spec(1:10, bold = T, color = "white", background = "#D7261E")

p <- plot_ly(data, x = ~grades, y = ~selfesteem, z = ~happiness, color = ~happiness) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Grades'),
                      yaxis = list(title = 'Self-esteem'),
                      zaxis = list(title = 'Happiness')))

p
