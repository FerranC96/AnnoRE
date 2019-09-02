AnnoRE: a pipeline for integrated functional annotation and enrichment analysis of genetic variants associated with complex traits.
============

Developed during the third and final project of the MSc in Bioinformatics and Theoretical Systems Biology, at Imperial College London.
Work supervised by: Dr. Antonio Berlanga-Taylor (@AntonioJBT) 

AnnoRE AnnoRE is a pipeline for integrated functional annotation and enrichment analysis of genetic variants associated with complex traits.
With a focus on regulatory regions, AnnoRE leverages pre-existing tools for annotation and enrichment analysis, integrating the different outputs and
producing summary tables and plots. 
The inclusion of these results into an interactive summary report facilitates interpretation,
making AnnoRE an accessible yet powerful tool suitable for less experienced users

AnnoRE flowchart:
![alt text][flowchart]

[flowchart]: https://github.com/FerranC96/MSc_Project3/blob/master/docs/figs/Pipeline.png "Tree"

A schematic representation of AnnoRE’s pipeline is shown as a flowchart.
The central steps during the analysis are all shown embedded into the main function
main.py in the order they take place: 
1. Loading of input data and setting of parameters.
2. Annotation with VEP and then HaploReg.
3. Enrichment analysis with XGR.
4. Data handling and generation of main ouput, summary tables and plots
5. Generation of the interactive [summary report](https://ferranc96.github.io/AnnoRE/). Inputs are shown inside the green dashed box, with the outputs listed inside the yellow dashed box. Scripts,and the language they are written in, are depicted as light blue boxes with a protruding arrow.

## How to use

(Make sure the data is in .VCF format first)
1. Change input and cache directory and name output in `main.py`.
2. Run `main.py`
3. Outputs will appear on the `/Output` directory

## Dependencies

* VEP script:
 * Needs a local copy of the [GRCh38 assembly](ftp://ftp.ensembl.org/pub/current_variation/)

* Python v>3. Packages:
  * `subprocess`
  * `csv`
  * `re`
* R v=>3.5. Packages:
  * `cowplot`
  * `dplyr`
  * `ggplot2`
  * `ggpubr`
  * `grid`
  * `gridExtra`
  * `haploR`
  * `kableExtra`
  * `knitr`
  * `lattice`
  * `plotly`
  * `rmarkdown`
  * `stringr`
  * `svglite`
  * `tidyr`
  * `XGR`

