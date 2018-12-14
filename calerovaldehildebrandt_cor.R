data_robot <- hcictools::robot_care

data_robot


cor.test(data_robot$robo_bed, data_robot$robo_toilett, method = "kendall")

ggplot(data_robot) + aes(x=robo_bed, y=robo_toilett) + geom_jitter()


jmv::corrMatrix(data_robot, vars = c("robo_bed", "robo_toilett", "age"), kendall = TRUE)
