### Inferenzstatistik Susanne Gohr und Anne Vollema


# source("install_libraries.R")
library(tidyverse)
library(tidyverse)
library(ggthemes)
library(ggplot2)
library(plotrix)
library(jmv)

## Farben verfügbar machen:
rwthcolor <- hcictools::rwth.colorpalette()

## Daten Laden
data_robot <- readRDS("data/robo_pflege.rds")

dfMediansplit <- transform(data_robot, age_group=cut(data_robot$age, breaks=c(-Inf, median(data_robot$age), Inf), labels=c("low", "high")))

data_robot %>% 
  filter(gender != "keine Angabe") %>% 
  group_by(gender) %>% 
  summarise(mean_kut = mean(kut)-1, sem_kut = std.error(kut)) %>% 
  ggplot() +
  aes(x = gender, weight = mean_kut, fill = gender, ymin = mean_kut-sem_kut, ymax = mean_kut+sem_kut) +
  geom_bar(width = 0.5) +
  scale_fill_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  geom_errorbar(width = 0.2) +
  theme_minimal() +
  ylim(0,5) +
  labs(title = "Männer und Frauen lassen sich lieber von einem Roboter als von einem Menschen zur Toilette begleiten", 
       subtitle = "Balkendiagramm: KUT im Vergleich zwischen Männern und Frauen ", 
       x = "Geschlecht",
       y = "robot_toilet [0 - 5]",
       fill = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes.") +
  NULL
ggsave("GohrVollemaBalkendiagrammTtest.pdf", width = 6, height = 5)

data_robot %>% 
  filter(gender != "keine Angabe") %>% 
  group_by(gender) %>% 
  summarise(mean_kut = mean(kut), sem_kut = std.error(kut)) %>% 
  ggplot() +
  aes(x = gender, y = mean_kut, colour = gender, ymin = mean_kut-sem_kut, ymax = mean_kut+sem_kut) +
  geom_errorbar(width = 0.2, colour = rwthcolor$black) +
  geom_point(size = 3) +
  scale_colour_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  theme_minimal() +
  ylim(3.5,5) +
  labs(title = "Menschen werden lieber von einem Roboter zur Toilette begleitet", 
       subtitle = "Punktdiagramm: Begleitung zur Toilette durch Mensch oder Roboter", 
       x = "Geschlecht",
       y = "robot_toilet [1 - 6]",
       colour = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes. Y-Achse ist aus Gründen der Lesbarkeit verschoben.") +
  NULL
#ggsave("GohrVollemaPunktdiagrammTtest.pdf", width = 6, height = 5)



## Zweifaktorielle ANOVA. Hypothese: Geschlecht und Erwerbstätigenstatus haben einen Einfluss auf KUT.
data_robot %>% 
  filter(gender != "keine Angabe") %>%
  filter(job_type == "Arbeitnehmer/in" | job_type == "Studierend/Schüler/in" ) %>% 
  jmv::anova(dep = "kut", 
             factors = c("job_type", "gender") 
  ) -> res

res$main 

data_robot %>% 
  filter(gender != "keine Angabe") %>%
  filter(job_type == "Arbeitnehmer/in" | job_type == "Studierend/Schüler/in" ) %>% 
  group_by(gender, job_type) %>% 
  summarise(mean_kut = mean(kut), sem_kut = std.error(kut)) %>% 
  ggplot() +
  aes(x = job_type, y = mean_kut, colour = gender, ymin = mean_kut-sem_kut, ymax = mean_kut+sem_kut) +
  geom_errorbar(width = 0.2, colour = rwthcolor$black) +
  geom_point(size = 3) +
  geom_line(aes(group = gender)) +
  scale_colour_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  theme_grey() +
  labs(title = "Männer glauben eher daran, Technik kontrollieren zu können, Schüler und Studierende auch!", 
       subtitle = "Punktdiagramm: KUT im Vergleich zwischen ArbeitnehmerInnen und Studierenden, gruppiert nach Geschlecht", 
       x = "Beruf",
       y = "KUT [1 - 6]",
       colour = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes") +
  NULL
#ggsave("GohrPunktdiagrammANOVA.pdf", width = 6, height = 5)

