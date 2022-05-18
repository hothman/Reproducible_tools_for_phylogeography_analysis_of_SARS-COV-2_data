#####
# stratified sampling
###########


library(tidyverse)
library(readr)
library(dplyr)
library(sampling)


###data <- read_csv2("/home/zied//Documents/hackathon_2020/mistemp-2/All_africa_21avril/clades/meta/africa_V_metadata.csv")


data <- read_tsv("/home/zied/Bureau/hcov_global_2021-10-25_23-08/hcov_global.tsv")

head(data)

#data_country <- data %>%
#  group_by(country) %>%
#  summarize(n = n())

#View(data_country)

data_region  <- data %>%
  group_by(region) %>%
  summarize(n = n())

View(data_region)


#sorted <- data[order(data$country),]
#View(sorted$country)

sorted <- data[order(data$region),]
View(sorted$region)



## donne le nombre de seqences par country
data_country$n
## choisir inf ou egal a 10 par country
#Sz = c(2,1,8,1,3)
Sz = c(0,100,100,100,100,100)
#s = strata(sorted, stratanames=c("country"), Sz , method="srswor",description=TRUE)
s = strata(sorted, stratanames=c("region"), Sz , method="srswor",description=TRUE)


d <- getdata(sorted,s)

View(d)


write_csv(d, file = "/home/zied//Documents/hackathon_2020/mistemp-2/All_africa_21avril/clades/meta/africa_subsample/strat_V_afric.csv")

