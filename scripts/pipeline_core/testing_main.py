from vep import *
from rsID import *
from haploR import *

dins = "../../../example_data/homo_sapiens_GRCh38.vcf"
fora = "./output/hsapiens.vep"
cache = "/mnt/s/Project_3/vep_chached_database"
extra = "--fork 4 --force --pubmed --regulatory --stats_text " #--stats_text #pubmed for getting rs id when inputing coordinates, #regulatory and most_severe/or/biotype

run_vpe(dins, fora, cache, extra)

snp_list = get_ids(fora)

run_haploR(snp_list)



#Add function to read data: From .vep or from .txt stats file