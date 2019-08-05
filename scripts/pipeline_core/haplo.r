library("haploR")
# options(echo=TRUE)
# args <- commandArgs(trailingOnly = TRUE)
# print(args)

x <- queryHaploreg(file="./output/snp_file.txt", ldThresh = 0.9)

require(openxlsx)
write.xlsx(x, file="./output/hsapiens_haploR.xlsx")