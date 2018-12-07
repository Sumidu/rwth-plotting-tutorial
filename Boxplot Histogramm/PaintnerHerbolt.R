# Bibliotheken laden

library(tidyverse)
library(psych)
library(esquisse)
library(ggplot2)
library(ggthemes)

# Verwendeter Datensatz + einmal mit Namen aufrufen
data(ToothGrowth)
?ToothGrowth

#Boxplot erstellen
ggplot(data = ToothGrowth) +
  aes(x = supp, y = len) +
  geom_boxplot(fill = '#31688e') +
  labs(title = 'The length of the odontoblasts is determined by the supply 
       of vitamin OJ greater than under intake of vitamin VC.',
    x = 'Vitamin',
    y = 'Lenght',
    caption = 'Dots are outliers',
    subtitle = 'Boxplot of lenght') +
  theme_linedraw() 


 

