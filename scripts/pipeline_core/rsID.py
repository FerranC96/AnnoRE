#GETS IDS AFTER VEP 


#First uit should read a simple .vcf such as ../../../example_data/homo_sapiens_GRCh38.vcf
#This comes sfrom VEP exemple tutorial
import csv
import re

# vcf_file = "../../../example_data/homo_sapiens_GRCh38.vcf"

def get_ids(input_file, format = "vep"):
    SNP_ids = []
    if format == "vep": #Getting rs ID from the third column (TAB SEPARATED in vcf)
        with open(input_file, newline="") as infile:
            #if format = "vcf":
            infile = csv.reader(infile, delimiter="\t")
            for i in infile:
                if not i[0].startswith("#"):
                    SNP_ids.append(i[12])
    else:
        print ("This format hasn't been implemented yet!")
        return "This format hasn't been implemented yet!"
    SNP_ids = set(SNP_ids)
    SNP_ids = list(SNP_ids)
    
    regex = r"(rs.*?)\,"    #REGEX to get rs id when cosm also present
    with open("./output/snp_file.txt", "w") as outfile:
        for i in SNP_ids:
            try:    #To get both standalone ids and those with COSM
                match = re.search(regex, i).group(1)
                outfile.write("%s\n" % match)
            except:
                outfile.write("%s\n" % i)
            

    return SNP_ids

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #