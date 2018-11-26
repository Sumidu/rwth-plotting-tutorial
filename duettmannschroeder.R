## Leonie und Laura----

## Leonie und Laura ----


# Bibliotheken laden

library(tidyverse)
library(psych)

data(starwars)
library(ggplot2)

ggplot(data = starwars) +
  aes(x = gender, y = height) +
  geom_boxplot(fill = '#ffffff') +
  labs(title = 'Männer sind durchschnittlich größer als Frauen',
    x = 'Geschlecht',
    y = 'Größe (in cm)',
    caption = 'Punkte zeigen Ausreißer',
    subtitle = 'Boxplot von Geschlecht nach Größe') + coord_flip() +
  theme_gray()

ggsave("duettmannschroeder_boxplott.pdf", width = 7, height = 5)

#library(ggplot2)





