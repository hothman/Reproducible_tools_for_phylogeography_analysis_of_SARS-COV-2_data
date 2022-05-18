library(devtools)
devtools::install_github("tothuhien/Rlsd2", dependencies = TRUE)

# some packages are required: devtools, ape, treeio

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

library(BiocManager)
BiocManager::install("treeio")


# Sars-Cov-2 

library(Rlsd2)
result <- lsd2(inputTree="/path_to_tree_file/myfile.treefile", 
               inputDate="/path_to_metadata_file/my_date_file.tsv", 
               estimateRoot = "l",
               constraint = TRUE,
               outFile = "Documents/hackathon_2020/mist_4/rlsd2/lsdresults2", seqLen=34079)

