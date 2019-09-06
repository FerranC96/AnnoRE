library(XGR)
library(ggplot2)
library(svglite)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#                  SNP-based enrichment analysis with XGR                     #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#TO-DO: Add support for argument passing

#Load rsIDs and vectorize for XGR:
snp_file <- read.table("./output/snp_file.txt", quote="\"", comment.char="")
snp_INPUTVECTOR <- as.vector(snp_file[,1])


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Perform Enrichment
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#NOt using SNPs in LD -> Add Rscrarg for selecting LD and threshold (-ld X)
#Will be taken by both HaploR and XGR.
#IN XGR transalate as xEnricherSNPs(..., include.LD=c("AFR", "AMR", "EAS", "EUR", "SAS"), LD.r2 = X)
enrichment <- xEnricherSNPs(snp_INPUTVECTOR, min.overlap=2, verbose=T,
                            size.range=c(3,2000))
enrichment_results <- xEnrichViewer(enrichment, details = T)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Generate summary tables with results
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

write.table(enrichment_results, file="./output/enrichment_summary.tsv", 
            quote=FALSE, row.names = FALSE, sep="\t")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Producing graphs
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

bar_plot <- xEnrichBarplot(enrichment, signature = FALSE)
dot_plot <- xEnrichDotplot(enrichment)

#Either save as images (most probable) or save for report
saveRDS(bar_plot, file = "./output/Plots/enrich_bar.rds")
saveRDS(dot_plot, file = "./output/Plots/enrich_dot.rds")

ggsave(filename = "./output/Plots/enrich_bar.svg", plot = bar_plot)
ggsave(filename = "./output/Plots/enrich_dot.svg", plot = dot_plot)
