#Variant Effect Predictor

Had to install cpanm.
Then install VEP perl dependencies thourgh cpanm:
- sudo cpanm Archive::Zip
- sudo cpanm DBD::mysql   -> sudo apt-get install libdbd-mysql-perl  <!-- Couldn't isntall through cpanm -->
- Install DBI
Now run INSTALL.PL (though perl) to install VEP and download human cache (I did download the _merged file, circa 15gb)
														
Local install on SB2 (WSL2):
VEP  cache lives in ~/.vep (downloaded merged human 38 data); VEP itself and its standard output directory is on ~/ensembl-vep.

Followed and finished tutorial for VEP. Seems much better mantained than ANNOVAR, and probably easier to tinker with and try to feed /parse data in various formats.

#NOTES:
Installation sorted on SB2. However, some problems where found when trying to install on HPC's login (probably for the better, shouldn't install anything in there right?).
Ideally everything should be able to work in a confined docker, no matter if local or HPC (check -> http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#docker )

