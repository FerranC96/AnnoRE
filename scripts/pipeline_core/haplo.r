library("haploR")
# options(echo=TRUE)
# args <- commandArgs(trailingOnly = TRUE)
# print(args)

#COULD USE ARGS to let user set LD threshold

x <- queryHaploreg(file="./output/snp_file.txt", ldThresh = 0.9)


#Change output to tsv or similar
write.table(x, file="./output/hsapiens_haploR.tsv", quote=FALSE, sep="\t")