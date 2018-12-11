source("install_libraries.R")

source("corporateIdentity.R")

library(tidyverse)
library(ggthemes)
library(plitrix)
library(jmv)

rwthcolor <- hcictools::rwth.colorpalette()

data_robot <- readRDS("data/robo_pflege.rds")
