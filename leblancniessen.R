# Bibliotheken laden

library(tidyverse)
library(psych)

# Liste alle Verfügbaren Datensätze
data()


data(starwars)
starwars
library(ggplot2)

ggplot(data = starwars) +
  aes(x = gender, y = height) +
  geom_boxplot(fill = "#ffffff") +
  labs(title = "Abhängigkeit Größe von Geschlecht",
    x = "gender",
    y = "height in cm") +
  theme_minimal()

ggsave("leblancniessenboxplot.pdf", width = 29.7, height = 21.0, units = "cm")

