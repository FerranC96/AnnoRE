library(dplyr)
library(stringr)


#Loading full haploR ouput
haploR_output <- read.delim("./output/OCD_haploR.tsv", row.names = NULL)

#Working only with input SNPs: Filter out those found in LD
main_haploR <- haploR_output[haploR_output$is_query_snp == 1,]
#select only relevant fields
main_haploR <- subset(main_haploR, select = c(rsID, chr, Proteins, eQTL, Promoter_histone_marks, Enhancer_histone_marks))

#Loading vep output: In .tsv format with --tab flag, skip to 58 to get only header and table
vep_output <- read.delim("./output/OCD.tsv", comment.char="", skip=58)

#Adding new column for rsID so that it can merged with haploR even if user input are coordinates
vep_output <- vep_output %>% dplyr::mutate(rsID = str_extract(Existing_variation, pattern = "rs\\d+(?=\\,|$)"))

merged <- left_join(vep_output, main_haploR, by=c("rsID"))

write.table(merged, file="./output/OCD_main_output.tsv", quote=FALSE, row.names = FALSE, sep="\t")


#FROM HERE ON, WIP

# for (i in nrow(main_haploR)){
#   if (main_haploR$rsID[i] == "rs1058399"){
#     x <- i
#     print (main_haploR$rsID[i])
#   }
# }