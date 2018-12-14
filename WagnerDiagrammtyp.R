#### Bibliotheken laden

#source("install_libraries.R")

library(tidyverse)
library(ggthemes)
library(ggplot2)
library (plotrix)
library(jmv)

## Farben verfügbar machen

rwthcolor <- hcictools:: rwth.colorpalette()

## Daten laden
data_robot <- readRDS("data/robo_pflege.rds")

## Unverbundener T-Test, Hypothese: Männer und Frauen unterscheiden sich im KUT.
t.test (filter(data_robot, gender == "weiblich")$kut,
        filter(data_robot, gender == "männlich")$kut)

# Balkendiagramm (0-5)
data_robot %>%
  filter(gender!="keine Angabe") %>%
  group_by(gender) %>%
  summarise (mean_kut=mean(kut)-1, sem_kut = std.error(kut) ) %>%
ggplot()+
  aes(x = gender, weight= mean_kut, fill=gender, ymin= mean_kut - sem_kut, ymax=mean_kut + sem_kut)+
  scale_fill_manual (values = c(rwthcolor$blue, rwthcolor$red))+
  geom_bar(width=0.5)+
  geom_errorbar (width = 0.2) +
  ylim(0,5)+
  theme_gray()+
  labs(title = "Männer glauben eher daran, Technik kontrollieren zu können.",
    subtitle= "Balkendiagramm: KUT im Vergleich zwischen Männern und Frauen.",
    caption= "Fehlerbalken zeigen Standardfehler des Mittelwertes.",
    y = "KUT [0-5]",
    x = "Geschlecht",
    fill= "Geschlecht")+
  NULL


# Punktdiagramm (1-6)
data_robot %>%
  filter(gender!="keine Angabe") %>%
  group_by(gender) %>%
  summarise (mean_kut=mean(kut), sem_kut = std.error(kut) ) %>%
ggplot()+
  aes(x = gender, y = mean_kut, colour=gender, ymin= mean_kut - sem_kut, ymax=mean_kut + sem_kut)+
  scale_colour_manual (values = c(rwthcolor$blue, rwthcolor$red))+
  geom_errorbar (width = 0.2, colour=rwthcolor$black) +
  geom_point(size=3)+
  ylim(3.5,5)+
  theme_gray()+
  labs(title = "Männer glauben eher daran, Technik kontrollieren zu können.",
       subtitle= "Punktdiagramm: KUT im Vergleich zwischen Männern und Frauen.",
       caption= "Fehlerbalken zeigen Standardfehler des Mittelwertes.Y-Achse wurde aus Gründen der Übersichtlichkeit verschoben.",
       y = "KUT [1-6]",
       x = "Geschlecht",
       colour= "Geschlecht")+
  NULL

##Zweifaktorielle ANOVA. Hypothese: Geschlecht und Erwerbstätigenstatus haben einen Einfluss auf KUT.
data_robot %>%
  filter(gender!="keine Angabe") %>%
  filter (job_type == "Arbeitnehmer/in" | job_type == "Studierend/Schüler/in") %>%
  jmv::anova(dep="kut",
             factors= c("job_type","gender")
  )-> res

res$main


data_robot %>%
  filter(gender!="keine Angabe") %>%
  filter (job_type == "Arbeitnehmer/in" | job_type == "Studierend/Schüler/in") %>%
  group_by(gender, job_type) %>%
  summarise (mean_kut=mean(kut), sem_kut = std.error(kut) ) %>%
ggplot()+
  aes(x = job_type, y = mean_kut, colour=gender, ymin= mean_kut - sem_kut, ymax=mean_kut + sem_kut)+
  scale_colour_manual (values = c(rwthcolor$blue, rwthcolor$red))+
  geom_errorbar (width = 0.2, colour=rwthcolor$black) +
  geom_point(size=3)+
  geom_line(aes(group = gender)) +
  ylim(3,6)+
  theme_gray()+
  labs(title = "Männer glauben eher daran, Technik kontrollieren zu können.Studierende auch.",
       subtitle= "Punktdiagramm: KUT im Vergleich zwischen Arbeitnehmerinnen und Studierenden, gruppiert nach Geschlecht.",
       caption= "Fehlerbalken zeigen Standardfehler des Mittelwertes.Y-Achse wurde aus Gründen der Übersichtlichkeit verschoben",
       y = "KUT [1-6]",
       x = "Erwerbstätigenstatus",
       colour= "Geschlecht")+
  NULL
