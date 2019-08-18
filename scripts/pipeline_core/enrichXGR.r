library(XGR)
library(ggplot2)
library(svglite)

#ADD ARGS!!!!

#Load rsIDs and vectorize for XGR:
snp_file <- read.table("./output/snp_file.txt", quote="\"", comment.char="")
snp_INPUTVECTOR <- as.vector(snp_file[,1])

#Perform Enrichment
#NOt using SNPs in LD -> Add arg for selecting LD and threshold (-ld X)
#Will be taken by both HaploR and XGR.
#IN XGR transalate as xEnricherSNPs(..., include.LD=c("AFR", "AMR", "EAS", "EUR", "SAS"), LD.r2 = X)
enrichment <- xEnricherSNPs(snp_INPUTVECTOR, min.overlap=2, verbose=T, size.range=c(3,2000))
enrichment_results <- xEnrichViewer(enrichment, details = T)

#Generate summary tables for Enrichment
write.table(enrichment_results, file="./output/enrichment_summary.tsv", quote=FALSE, row.names = FALSE, sep="\t")

#Producing graphs. Either save as images (most probable) or save for report [future]
bar_plot <- xEnrichBarplot(enrichment, signature = FALSE)
dot_plot <- xEnrichDotplot(enrichment)

saveRDS(bar_plot, file = "./output/Plots/enrich_bar.rds")
saveRDS(dot_plot, file = "./output/Plots/enrich_dot.rds")

ggsave(filename = "./output/Plots/enrich_bar.svg", plot = bar_plot)
ggsave(filename = "./output/Plots/enrich_dot.svg", plot = dot_plot)
