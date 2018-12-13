#### WandersKaulbachInferenzstatistik.R


## Farben verfügbar machen:
rwthcolor <- hcictools::rwth.colorpalette()

## Daten Laden
data_robot <- readRDS("data/robo_pflege.rds")

## T-Test
t.test( filter(data_robot, gender == "weiblich")$kut,
        filter(data_robot, gender == "männlich")$kut)
