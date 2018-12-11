### Einaldung Anne

<<<<<<< HEAD
=======
# Anne Packages laden
install.packages("tidyverse")

install.packages("lubridate")

install.packages("psych")

install.packages("esquisse")

install.packages("ggthemes")

>>>>>>> c5422b4a198ffac65a6142c9cf77d5b5416f0dd0
# Bibliothek laden
library(tidyverse)
library(psych)

# Liste der verfügbaren Datensätze
data()

<<<<<<< HEAD
# Auswahl Datensatz
data(starwars)
starwars
=======

# Auswahl Datensatz
data(starwars)
starwars
library(ggplot2)

# Test Boxplot Größe "height"
ggplot(data = starwars) +
  aes(x = height, y = height) +
  geom_boxplot(fill = "#ffffff") +
  coord_flip() +
  theme_minimal()

>>>>>>> c5422b4a198ffac65a6142c9cf77d5b5416f0dd0
