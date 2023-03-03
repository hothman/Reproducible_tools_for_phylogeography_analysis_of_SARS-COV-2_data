library(devtools)
devtools::install_github("tothuhien/Rlsd2", dependencies = TRUE)

# some packages are required: devtools, ape, treeio

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

library(BiocManager)
BiocManager::install("treeio")



# sars cov 2 Data  Hackathon

library(Rlsd2)
result <- lsd2(inputTree="Documents/hackathon_2020/mist_4/nCov_mafft_v1.fasta.treefile", 
               inputDate="Documents/hackathon_2020/mist_4/date_v4.tsv", 
               estimateRoot = "l",
               constraint = TRUE,
               outFile = "Documents/hackathon_2020/mist_4/rlsd2/lsdresults2", seqLen=34079)





