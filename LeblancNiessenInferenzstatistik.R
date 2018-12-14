### Inferenzstatistik Leblanc und Niessen


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


## Unverbundener T-Test. Hypothese: Jüngere Nutzer haben einen höheren KUT als ältere Nutzer.
t.test( filter(dfMediansplit, age_group == "low") $kut, 
        filter(dfMediansplit, age_group == "high") $kut )


dfMediansplit %>% 
    group_by(age_group) %>% 
  summarise(mean_kut = mean(kut)-1, sem_kut = std.error(kut)) %>% 
  ggplot() +
  aes(x = age_group, weight = mean_kut, fill = age_group, ymin = mean_kut-sem_kut, ymax = mean_kut+sem_kut) +
  geom_bar(width = 0.5) +
  scale_fill_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  geom_errorbar(width = 0.2) +
  theme_minimal() +
  ylim(0,5) +
  labs(title = "Jüngere Menschen haben eine höhere Technikakzeptanz", 
       subtitle = "Balkendiagramm: Technikakzeptanz im Vergleich zwischen jüngeren und älteren Nutzern",
       y = "Technikakzeptanz [0 - 5]",
       fill = "Alter",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes.") +
  NULL
ggsave("LeblancNiessenBalkendiagramm.pdf", width = 6, height = 5)

dfMediansplit %>% 
   group_by(age_group) %>% 
  summarise(mean_kut = mean(kut), sem_kut = std.error(kut)) %>% 
  ggplot() +
  aes(x = age_group, y = mean_kut, colour = age_group, ymin = mean_kut-sem_kut, ymax = mean_kut+sem_kut) +
  geom_errorbar(width = 0.2, colour = rwthcolor$black) +
  geom_point(size = 3) +
  scale_colour_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  theme_minimal() +
  ylim(3.5,5) +
  labs(title = "Jüngere Menschen haben eine höhere Technikakzeptanz", 
       subtitle = "Punktdiagramm: Technikakzeptanz im Vergleich zwischen jüngeren und älteren Nutzern", 
       x = "Alter",
       y = "Technikakzeptanz [1 - 6]",
       colour = "Alter",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes. Y-Achse ist aus Gründen der Lesbarkeit verschoben.") +
  NULL
#ggsave("LeblancNiessenPunktdiagrammTtest.pdf", width = 6, height = 5)



