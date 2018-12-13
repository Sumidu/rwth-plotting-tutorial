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


####Inferenzstatistik

source("install_libraries.R")

source("corporateIdentity.R")

rwthcolor <- hcictools:: rwth.colorpalette()

library (tidyverse)
library(ggthemes)
library(plotrix)
library(jmv)

data_robot <- readRDS("data/robo_pfleger.rds")

t.test (filter(data_robot, gender == "weiblich")$kut,
        filter(data_robot, gender == "männlich")$kut)

library(ggplot2)

data_robot %>%
  filter(gender!="keine Angabe") %>%
  group_by(gender)%>%
  summarize (mean_kut=mean(kut)-1, sem_kut = std.error(kut) ) %>%
ggplot()+
  aes(x = gender, weight= mean_kut, fill=gender)+
  scale_fill_manual (values = c(rwthcolor$blue, rwthcolor$red))+
  geom_bar(width=0.5)+
  ylim(0,5)+
  geom_errorbar (width = 0.2, aes(ymin = mean_kut - sem_kut,ymax = mean_kut + sem_kut))+
  theme_minimal()+
  labs(
    title = "Männer haben einen höheren KUT als Frauen.",
    subtitle= "Balkendiagramm: KUT im Mittelwertsvergleich zwischen.",
    caption= "Fehlerbalken zeigen Standardfehler des Mittelwertes.",
    y = "KUT [0-5]",
    x = "Geschlecht",
    fill= "Geschlecht"
  )+
    NULL

  