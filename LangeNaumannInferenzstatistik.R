#install.packages("plotrix")
#install.packages("jmv")


#library(tidyverse)
library(tidyverse)
library(ggthemes)
library(ggplot2)
library(plotrix)
library(jmv)





data_robot <- readRDS("data/robo_pflege.rds")


t.test(filter(data_robot, gender == "weiblich") $ robo_food,
       filter(data_robot, gender == "männlich") $ robo_food)






#Frauen lassen sich eher von einem Roboter verpflegen als Männer
ggplot(data = robo_pflege) +
  aes(x = gender, weight = robo_food) +
  geom_bar(fill = "#0c4c8a") +
  theme_minimal()

data_robot %>%
  filter(gender != "keine Angabe") %>%
  group_by(gender) %>%
  summarize(mean_robofood = mean(robo_food, na.rm = TRUE)-1, sem_robo = std.error(robo_food, na.rm = TRUE)) %>%
  ggplot() +
  aes(x = gender, weight = mean_robofood, fill = gender, ymin = mean_robofood - sem_robo, ymax =sem_robo + mean_robofood) +
  geom_bar(width = 0.5) +
  geom_errorbar(width = 0.2) +
  scale_fill_manual(values = c("blue", "green")) +
  ylim(0,5) +
  labs(title = "Balkendiagramm zur Unterscheidung von Männern und Frauen",
       x = "Geschlecht",
       y = "robo_food [0-5]",
       subtitle = "Frauen lassen sich eher von einem Roboter füttern als Männer") +
  theme_excel() +
  NULL
ggsave("NaumannBalkendiagramm.pdf")

