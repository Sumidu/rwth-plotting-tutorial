#### WandersKaulbachInferenzstatistik.R

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
data_robot <- readRDS("data/robo_pflege.rds")

## Unverbundener T-Test: Männer und Frauen unterscheiden sich hinsichtlich robo_med
t.test( filter(data_robot, gender == "weiblich")$robo_med,
        filter(data_robot, gender == "männlich")$robo_med)

#View(data_robot)

# Visualisierung 

data_robot %>% 
  filter(gender != "keine Angabe") %>% 
  group_by(gender) %>% 
  summarise(mean_robo_med = mean(robo_med, na.rm = TRUE)-1, sem_robo_med = std.error(robo_med, na.rm = TRUE)) %>% 
  ggplot() +
  aes(x = gender, weight = mean_robo_med, fill = gender, ymin = mean_robo_med - sem_robo_med, ymax = mean_robo_med + sem_robo_med) +
  scale_fill_manual(values = c(rwthcolor$blue, rwthcolor$red)) +
  geom_bar(width = 0.5) +
  geom_errorbar(width = 0.2) +
  ylim(0,5) +
  theme_gray() +
  labs(title = "Männer lassen sich eher von einem Roboter Medikamente geben als Frauen", 
       subtitle = "Balkendiagramm: robo_med im Vergleich zwischen Männern und Frauen ", 
       x = "Geschlecht",
       y = "robo_med [1 - 6]",
       fill = "Geschlecht",
       caption = "Fehlerbalken zeigen Standardfehler des Mittelwertes.") +
  NULL
ggsave("WandersKaulbachBalkendiagramTtest.pdf", width = 6, height = 5)



#### 14.12.18 Präsenzübung Korrelation

#data_robot <- hcictools::robot_care

#data_robot

#cor.test(data_robot$age, data_robot$robo_toilett)

# Pearson Korrelation: Kor.Effizient beträgt: r =-0.03 (taucht unter cor auf); p-Wert = 0.563
# Interpretation: p-Wert ist über 0.5 -> kein signifikanter Zusammenhang zwischen Alter und robo_toilett

#gglpot(data_robot) + aes(x=age, y=robo_toilett) + geom_point()
# Schwierigkeit ordinaler Werte > Diagramm verrrät nicht viel > Lösung: Kendall tau rechnen!

# Also: cor.test(data_robot$age, data_robot$robo_toilett, method = "kendall")

#gglpot(data_robot) + aes(x=age, y=robo_toilett) + geom_jitter()

# Interpretation: p-value <2.2e-16 = 2*2*10 hoch -16 = o,ooooooooooooooooo2.2 
# > Es gibt einen siginifkaten Zusammenhang 
# Es gibt eine Korrelation zwischen der Präferenz robo_bed und robo_toilett (kendall tau und p-Wert)
# Es gibt Grenzen, wie Korreltaionen zu interpretieren sind. 
# Klausur !!!: Digramm > Wie sieht Korrelationskoeffizient aus ? Gespühr für Variablen-Zusammenhang

## Wie rechnen Wir Korrelation?
#jmv::corrMatrix(data_robot, vars = c("robo_bed", "robo_toilett", "age")), kendall = TRUE
# mit dem Befehl üben_ Varaiblen austauschen und Tabelle bestimmen, kendall auf true setzen!

# 1 Zeile Korrelation r, 2 Zeile p Wert > schwacher Zusammenhang Alter und Bett, aber nicht siginifkant 
# > P-Wert ist größer als 0.5 ; p-Wert prüft Fehlerwahrscheinlchkeit, wenn wir HO annehmen; 
# Nullhyptohese: es gibt keinen Zusammenhang; 
# HO bei Korrelationsanalysen = R ist gleich 0
# HO (Nullhyptothese) = keinen Efffekt, keinen Unterschied, keinen Zusammenhang, etc,
# hier in der CorrMatrix jetzt Zusammenhang von 0.566 











