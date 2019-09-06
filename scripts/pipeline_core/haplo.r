library("haploR")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#                  Querying HaploReg's database via haploR                    #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#COULD USE ARGS to let user set LD threshold
# options(echo=TRUE)
# args <- commandArgs(trailingOnly = TRUE)

x <- queryHaploreg(file="./output/snp_file.txt", ldThresh = 0.9, timeout = 1000)

#Write output as .tsv
write.table(x, file="./output/OCD_haploR.tsv", quote=FALSE, sep="\t")
