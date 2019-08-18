library(tidyr)
library(dplyr)
library(stringr)
library(ggplot2)
library(svglite)


#Loading full haploR ouput
haploR_output <- read.delim("./output/OCD_haploR.tsv", row.names = NULL)

#Working only with input SNPs: Filter out those found in LD
main_haploR <- haploR_output[haploR_output$is_query_snp == 1,]
#select only relevant fields
main_haploR <- subset(main_haploR, select = c(rsID, Proteins, eQTL, Promoter_histone_marks, Enhancer_histone_marks))

#Loading vep output: In .tsv format with --tab flag, skip to 58 to get only header and table
vep_output <- read.delim("./output/OCD.tsv", comment.char="", skip=58)

#Adding new column for rsID so that it can merged with haploR even if user input are coordinates
vep_output <- vep_output %>% dplyr::mutate(rsID = str_extract(Existing_variation, pattern = "rs\\d+(?=\\,|$)"))

merged <- left_join(vep_output, main_haploR, by=c("rsID"))

write.table(merged, file="./output/OCD_main_output.tsv", quote=FALSE, row.names = FALSE, sep="\t", na = "-")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#FROM plotting_and_summary rscript
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#First get reg table from main merged output:

regulatory <- merged[merged$Feature_type == "RegulatoryFeature",]
regulatory_subset <- subset(regulatory, select = c(X.Uploaded_variation, Location, Feature, Consequence, BIOTYPE, Promoter_histone_marks, Enhancer_histone_marks))

#Generating tables and plots:

#Generate pie chart with %of regulatory features vs total!


#Biotype
reg_biotype <- regulatory_subset %>%  group_by(BIOTYPE) %>% summarise(counts = n_distinct(X.Uploaded_variation))
write.table(reg_biotype, file="./output/reg_bio.tsv", quote=FALSE, row.names = FALSE, sep="\t")

reg_bio_plot <- ggplot(reg_biotype ,aes(x = BIOTYPE, y = counts, fill = BIOTYPE)) +
  geom_bar(stat = "identity") +
  theme_classic() +
  labs(
    x = "Biotype of regulatory feature",
    y = "Number of distinct rsIDs",
    title = "Test plotting of regulatory features"
  )
saveRDS(reg_bio_plot, file = "./output/Plots/reg_bio.rds")
ggsave(filename = "./output/Plots/reg_bio.svg", plot = reg_bio_plot)


#P_histone
reg_phistone <- separate_rows(regulatory_subset, Promoter_histone_marks) %>% group_by(Promoter_histone_marks) %>% summarise(counts = n_distinct(X.Uploaded_variation))
reg_phistone_filtered <- reg_phistone[(!(reg_phistone$Promoter_histone_marks=="NA") & !(reg_phistone$Promoter_histone_marks=="")),]
write.table(reg_phistone_filtered, file="./output/reg_phist.tsv", quote=FALSE, row.names = FALSE, sep="\t")

reg_phist_plot <- ggplot(reg_phistone_filtered ,aes(x = Promoter_histone_marks, y = counts, fill = Promoter_histone_marks)) +
  geom_bar(stat = "identity") +
  theme_classic() +
  labs(
    x = "Promoter histone marks",
    y = "Number of distinct rsIDs",
    title = "Tissues from haploR"
  )
saveRDS(reg_phist_plot, file = "./output/Plots/reg_phist.rds")
ggsave(filename = "./output/Plots/reg_phist.svg", plot = reg_phist_plot)

#E_histone
reg_ehistone <- separate_rows(regulatory_subset, Enhancer_histone_marks) %>% group_by(Enhancer_histone_marks) %>% summarise(counts = n_distinct(X.Uploaded_variation))
reg_ehistone_filtered <- reg_ehistone[(!(reg_ehistone$Enhancer_histone_marks=="NA") & !(reg_ehistone$Enhancer_histone_marks=="")),]
write.table(reg_ehistone_filtered, file="./output/reg_ehist.tsv", quote=FALSE, row.names = FALSE, sep="\t")

reg_ehist_plot <- ggplot(reg_ehistone_filtered ,aes(x = Enhancer_histone_marks, y = counts, fill = Enhancer_histone_marks)) +
  geom_bar(stat = "identity") +
  theme_classic() +
  labs(
    x = "Enhancer histone marks",
    y = "Number of distinct rsIDs",
    title = "Tissues from haploR"
  )
saveRDS(reg_ehist_plot, file = "./output/Plots/reg_ehist.rds")
ggsave(filename = "./output/Plots/reg_ehist.svg", plot = reg_ehist_plot)
