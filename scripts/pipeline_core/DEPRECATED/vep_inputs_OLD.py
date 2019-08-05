#First uit should read a simple .vcf such as ../../../example_data/homo_sapiens_GRCh38.vcf
#This comes sfrom VEP exemple tutorial
import csv

# vcf_file = "../../../example_data/homo_sapiens_GRCh38.vcf"

def get_ids(input_file, format = "vcf"):
    SNP_ids = []
    if format == "vcf": #Getting rs ID from the third column (TAB SEPARATED in vcf)
        with open(input_file, newline="") as input:
            #if format = "vcf":
            input = csv.reader(input, delimiter="\t")
            for i in input:
                if not i[0].startswith("#"):
                    SNP_ids.append(i[2])
    else:
        print ("This format hasn't been implemented yet!")
        return "This format hasn't been implemented yet!"
    return SNP_ids

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #