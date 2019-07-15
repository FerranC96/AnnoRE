# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
#Script to annotate using VEPs API
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
import requests, sys, json, csv
from read_input import *
from anno_vep import *

#First uit should read a simple .vcf such as ../../../example_data/homo_sapiens_GRCh38.vcf
vcf_file = "../../../example_data/homo_sapiens_GRCh38.vcf" #This comes sfrom VEP exemple tutorial

#Getting rs ID from the third column (TAB SEPARATED)
SNP_ids = get_ids(vcf_file)

#Now pasre that through API, which returns a json
decoded = functann(SNP_ids)
print (decoded)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
