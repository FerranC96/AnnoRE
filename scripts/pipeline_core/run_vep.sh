#!/bin/bash
#Preliminary script for annotating data using VEP
#3 cached database /mnt/s/Project_3/vep_chached_database
#1 input ../../../example_data/homo_sapiens_GRCh38.vcf
#2 output test.txt

vep -i $1 -o $2 --cache --dir $3 $4