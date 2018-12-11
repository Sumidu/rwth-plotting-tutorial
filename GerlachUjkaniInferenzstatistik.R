### Inferenzstatistik Gerlach & Ujkani


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

## Zweifaktorielle ANOVA. Hypothese: Geschlecht und Jobart haben einen Einfluss auf DIFFPREF.

data_robot %>%
  filter(gender != "keine Angabe") %>%
  filter(job_type == "Arbeitnehmer/in" | job_type == "Studierend/Schüler/in" ) %>%
  jmv::anova(dep = "diffpref",
             factors = c("job_type", "gender")
  ) -> res

res$main

data_robot %>%
  filter(gender != "keine Angabe") %>%
  filter(job_type == "Arbeitnehmer/in" | job_type == "Studierend/Schüler/in" ) %>%
  group_by(gender, job_type) %>%
  summarise(mean_diffpref = mean(diffpref), sem_diffpref = std.error(diffpref)) %>%
  ggplot() +
  aes(x = job_type, y = mean_diffpref, colour = gender, ymin = mean_diffpref-sem_diffpref, ymax = mean_diffpref+ sem_diffpref) +
  geom_errorbar(width = 0.2, colour = rwthcolor$black) +
  geom_point(size = 3) +
  geom_line(aes(group = gender)) +
  scale_colour_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  theme_grey() +
  labs(title = "Männliche Schüler und Studierende weisen die höchste Schwierigkeitspräferenz auf!",
       subtitle = "Punktdiagramm: Präferenz für schwierige Aufgaben im Vergleich zwischen ArbeitnehmerInnen und Studierenden, gruppiert nach Geschlecht",
       x = "Beruf",
       y = "Schwierigkeitspräferenz [1 - 6]",
       colour = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes") +
  NULL

ggsave(file="GerlachUjkaniPunktdiagramm.pdf", width=11)
