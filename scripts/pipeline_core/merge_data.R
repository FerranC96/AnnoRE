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
main_haploR <- subset(main_haploR, select = c(rsID, DNAse, Proteins, eQTL, Promoter_histone_marks, Enhancer_histone_marks))

#Loading vep output: In .tsv format with --tab flag, skip to 58 to get only header and table
vep_output <- read.delim("./output/OCD.tsv", comment.char="", skip=58)

#Adding new column for rsID so that it can merged with haploR even if user input are coordinates
vep_output <- vep_output %>% dplyr::mutate(rsID = str_extract(Existing_variation, pattern = "rs\\d+(?=\\,|$)"))

merged <- left_join(vep_output, main_haploR, by=c("rsID"))
merged <- merged %>% dplyr::mutate(chr = str_extract(Location, pattern = "^.*(?=\\:)"))

write.table(merged, file="./output/OCD_main_output.tsv", quote=FALSE, row.names = FALSE, sep="\t", na = "-")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#FROM plotting_and_summary rscript
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#Generating tables and plots: -> Enrichment plots generated in enrichXGR.R

#Distribution over chromosomes
chr_distro <- feature_type <- merged %>% group_by(chr) %>% summarise(Counts = n_distinct(X.Uploaded_variation))

chr_distro_plot <- ggplot(chr_distro,aes(x = chr, y = Counts, fill = chr)) +
  geom_bar(stat = "identity") +
  theme_classic() + theme(plot.title=element_text(face="bold")) + theme(axis.text.x=element_blank()) +
  labs(
    x = "Chromosome",
    y = "Number of variants",
    title = "Distribution of variants on chromosomes")

saveRDS(chr_distro_plot, file = "./output/Plots/chr_distro.rds")
ggsave(filename = "./output/Plots/chr_distro.svg", plot = chr_distro_plot)

#Consequences
conseq <- as.data.frame(table(merged$Consequence)) 
conseq <- conseq[sort.list(conseq$Freq),]
conseq$Var1 <- factor(conseq$Var1, levels = conseq$Var1)
colnames(conseq) <- c("Consequence","Count")

conseq_plot <- ggplot(conseq) +
  geom_bar(aes(Consequence, log10(Count)), stat = "identity") +
  theme_classic() + theme(plot.title=element_text(face="bold")) +
  coord_flip() +
  labs(
    x = "Consequence type",
    y = "log10(Number of variants)",
    title = "Consequences")
saveRDS(conseq_plot , file = "./output/Plots/consequences.rds")
ggsave(filename = "./output/Plots/consequences.svg", plot = conseq_plot)

#Generate pie chart with %of regulatory features vs total

feature_type <- merged %>% group_by(Feature_type) %>% summarise(Counts = n_distinct(X.Uploaded_variation))
feature_type_filtered <- feature_type[!(feature_type$Feature_type == "-"),] %>% mutate(percentage=Counts/sum(Counts)*100.0)
write.table(feature_type_filtered, file="./output/feature_type.tsv", quote=FALSE, row.names = FALSE, sep="\t")

feature_plot <- ggplot(feature_type_filtered, aes(x ="", y=percentage, fill = Feature_type)) +
  geom_bar(width = 1, stat="identity") +
  coord_polar("y", start = 0) +
  labs(x = NULL, y = NULL, fill = NULL, title = "Percentage of types of features") +
  guides(fill = guide_legend(reverse = TRUE)) +
  geom_text(aes(label = paste0(round(percentage), "%")), 
            position = position_stack(vjust = 0.5)) +
  theme_classic() + theme(plot.title=element_text(face="bold")) +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())

saveRDS(feature_plot, file = "./output/Plots/feature_type.rds")
ggsave(filename = "./output/Plots/feature_type.svg", plot = feature_plot)
  
#First get reg table from main merged output:

regulatory <- merged[merged$Feature_type == "RegulatoryFeature",]
regulatory_subset <- subset(regulatory, select = c(X.Uploaded_variation, Location, Feature, BIOTYPE, DNAse, Promoter_histone_marks, Enhancer_histone_marks))
write.table(regulatory_subset, file = "./output/regulatory_variants.tsv", quote = FALSE, sep="\t")

#Biotype
reg_biotype <- regulatory_subset %>%  group_by(BIOTYPE) %>% summarise(counts = n_distinct(X.Uploaded_variation))
write.table(reg_biotype, file="./output/reg_bio.tsv", quote=FALSE, row.names = FALSE, sep="\t")

reg_bio_plot <- ggplot(reg_biotype ,aes(x = BIOTYPE, y = counts, fill = BIOTYPE)) +
  geom_bar(stat = "identity") +
  theme_classic() + theme(plot.title=element_text(face="bold")) +
  labs(
    x = "Biotype of regulatory feature",
    y = "Number of distinct rsIDs",
    title = "Types of regulatory features"
  )
saveRDS(reg_bio_plot, file = "./output/Plots/reg_bio.rds")
ggsave(filename = "./output/Plots/reg_bio.svg", plot = reg_bio_plot)


#P_histone
reg_phistone <- separate_rows(regulatory_subset, Promoter_histone_marks) %>% group_by(Promoter_histone_marks) %>% summarise(counts = n_distinct(X.Uploaded_variation))
reg_phistone_filtered <- reg_phistone[(!(reg_phistone$Promoter_histone_marks=="NA") & !(reg_phistone$Promoter_histone_marks=="")),] %>% drop_na()
write.table(reg_phistone_filtered, file="./output/reg_phist.tsv", quote=FALSE, row.names = FALSE, sep="\t")

reg_phist_plot <- ggplot(reg_phistone_filtered ,aes(x = Promoter_histone_marks, y = counts, fill = Promoter_histone_marks)) +
  geom_bar(stat = "identity") +
  theme_classic() + theme(plot.title=element_text(face="bold")) + theme(axis.text.x = element_text(angle=45, vjust=1, hjust=1)) + 
  labs(
    x = "Tissues",
    y = "Number of distinct rsIDs",
    title = "Promoter histone marks in regulatory variants"
  )
saveRDS(reg_phist_plot, file = "./output/Plots/reg_phist.rds")
ggsave(filename = "./output/Plots/reg_phist.svg", plot = reg_phist_plot)

#E_histone
reg_ehistone <- separate_rows(regulatory_subset, Enhancer_histone_marks) %>% group_by(Enhancer_histone_marks) %>% summarise(counts = n_distinct(X.Uploaded_variation))
reg_ehistone_filtered <- reg_ehistone[(!(reg_ehistone$Enhancer_histone_marks=="NA") & !(reg_ehistone$Enhancer_histone_marks=="")),] %>% drop_na()
write.table(reg_ehistone_filtered, file="./output/reg_ehist.tsv", quote=FALSE, row.names = FALSE, sep="\t")

reg_ehist_plot <- ggplot(reg_ehistone_filtered ,aes(x = Enhancer_histone_marks, y = counts, fill = Enhancer_histone_marks)) +
  geom_bar(stat = "identity") +
  theme_classic() + theme(plot.title=element_text(face="bold")) + theme(axis.text.x = element_text(angle=45, vjust=1, hjust=1)) +
  labs(
    x = "Tissues",
    y = "Number of distinct rsIDs",
    title = "Enhancer histone marks in regulatory variants"
  )
saveRDS(reg_ehist_plot, file = "./output/Plots/reg_ehist.rds")
ggsave(filename = "./output/Plots/reg_ehist.svg", plot = reg_ehist_plot)

#DNase 
reg_dnase <- separate_rows(regulatory_subset, DNAse) %>% group_by(DNAse) %>% summarise(counts = n_distinct(X.Uploaded_variation))
reg_dnase_filtered <- reg_dnase[(!(reg_dnase$DNAse=="NA") & !(reg_dnase$DNAse=="")),] %>% drop_na()
write.table(reg_dnase_filtered, file="./output/reg_dnase.tsv", quote=FALSE, row.names = FALSE, sep="\t")

reg_dnase_plot <- ggplot(reg_dnase_filtered ,aes(x = DNAse, y = counts, fill = DNAse)) +
  geom_bar(stat = "identity") +
  theme_classic() + theme(plot.title=element_text(face="bold")) + theme(axis.text.x = element_text(angle=90, vjust=1, hjust=1)) +
  labs(
    x = "EIDs",
    y = "Number of distinct rsIDs",
    title = "DNAse I hypersensitivity sites in regulatory variants"
  )
saveRDS(reg_dnase_plot, file = "./output/Plots/reg_dnase.rds")
ggsave(filename = "./output/Plots/reg_dnase.svg", plot = reg_dnase_plot)


#Report generation
rmarkdown::render("./output/Report/Template.Rmd")