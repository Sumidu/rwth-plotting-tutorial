## Übung Boxplot und Histogram

## Bibliotheken laden

library(tidyverse)
library(psych)
library(ggplot2)

data(mpg)
mpg

ggplot(data = mpg) +
  aes(x = class, y = cty) +
  geom_boxplot(fill = "#0c4c8a") +
  labs(title = "Unterschiedlicher Benzinverbrauch von Fahrzeugklassen",
    x = "Fahrzeugklasse",
    y = "Bezinverbrauch im Stadtverkehr [miles/gallon]",
    caption = "Datenpunkte sind Ausreißer",
    subtitle = "Boxplot des Benzinverbrauchs in miles per gallon unterschiedlicher Fahrzeugklassen") +
  theme_minimal() -> benzinverbrauch 

#breite = 15
#'hoehe = breite*0.5

ggsave(plot = benzinverbrauch, "ArndtBlajic_Boxplot.pdf", width = 10, height = 5)

