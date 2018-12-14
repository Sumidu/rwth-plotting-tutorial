
### NeumüllerWelsch Inferenzstatistik.R 

source("install_libraries.R")

library(devtools)
library(tidyverse)
library(lubridate)
library(psych)
library(esquisse)
library(ggthemes)
library(ggplot2)
library(jmv)
library(plotrix)


devtools::install_github("HCIC/r-tools")

## Farben verfügbar machen:

rwthcolor <- hcictools::rwth.colorpalette()

## Daten Laden

data_robot <- readRDS("data/robo_pflege.rds")

## Unverbundener T-Test. Hypothese: Männer und Frauen unterscheiden sich im Hinblick auf die Nahrungsaufnahme durch einen Roboter.

t.test( filter(data_robot, gender == "weiblich")$robo_food,
        
        filter(data_robot, gender == "männlich")$robo_food )

library(ggplot2)

data_robot %>%
  filter(gender != "keine Angabe") %>%
  group_by(gender) %>%
  summarise(mean_robo_food = mean(robo_food, na.rm= TRUE), sem_robo_food = std.error(robo_food, na.rm= TRUE))%>%
  ggplot() +
  aes(x = gender, y = mean_robo_food, colour = gender, ymin = mean_robo_food - sem_robo_food, ymax = mean_robo_food + sem_robo_food) +
  scale_colour_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  geom_errorbar( width = 0.2, colour = rwthcolor$black) +
  geom_point( size = 3) +
  ylim(1,6) +
  theme_gray() +
  labs(title = "Männer lassen sich eher von einem Roboter füttern, als Frauen.", 
       subtitle = "Punktdiagramm: Robo_food im Vergleich zwischen Männern und Frauen ", 
       x = "Geschlecht",
       y = "Robo_food [1 - 6]",
       fill = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes.") + 
  NULL
ggsave("WelschNeumuellerPunktdiagrammTtest.pdf", width = 6, height = 5)


## Zweifaktorielle ANOVA. Hypothese: Geschlecht und Erwerbstätigenstatus haben einen Einfluss auf die eigene Beurteilung hinsichtlich der Lösung schwieriger Probleme.

data_robot %>% 
  filter(gender != "keine Angabe") %>% 
  filter(job_type == "Arbeitnehmer/in" | job_type == "Studierend/Schüler/in") %>% 
  jmv::anova(dep = "diffpref",
             factors = c("job_type", "gender")
    ) -> res
res$main
  
data_robot %>%
  filter(gender != "keine Angabe") %>%
  filter(job_type == "Arbeitnehmer/in" | job_type == "Studierend/Schüler/in") %>% 
  group_by(gender, job_type) %>%
  summarise(mean_diffpref = mean(diffpref), sem_diffpref = std.error(diffpref))%>%
  ggplot() +
  aes(x = job_type, y = mean_diffpref, colour = gender, ymin = mean_diffpref - sem_diffpref, ymax = mean_diffpref + diffpref) +
  scale_colour_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  geom_errorbar( width = 0.2, colour = rwthcolor$black) +
  geom_point( size = 3) +
  geom_line(aes(group = gender)) +
  ylim(3,6) +
  theme_gray() +
  labs(title = "Geschlecht und Erwerbstätigenstatus haben einen Einfluss auf die eigene Beurteilung hinsichtlich der Lösung schwieriger Probleme.", 
       subtitle = "Punktdiagramm: Diffpref im Vergleich zwischen Männern und Frauen und im Hinblick auf den Erwerbstätigenstatus ", 
       x = "Erwerbstätigenstatus",
       y = "diffpref [1 - 6]",
       coulour = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes.") + 
  NULL

ggsave("NeumuellerWelschPunktdiagrammANOVA.pdf", width = 6, height = 5)


