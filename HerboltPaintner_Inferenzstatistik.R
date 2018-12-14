###Inferenzstatistik Herbolt, Paintner

#source("install_libraries.R")

source("corporateIdentity.R")

# source("install_libraries.R")
library(tidyverse)
library(tidyverse)
library(ggthemes)
library(ggplot2)
library(plotrix)
library(jmv)

rwthcolor <- hcictools::rwth.colorpalette()

data_robot <- readRDS("data/robo_pflege.rds")

## Unverbundener T-Test. Hypothese: Männer und Frauen unterscheiden sich im Technikverständnis.
t.test( filter(data_robot, gender == "weiblich")$tv, 
        filter(data_robot, gender == "männlich")$tv )

data_robot %>%
  filter(gender != "keine Angabe") %>%
  group_by(gender) %>%
  summarise(mean_tv = mean(tv) -1, sem_tv = std.error(tv)) %>%
ggplot() +
  aes(x = gender, weight = mean_tv, fill = gender, ymin = mean_tv - sem_tv, ymax = mean_tv + sem_tv) +
  scale_fill_manual(values = c(rwthcolor$petrol, rwthcolor$magenta)) +
  geom_bar( width = 0.5) +
  geom_errorbar( width = 0.2) +
  ylim(0,4) +
  theme_gray() +
  labs(title = "Männer glauben, ein höheres Technikverständnis als Frauen zu haben.", 
     subtitle = "Balkendiagramm: TV im Vergleich zwischen Männern und Frauen ", 
     x = "Geschlecht",
     y = "TV [0 - 4]",
     fill = "Geschlecht",
     caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes.") +
  NULL




## Zweifaktorielle ANOVA. Hypothese: Geschlecht und Erwerbstätigenstatus haben einen Einfluss auf das Technikverständnis.
data_robot %>% 
  filter(gender != "keine Angabe") %>%
  filter(job_type == "Arbeitnehmer/in" | job_type == "Studierend/Schüler/in" ) %>% 
  jmv::anova(dep = "tv", 
             factors = c("job_type", "gender") 
  ) -> res

res$main 

data_robot %>% 
  filter(gender != "keine Angabe") %>%
  filter(job_type == "Arbeitnehmer/in" | job_type == "Rentner/in" ) %>% 
  group_by(gender, job_type) %>% 
  summarise(mean_tv = mean(tv), sem_tv = std.error(tv)) %>% 
  ggplot() +
  aes(x = job_type, y = mean_tv, colour = gender, ymin = mean_tv-sem_tv, ymax = mean_tv+sem_tv) +
  geom_errorbar(width = 0.2, colour = rwthcolor$black) +
  geom_point(size = 3) +
  geom_line(aes(group = gender)) +
  scale_colour_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  theme_grey() +
  labs(title = "Berufstätige Männer glauben eher, Technik zu verstehen als männliche Renter.", 
       subtitle = "Punktdiagramm: TV im Vergleich zwischen RentnerInnen und ArbeitnehmerInnen, gruppiert nach Geschlecht", 
       x = "Erwerbstätigkeit",
       y = "TV [1 - 6]",
       colour = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes an.") +
  NULL

#ggsave("HerboltPaintnerPunktdiagrammANOVA.pdf", width = 6, height = 5)
