#GETS IDS AFTER VEP 


#First uit should read a simple .vcf such as ../../../example_data/homo_sapiens_GRCh38.vcf
#This comes sfrom VEP exemple tutorial
import csv
import re

# vcf_file = "../../../example_data/homo_sapiens_GRCh38.vcf"

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
    
    regex = r"(rs.*?)\,"    #REGEX to get rs id when cosm and other identifiers are also present
    with open("./output/snp_file.txt", "w") as outfile:
        for i in SNP_ids:
            try:    #To get both standalone ids and those with COSM
                match = re.search(regex, i).group(1)
                outfile.write("%s\n" % match)
            except:
                outfile.write("%s\n" % i)
            

    return SNP_ids
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# def create_vep_medfile(vep_output, medfile):
    
#     with open(vep_output, newline="") as infile:
#         with open(medfile, "w") as medfile:
#             for line in infile:
#                 if not "##" in line:
#                     medfile.write(line)
            
#                     # for rsid in SNP_ids:
#                     #     print(rsid)
                        
#                     # SNP_ids.append(i[12])

# def rsid_to_vep(vep_output, medfile, SNP_ids):
#     with open(medfile,"w", newline="") as outfile:
#         #outfile = csv.writer(medfile, delimiter="\t")
#         with open(vep_output, newline="") as infile:
#             infile = csv.reader(medfile, delimiter="\t")
#             for i in infile:
#                 if not "#" in i:
#                     for rsid in SNP_ids:
#                         if rsid in i[12]:
#                             print(i.append(rsid))


        
#             print(i[12])




        # with open("./output/med_output", newline="") as infile:
        #     infile = csv.reader(infile, delimiter="\t")

# def rsid_to_vep(SNP_ids, haploR_output):
#     with open(haploR_output, newline="") as infile:
#         infile = csv.reader(infile, delimiter="\t")
#         for i in infile:
            
#             print(i[6])
#         # with open("./output/med_output", newline="") as infile:
#         #     infile = csv.reader(infile, delimiter="\t")