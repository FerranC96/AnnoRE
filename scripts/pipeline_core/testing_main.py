from vep import *
from rsID import *
from haploR import *

#Defined params for input, ouput, databse locations, vep arguments
dins = "../../example_input/OCD_gwas_sign.vcf"
fora = "./output/OCD.tsv"
cache = "/mnt/s/Project_3/vep_chached_database"
extra = "--fork 4 --force --pubmed --regulatory --af_1kg --tab" #--stats_text #pubmed for getting rs id when inputing coordinates, #regulatory and most_severe/or/biotype

haploR_output = "./output/OCD_haploR.tsv"

#Run vep: Python-> bash

#run_vpe(dins, fora, cache, extra)


#Get dbSNP ids for inout, even if originally coordinates: Python

snp_list = get_ids(fora)


#Pass those ids to haploR: HaploReg is a tool for exploring annotations of the noncoding genome at variants on haplotype blocks
#Python -> Rscript

#run_haploR(snp_list)


#Until this point we have saved the results to file

#Enrichment with XGR: conducts SNP-based enrichment analysis using GWAS Catalog traits mapped to Experimental Factor Ontology (Welter et al. 2014)
#Create table results for XGR, save also files for next step's merger
#Genrate plots: Bar and dot plot
#Run enrichXGR.r

#DATA & plots:
#-Add also data from XGR (to the SNPs used, can be found in $annotation. 
# -output main dataframe to tsv (DONE), and also summary tables (WIP)
#Finally generate plots from summary tables
#Run merge_data.r

