# Bibliotheken laden

library(tidyverse)
library(psych)
library(ggplot2)


# Hilfe zu einem Datensatz (hier Titanic aus datasets)
?msleep

data("msleep")
msleeplibrary(ggplot2)

ggplot(data = msleep) +
  aes(x = vore, y = sleep_total) +
  geom_boxplot(fill = "#0c4c8a") +
  labs(title = "Insektenfresser schlafen länger",
    x = "Fresstyp",
    y = "Schlafdauer",
    subtitle = "Schlafverhalten abhängig vom Fresstyp") +
  theme_gray()



