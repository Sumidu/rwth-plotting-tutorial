### Inferenzstatistik

# Libraries installieren

# source("install_libraries.R")
library(tidyverse)
library(ggthemes)
library(ggplot2)
library(plotrix)
library(jmv)

rwthcolor <- hcictools::rwth.colorpalette()



data_robot <- readRDS("data/robo_pflege.rds")

t.test( filter(data_robot, gender == "weiblich")$kut,
        filter(data_robot, gender == "männlich")$kut)

cor.test(data_robot$age, data_robot$robo_toilet)

jmv::corMatrix(data_robot, vars = c("robo_bed", "robo_toilett", age))

        