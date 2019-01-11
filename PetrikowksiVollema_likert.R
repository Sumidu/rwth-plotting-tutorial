library(tydiverse)
library(likert)

data <- read_rds("data/robo_pflege.rds")

zustimmungsskala <- c("stimme gar nicht zu", "stimme nicht zu",
                      "stimme eher nicht zu", "stimme eher zu",
                      "stimme zu", "stimme völlig zu")

data$robo_bath <- factor(data$robo_bath, labels = zustimmungsskala)
data$human_bath <- factor(data$human_bath, labels = zustimmungsskala)
data$robo_bed <- factor(data$robo_bed, labels = zustimmungsskala)
data$human_bed <- factor(data$human_bed, labels = zustimmungsskala)
data$robo_toilet <- factor(data$robo_toilet, labels = zustimmungsskala)
data$human_toilet <- factor(data$human_toilet, labels = zustimmungsskala)

data %>% select(robo_toilet) %>% as.data.frame() %>% likert()


pl <- data %>%
  select(robo_bath, robo_bed, robo_toilet, human_bath, human_bed, human_toilet) %>%
  as.data.frame() %>%
  likert() %>%
  plot() +
  labs(title="Likert Diagramm Vergleich Mensch und Roboter", y="Prozent", x= "Plegevorgang", fill= "Antwort")



pl

ggsave(plot = pl, filename = "PetrikowskiVollema_likert.pdf", width=7, height = 4)

