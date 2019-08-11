from vep import *
from rsID import *
from haploR import *

#Defined params for input, ouput, databse locations, vep arguments
dins = "../../example_input/homo_sapiens_GRCh38.vcf"
fora = "./output/hsapiens.tsv"
cache = "/mnt/s/Project_3/vep_chached_database"
extra = "--fork 4 --force --pubmed --regulatory --stats_text --af_1kg --tab" #--stats_text #pubmed for getting rs id when inputing coordinates, #regulatory and most_severe/or/biotype

medfile = "./output/med_output"
haploR_output = "./output/hsapiens_haploR.tsv"
#Run vep: Python-> bash

#run_vpe(dins, fora, cache, extra)


#Get dbSNP ids for inout, even if originally coordinates: Python

snp_list = get_ids(fora)


#Pass those ids to haploR: HaploReg is a tool for exploring annotations of the noncoding genome at variants on haplotype blocks
#Python -> Rscript

run_haploR(snp_list)


#Until this point we have saved the results to file

#RUN Rscript merge_Data:
#Nw only merges data, should merge data, output main dataframe to tsv (DONE), and also summary tables


#Glanet/GAT: 

#Vis