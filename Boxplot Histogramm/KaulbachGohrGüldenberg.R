
library(tidyverse)
library(psych)
library(esquisse)
libary(ggplot2)
library(ggthemes)

# Verwendeter Datensatz

ggplot(data = ChickWeight) +
  aes(x = Diet, y = weight) +
  geom_boxplot(fill = '#0c4c8a') +
  theme_minimal()


x= "weight"
y= "Diet"
