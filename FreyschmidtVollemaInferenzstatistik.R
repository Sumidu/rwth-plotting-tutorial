### Inferenzstatistik Eva Freyschmidt und Anne Vollema


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