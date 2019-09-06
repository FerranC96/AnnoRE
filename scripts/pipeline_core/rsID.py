import csv
import re

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#                           Get rsIDs from VEP output                         #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


#Premiliminary handlers for different types of input: only support vep format 

def get_ids(vep_output, format = "vep"):
    SNP_ids = []
    if format == "vep": #Getting rs ID from the third column (TAB SEPARATED in vcf)
        with open(vep_output, newline="") as infile:
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
    
    regex2 = r"rs\d+(?=\,|$)" #Get rs id when cosm and other IDs are also present
    with open("./output/snp_file.txt", "w") as outfile:
        for i in SNP_ids:
            try:    #To get both standalone ids and those with COSM
                match = re.search(regex2, i).group(0)                
                outfile.write("%s\n" % match)
            except:
                outfile.write("%s\n" % i)
            

    return SNP_ids

