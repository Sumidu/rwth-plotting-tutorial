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
starwarslibrary(ggplot2)

# Test Boxplot Größe "height"
ggplot(data = starwars) +
  aes(x = height, y = height) +
  geom_boxplot(fill = "#ffffff") +
  coord_flip() +
  theme_minimal()

