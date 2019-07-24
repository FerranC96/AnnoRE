Current state:
-run_vep.sh calls and runs vep with additional arguments
-Those arguments are currently being handled by vep.py python file and whatever values are assigned to them either via testing.py (hardcoded) or main.py (WIP, interactive arguments)
-Entries with MOTIF have SNP affecting TFBindingMotiff et al. BIOTYPE field add info on regulatory feature (promoter, TFB,..).
    -Unless --biotype argument is used. In that case ALL entries will have their BIOTYPE field

Future:
-Use instead of arguemnts a previous function in the "pipeline" so as to first generate a --config file for vep that can then be used when running vep!

Other:
-getop_main is for deprecated testing of an alternative argmuent passing method
-vepo_inputs: Funtion for reading snp from a simple .vcp. Used in the old code for the API, but mght be used as so/be adapted to use with final workflow.

#TO DO
-Use RegulomeDB data for regulation info downstream afet vep
-Generate plots/tables from output