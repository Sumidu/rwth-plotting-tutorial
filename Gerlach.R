
library(tidyverse)
library(psych)

data(starwars)
starwars

library(ggplot2)

ggplot(data = starwars) +
  aes(x = gender, weight = mass) +
  geom_bar(fill = '#e5f5e0') +
  labs(title = 'Männliche Wesen aus StarWars sind am schwersten',
    x = 'Geschlecht',
    y = 'Masse',
    subtitle = 'Balkendiagramm Masse nach Geschlecht') +
  theme_minimal()

ggsave("Gerlach_bar.pdf")







