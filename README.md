MSc_Project3
============

Working with VEP instead of ANNOVAR. More details on VEP can be found in ./testing_tools/vep/vep_cli.md.
Using data related to blood assays, we base our work on three initial sets of data:
1. GTex v7: Whole blood genes and significant_variant_pair_genes
2. Metabolites (gwassserver_metabolomics): From shin_et_al. Directory also contains shure_2011 koraf4 and twinsuk associations
3. Proteome atlas: From Sun et al. 2018. WIP

## Inputs


This github repository is in a parent directory that contains a "blood" directory with all data mentioned above.
Below, see the a schematic representation of the directory structure.
![alt text][tree]
[tree]: https://github.com/FerranC96/MSc_Project3/blob/master/docs/figs/Tree.png "Tree"

## Outputs

As mentioned in ./testing_tools/vep/vep_cli.md default outputs for vep will be in its installation folder.
However, temporarily some selected examples are shown on ./ouputs.


Current work
------------
XXXXXXX.

From the review on ./papers, get ideas for the overall future steps in the annotation.

TO DO:
1. Write bash script to handle inputs, run VEP, and saving ouputs.
2. Far away land(>week): Cgat-core and running on HPC)

