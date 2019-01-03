# Isabelle und Julia

data("women")
women

psych::describe(women)
library(ggplot2)

library(ggplot2)

ggplot(data = women) +
  aes(x = height, y = weight) +
  geom_point(color = '#0c4c8a') +
  labs(x = 'height',
    y = 'weight',
    subtitle = 'Verlauf der Größe nach Gewicht ') +
  theme_minimal()

library(ggplot2)

ggplot(data = women) +
  aes(x = height, y = height) +
  geom_boxplot(fill = '#ffffff') +
  labs(title = 'Durschnittliche Größe der Frauen in Amerika',
    x = 'Größe',
    y = 'Größe in inches',
    subtitle = 'Boxplot durchschnittliche Größe der Frauen in Amerika') +
  theme_minimal()

ggsave("durchschnittliche_Größe_der_Frauen_in_Amerika.pdf")
