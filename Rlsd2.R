library(devtools)
devtools::install_github("tothuhien/Rlsd2", dependencies = TRUE)

# some packages are required: devtools, ape, treeio

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

library(BiocManager)
BiocManager::install("treeio")


#example

library(Rlsd2)
result <- lsd2(inputTree="R/x86_64-pc-linux-gnu-library/4.0/Rlsd2/data/D750_11_10_rooted.tree", 
               inputDate="R/x86_64-pc-linux-gnu-library/4.0/Rlsd2/data/D750_11_10.date", 
               outFile = "R/x86_64-pc-linux-gnu-library/4.0/Rlsd2/data/test_lsd2", seqLen=1000)

#example 2

tree <- read.tree("data/D750_11_10_rooted.tree")
dateTbl <- read.table("data/D750_11_10.date",skip=1,colClasses = "character")
date <- dateTbl[,2]
names(date) <- dateTbl[,1]
result <- lsd2(inputTree=tree, inputDate=date, 
               outFile = "data/test_lsd2", seqLen=1000)


###############################

# sars cov 2 Data  Hackathon

library(Rlsd2)
library(ape)
tree <- read.tree("Documents/hackathon_2020/Mistemps3/MLtree/Multiple_alignment_corrige1.fa.treefile")
dateTbl <- read.csv("Documents/hackathon_2020/Mistemps3/metadata/date_file_v1.csv",skip=1, colClasses = "character")
date <- as.Date(dateTbl[,6])
names(date) <- dateTbl[,2]
result <- lsd2(inputTree=tree, inputDate=date, constraint = TRUE , outGroup = "OROOT",
               outFile = "/home/zied/Documents/hackathon_2020/Mistemps3/rlsd2/lsdresults3", seqLen=34079)

######
# TEst 2 sarsCov

library(Rlsd2)
result <- lsd2(inputTree="Documents/hackathon_2020/mist_4/nCov_mafft_v1.fasta.treefile", 
               inputDate="Documents/hackathon_2020/mist_4/date_v4.tsv", 
               estimateRoot = "l",
               constraint = TRUE,
               outFile = "Documents/hackathon_2020/mist_4/rlsd2/lsdresults2", seqLen=34079)


# RAGE
library(Rlsd2)
result <- lsd2(inputTree="/home/zied/Documents/GEOVET/sequences/test_seraph_mar22/data_new/wholedat_GTR100.nwk", 
               inputDate="Documents/GEOVET/sequences/test_seraph_mar22/data_new/thedatefile_v3.csv", 
               estimateRoot="a",
               constraint = TRUE,
               confidenceInterval = TRUE,
               outFile = "Documents/GEOVET/sequences/test_seraph_mar22/resultRlsd2", seqLen=793)





# test ape

library("phangorn")
library("phytools")
library("geiger")
library("ape")
tree <- read.tree("Documents/hackathon_2020/Mistemps3/MLtree/Multiple_alignment_corrige1.fa.treefile")
plotTree(tree,offset=1)
#tiplabels()
nodelabels()



