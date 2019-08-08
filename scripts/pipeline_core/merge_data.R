
#Loading full haploR ouput
haploR_output <- read.delim("./output/hsapiens_haploR.tsv")

#Working only with input SNPs: Filter out those found in LD
main_haploR <- haploR_output[haploR_output$is_query_snp == 1,]


#Loading vep output: In .tsv format with --tab flag, skip to 58 to get only header and table
vep_output <- read.delim("./output/hsapiens.tsv", comment.char="", skip=58)

View(vep_output)

#FROM HERE ON, WIP

# for (i in nrow(main_haploR)){
#   if (main_haploR$rsID[i] == "rs1058399"){
#     x <- i
#     print (main_haploR$rsID[i])
#   }
# }