from vep import *
from rsID import *
from haploR import *
from enrichXGR import *
from merge_data import *
from general_stats import *

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#                           Main script for AnnoRE                            #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


#Defined params for input, ouput, databse locations, vep arguments
#They will be read from config file in the future

snp_input = "../../example_input/OCD_gwas_sign.vcf"
vep_output = "./output/OCD.tsv"
vep_cache = "/mnt/s/Project_3/vep_chached_database"
vep_extra = "--fork 4 --force --pubmed --regulatory --af_1kg --tab --stats_text" 
    #pubmed for getting rs id when inputing coordinates
    #regulatory and most_severe/or/biotype
ld = 0.9
haploR_output = "./output/OCD_haploR.tsv"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#VEP: Initial annotation of variants
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Run vep with custom flags: Python-> bash

run_vpe(snp_input, vep_output, vep_cache, vep_extra)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Get dbSNP rsIDs for input, even if originally coordinates
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

snp_list = get_ids(vep_output)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#HaploReg: Additional regulatory annotation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Pass those ids to haploR: Python -> Rscript

run_haploR(snp_list)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#XGR: SNP-based enrichment analysis 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Create table results for XGR, save also files for next step's merger.
#Genrate bar and dot plot. Python-> Rscript

run_enrichXGR(ld)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Summary tables, plots and report 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#First: Python function to read and write data from vep's .txt summary into .tsv files
gen_stats(fora)

#Gather all data in .tsv files and generate main_output.
#Creates and stores summary tables and plots
#Finally, generates summary report

main_and_plots()

