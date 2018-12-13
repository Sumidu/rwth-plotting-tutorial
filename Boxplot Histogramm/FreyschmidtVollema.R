### Einaldung Anne

# Anne Packages laden
install.packages("tidyverse")

install.packages("lubridate")

install.packages("psych")

install.packages("esquisse")

install.packages("ggthemes")

# Bibliothek laden
library(tidyverse)
library(psych)

# Liste der verfügbaren Datensätze
data()


# Auswahl Datensatz
data(starwars)
starwars
library(ggplot2)

#Boxplot Erscheinungsbild Universumsbewohner (Vergleich Größe und Geschlecht)

ggplot(data = starwars) +
  aes(x = eye_color, y = skin_color) +
  geom_tile() +
  labs(title = "Erscheinungsbild Universumsbewohner",
    x = "Augenfarbe",
    y = "Hautfarbe",
    subtitle = "Vergleich Hautfarbe mit Augenfarbe") +
  theme_minimal()
ggplot(data = starwars) +
  aes(x = gender, y = height) +
  geom_boxplot(fill = "#0c4c8a") +
  labs(title = "Erscheinungsbild Universumsbewohner",
    x = "Geschlecht",
    y = "Größe",
    subtitle = "Vergleich Geschlecht und Größe") +
  theme_minimal() 
