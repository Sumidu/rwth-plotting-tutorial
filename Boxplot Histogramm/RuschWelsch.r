# Bibliotheken laden

library(tidyverse)
library(psych)

data(msleep)
msleep

View(msleep)

ggplot(data = msleep) +
  aes(x = vore, y = sleep_total) +
  geom_boxplot(fill = "#6baed6") +
  labs(title = "Wie lang dauert der Winterschlaf?",
       x = "Tierart",
       y = "Menge an Schlaf",
       subtitle = "Menge an Schlaf für jede Tierart") +
  theme_minimal()