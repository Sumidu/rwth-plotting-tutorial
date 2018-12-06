# Bibliotheken laden

library(tidyverse)
library(psych)

# Liste alle Verfügbaren Datensätze
data()

# Hilfe zu einem Datensatz (hier Titanic aus datasets)
?starwars

data(starwars)
starwars

data(Titanic)
Titanic1

data(garcia)
Titanic

describe(Titanic)

# starwars, faithful, diamonds, mpg, msleep, Garcia, Tal_Or, affect, epi, galton, msq, iqitems, sai, spi
data(gss_cat)
gss_cat


# Other datasets from other packages: http://www.public.iastate.edu/~hofmann/data_in_r_sortable.html