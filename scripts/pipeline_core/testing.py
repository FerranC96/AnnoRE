from vep import *

dins = "../../../example_data/homo_sapiens_GRCh38.vcf"
fora = "./output/hsapiens.vep"
cache = "/mnt/s/Project_3/vep_chached_database"
extra = "--fork 4 --force --stats_text --pubmed --regulatory" #pubmed for getting rs id when inputing coordinates, #regulatory and most_severe/or/biotype

run_vpe(dins, fora, cache, extra)

#Add function to read data: From .vep or from .txt stats file