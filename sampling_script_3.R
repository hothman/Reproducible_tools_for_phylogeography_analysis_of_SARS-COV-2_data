#####
# stratified sampling
###########



#########
# Packages
#############

library(tidyverse)
library(readr)
library(dplyr)
library(sampling)


data <- read_tsv("/home/zied/Documents/hackathon_2020/Mistemps3/hcov_africa_2021-10-27_00-01/hcov_africa.tsv")

head(data)

View(data)


# clade
data_clade  <- data %>%
  group_by(data$Nextstrain_clade) %>%
  summarize(n = n())
View(data_clade)

write_csv(data_clade, file = "/home/zied/Documents/hackathon_2020/Mistemps3/hcov_global_2021-10-25_23-08/data_clade.csv")

#region
data_region  <- data %>%
  group_by(region) %>%
  summarize(n = n())

View(data_region)

# subset only africa
dataf <-subset(data, region=="Africa")
View(dataf)

write_csv(dataf, file = "/home/zied/Documents/hackathon_2020/Mistemps3/hcov_africa_2021-10-27_00-01/hcov_africa1.csv")


####
# Use time series tables

t1 <- read_csv("/home/zied/Documents/hackathon_2020/Mistemps3/afric_timeseries/range_T1_Africa.csv")
View(t1)
t2 <- read_csv("/home/zied/Documents/hackathon_2020/Mistemps3/afric_timeseries/range_T2_Africa.csv")
t3 <- read_csv("/home/zied/Documents/hackathon_2020/Mistemps3/afric_timeseries/range_T3_Africa.csv")
t4 <- read_csv("/home/zied/Documents/hackathon_2020/Mistemps3/afric_timeseries/range_T4_Africa.csv")

# subset by clade
# using subset function
#dat19A <- subset(data,data$Nextstrain_clade == "19A")
#View(dat19a)

#Use OR 

t1subcla <- subset(t1 , Nextstrain_clade == "19A" | Nextstrain_clade == "20A" | Nextstrain_clade == "20B" | Nextstrain_clade == "20C"| Nextstrain_clade == "20H (Beta, V2)"| Nextstrain_clade == "20I (Alpha, V1)" | Nextstrain_clade == "20J (Gamma, V3)" | Nextstrain_clade == "21A (Delta)" | Nextstrain_clade == "21G (Lambda)" | Nextstrain_clade == "21H (Mu)" | Nextstrain_clade == "21I (Delta)" | Nextstrain_clade == "21J (Delta)")
View(t1subcla)
t2subcla <- subset(t2 , Nextstrain_clade == "19A" | Nextstrain_clade == "20A" | Nextstrain_clade == "20B" | Nextstrain_clade == "20C"| Nextstrain_clade == "20H (Beta, V2)"| Nextstrain_clade == "20I (Alpha, V1)" | Nextstrain_clade == "20J (Gamma, V3)" | Nextstrain_clade == "21A (Delta)" | Nextstrain_clade == "21G (Lambda)" | Nextstrain_clade == "21H (Mu)" | Nextstrain_clade == "21I (Delta)" | Nextstrain_clade == "21J (Delta)")
t3subcla <- subset(t3 , Nextstrain_clade == "19A" | Nextstrain_clade == "20A" | Nextstrain_clade == "20B" | Nextstrain_clade == "20C"| Nextstrain_clade == "20H (Beta, V2)"| Nextstrain_clade == "20I (Alpha, V1)" | Nextstrain_clade == "20J (Gamma, V3)" | Nextstrain_clade == "21A (Delta)" | Nextstrain_clade == "21G (Lambda)" | Nextstrain_clade == "21H (Mu)" | Nextstrain_clade == "21I (Delta)" | Nextstrain_clade == "21J (Delta)")
t4subcla <- subset(t4 , Nextstrain_clade == "19A" | Nextstrain_clade == "20A" | Nextstrain_clade == "20B" | Nextstrain_clade == "20C"| Nextstrain_clade == "20H (Beta, V2)"| Nextstrain_clade == "20I (Alpha, V1)" | Nextstrain_clade == "20J (Gamma, V3)" | Nextstrain_clade == "21A (Delta)" | Nextstrain_clade == "21G (Lambda)" | Nextstrain_clade == "21H (Mu)" | Nextstrain_clade == "21I (Delta)" | Nextstrain_clade == "21J (Delta)")

write_csv(t1subcla, "/home/zied/Documents/hackathon_2020/Mistemps3/retableauoutgroups/t1subclafrik.csv")
write_csv(t2subcla, "/home/zied/Documents/hackathon_2020/Mistemps3/retableauoutgroups/t2subclafrik.csv")
write_csv(t3subcla, "/home/zied/Documents/hackathon_2020/Mistemps3/retableauoutgroups/t3subclafrik.csv")
write_csv(t4subcla, "/home/zied/Documents/hackathon_2020/Mistemps3/retableauoutgroups/t4subclafrik.csv")


### tuto       
###newdata <- subset(mydata, age >= 20 | age < 10,
#                select=c(ID, Weight))


#############
## Stratified Sampling 
#################


time4 <- read_csv("/home/zied/Documents/hackathon_2020/Mistemps3/retableauoutgroups/t4subclafrik.csv")
View(time4)

##tim4<-subset(time4, region!="Africa")
##View(tim4)



sorted <- time4[order(time4$strata),]
View(sorted$strata)

View(sorted)

p <-sorted %>% count(strata)
View(p)

## donne le nombre de seqences par country
p$n


## choisir inf ou egal a 10 par country
#Sz = c(2,1,8,1,3)

Sz=c(3,10,3,4,2,10,2,1,2,9,1,4,4,10,2,3,3,1,3,1,1,1,2,10,1,9,1,1,2,10,10,2,1,10,8,1,5,3,4,10,1,5,10,3,10,7,3,6,1,1,3,10,1,4,9,6,1,3,10,3,10,10,2,5,1,10,5,1,4,10,1,1,10,10,10,1,1,3,1,10,6,3,4,5,10,10,2,7,1,2,10,10,1,10,3,8,10)



#s = strata(sorted, stratanames=c("country"), Sz , method="srswor",description=TRUE)
s = strata(sorted, stratanames=c("strata"), Sz , method="srswor",description=TRUE)


d <- getdata(sorted,s)

View(d)

write_csv(d, file = "/home/zied/Documents/hackathon_2020/Mistemps3/retableauoutgroups/afric_outgrouptime4.csv")


