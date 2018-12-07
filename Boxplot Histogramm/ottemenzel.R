#### Alexa und Insa----

library(tidyverse)
library(psych)

data("starwars")
starwars
library(ggplot2)

ggplot(data = starwars) +
  aes(x = gender, y = height) +
  geom_boxplot(fill = "#4292c6") +
  labs(title = "Die männlichen Charaktere sind durchschnittlich größer als die weiblichen Charaktere",
    x = "Geschlecht",
    y = "Größe",
    caption = "Dots are Outliers",
    subtitle = "Boxplot Größe und Geschlecht") +
  theme_minimal()

