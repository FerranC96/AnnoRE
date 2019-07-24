#!/home/ferranc96/anaconda3/bin/python
import argparse
from vep import *

#run it like so: 
#   python main.py "../../../example_data/truncated_anemia.vcf" "./output/one.txt" "/mnt/s/Project_3/vep_chached_database"
parser = argparse.ArgumentParser()

parser.add_argument("inputfile")
parser.add_argument("outputfile")
parser.add_argument("cache")
# parser.add_argument("extra")
args = parser.parse_args()

# if args.extra:
#     run_vpe(args.inputfile, args.outputfile, args.cache, args.extra)

# else:
run_vpe(args.inputfile, args.outputfile, args.cache)

