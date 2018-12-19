ggplot(data = ChickWeight) +
  aes(x = Chick, y = weight) +
  geom_boxplot(fill = '#0c4c8a') +
  theme_minimal()
