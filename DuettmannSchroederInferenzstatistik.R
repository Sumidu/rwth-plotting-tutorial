#### Inferenzstatistik Leonie und Laura


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


# unverbundener T-Test. Hypothese: Männer und Frauen unterscheiden sich bei robo_bath.

t.test (filter (data_robot, gender == "weiblich")$robo_bath,
        filter(data_robot, gender =="männlich")$robo_bath)

data_robot %>% 
  filter(gender != "keine Angabe") %>% 
  group_by(gender) %>% 
  summarise(mean_robo_bath = mean(robo_bath)-1, sem_robo_bath = std.error(robo_bath)) %>% 
  ggplot() +
  aes(x = gender, weight = mean_robo_bath, fill = gender, ymin = mean_robo_bath - sem_robo_bath, ymax = mean_robo_bath + sem_robo_bath) +
  geom_bar(width = 0.5) +
  scale_fill_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  geom_errorbar(width = 0.2) +
  theme_minimal() +
  ylim(0,5) +
  labs(title = "Männer lassen sich eher von einem Roboter baden als Frauen", 
       subtitle = "Balkendiagramm: robo_bath im Vergleich zwischen Männern und Frauen ", 
       x = "Geschlecht",
       y = "robo_bath [0 - 5]",
       fill = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes.") +
  NULL




