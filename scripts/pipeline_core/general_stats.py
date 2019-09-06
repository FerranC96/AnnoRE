import csv
import re

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#                           Extract data from VEP summary                     #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

def gen_stats(vep_output):
    vep_summ = vep_output + "_summary.txt"
    general_statistics = []
    with open(vep_summ, newline="") as infile:
        infile = csv.reader(infile, delimiter="\t")
        for i in infile:
            if len(i) != 0:
                if i[0] == "Lines of input read":
                    general_statistics.append(i[0] + "\t" + i[1])
                elif i[0] == "Variants processed":
                    general_statistics.append(i[0] + "\t" + i[1])
                elif i[0] == "Variants filtered out":
                    general_statistics.append(i[0] + "\t" + i[1])
                elif i[0] == "Novel / existing variants":
                    general_statistics.append(i[0] + "\t" + i[1])
                elif i[0] == "Overlapped genes":
                    general_statistics.append(i[0] + "\t" + i[1])
                elif i[0] == "Overlapped transcripts":
                    general_statistics.append(i[0] + "\t" + i[1])
                elif i[0] == "Overlapped regulatory features":
                    general_statistics.append(i[0] + "\t" + i[1])    
    
    with open("./output/gen_stats.tsv", "w") as outfile:
        for i in general_statistics:
            outfile.write("%s\n" % i)                
