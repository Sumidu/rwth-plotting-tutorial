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
    x = "height in cm",
    y = "gender") +
  theme_minimal()
ggplot(data = starwars) +
  aes(x = gender, y = height) +
  geom_boxplot(fill = "#ffffff") +
  labs(title = "Abhängigkeit Größe von Geschlecht",
    x = "height in cm",
    y = "gender") +
  theme_minimal()

