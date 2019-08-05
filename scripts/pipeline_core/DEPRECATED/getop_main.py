#!/home/ferranc96/anaconda3/bin/python
import sys, getopt
from vep import *
# import argparse
# parser = argparse.ArgumentParser()

def main(argv):
    extra=""
    inputfile = ""
    outputfile = ""
    cache = ""
    help = ("main.py -i <inputfile> -o <outputfile> --cache -dir <database>")
    try:
        opts, args = getopt.getopt(argv,"hi:o:c:",["ifile=","ofile="])
    except getopt.GetoptError:
        print (help)
        sys.exit(2)
    for opt, arg, in opts:
        if opt == "h":
            print (help)
            sys.exit()
        elif opt in ("-i","--ifile"):
            inputfile =arg
        elif opt in ("-o","--ofile"):
            outputfile =arg
    print ('Input file is "', inputfile)
    print ('Output file is "', outputfile)

if __name__ == "__main__":
    main(sys.argv[1:])