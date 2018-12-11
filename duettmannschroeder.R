## Leonie und Laura ----


# Bibliotheken laden

library(tidyverse)
library(psych)



data(starwars)
starwars


library(ggplot2)

ggplot(data = starwars) +
  aes(x = eye_color, y = height) +
  geom_boxplot(fill = "#ffffff") +
  labs(title = "Männer haben ein größeres Spektrum an Augenfarben",
    x = "Augenfarbe",
    y = "Größe (in cm)",
    subtitle = "Boxplot von Augenfarbe nach Größe") +
  theme_minimal() +
  coord_flip() +
  facet_wrap(vars(gender))




