### Alexa Otte und Insa Menzel Inferenzstatistik

source("install_libraries.R")
library(tidyverse)
library(tidyverse)
library(ggthemes)
library(ggplot2)
library(plotrix)
library(jmv)

## Farben verfügbar machen:
rwthcolor <- hcictools::rwth.colorpalette()

## Daten Laden
data_robot <- readRDS("Data/robo_pflege.rds")



## Unverbundener T-Test. Hypothese: Männer und Frauen unterscheiden sich im Hinblick auf robo_bed.
t.test( filter(data_robot, gender == "weiblich")$robo_bed, 
        filter(data_robot, gender == "männlich")$robo_bed )



data_robot %>% 
  filter(gender != "keine Angabe") %>% 
  group_by(gender) %>% 
  summarise(mean_robo_bed = mean(robo_bed, na.rm = TRUE)-1, sem_robo_bed = std.error(robo_bed, na.rm = TRUE)) %>% 
  ggplot() +
  aes(x = gender, weight = mean_robo_bed, fill = gender, ymin = mean_robo_bed-sem_robo_bed, ymax = mean_robo_bed+sem_robo_bed) +
  geom_bar(width = 0.5) +
  scale_fill_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  geom_errorbar(width = 0.2) +
  theme_minimal() +
  ylim(0,5) +
  labs(title = "Männer wollen eher von einem Roboter ins Bett gebracht werden als Frauen", 
       subtitle = "Balkendiagramm: robo_bed im Vergleich zwischen Männern und Frauen ", 
       x = "Geschlecht",
       y = "robo_bed [0 - 5]",
       fill = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes.") +
  NULL
# ggsave("OtteMenzelBalkendiagrammTtest.pdf", width = 6, height = 5)
