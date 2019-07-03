.. Functional annotation of genomics data documentation master file.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to Functional annotation of genomics data's documentation!
==================================================================

.. toctree::
   :maxdepth: 2
   :caption: Contents:



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

========================
Annotation of SNPs
========================
.. image:: #
    :alt: Types of tools

--------
Tools
--------

Purely functional:
- VEP: Using VEP's Python API one can bulk query their database with variant identifiers [should also work with VCFs(important for ANNOVAR) and Ensembl's format]. For more info on this I NEED TO PORT FORM ONENOTE!

Conservation tools:
- ANNOVAR: Very complete tool, can perform a miriad of differnt analysis. Works with VCF format (check anemia.cvf)

-----
Data
-----

========================
Possible workflows
========================

----------
srep09453
----------
`Prediction of likelihood of function and regulatory features of non-coding SNPs <https://www.nature.com/articles/srep09453>`_.

With association data from the National Human Genome Research Institute GWAS Catalog, they get SNPs with valid rs ids.
Annotate those SNP with data from Ensembl human gene annotation, UCSC and AceView. To do so, also downloaded necessary prot. sequences and mRNA seqs. from the three sites.
Conservation data from UCSC tfbsConsSites was used in predicting the transcription factor binding sites.

Then , they performed the following steps (excerpt from their methods):

- Mapping the GASs to regulatory features: To reassess noncoding GASs, we eliminated the SNPs that were mapped to the exonic and splicing regions of the RefSeq database from the whole set of 9828 GASs. The sequences of risk alleles for many GASs are the same as the reference sequences of the human genome, which can be explained by several reasons: (i) the opposite alleles of GASs were reported as risk in the database owing to their relative risk (RR) or odds ratio (OR) < 11; (ii) some reference alleles may become detrimental in evolution due to environmental pressures; and (iii) a fraction of reference alleles could be different among distinct populations because of polymorphisms. We then explored non-RefSeq-exonic GASs with the annotation of regulatory features catalogued in the HaploReg26 and RegulomeDB27 databases. Annotated regulatory features included promoter, enhancer, regulatory motifs, DNAse footprinting sites, expression quantitative trait loci (eQTL), and conserved elements (predicted by GERP33 and SiPhy34,35). We separately conducted the mapping analyses for GASs using the web servers of HaploReg and RegulomeDB.
- Annotating: TEST

================
Current status
================

Currently XXXX

Future YYYYY


