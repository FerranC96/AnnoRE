import requests, sys
  
server = "https://rest.ensembl.org"
ext = "/vep/human/id"
headers={ "Content-Type" : "application/json", "Accept" : "application/json"}

################################################################################
##~No hardcoded ids~#

SNP_ids = ["rs7072216", "exm847632", "exm2271337"]

################################################################################

r = requests.post(server+ext, headers=headers, data='{ "ids" : SNP_ids }')
  
if not r.ok:
  r.raise_for_status()
  sys.exit()
  
decoded = r.json()
print(repr(decoded))

################################################################################
#~Write json to file~#
import json

with open("results.json","w") as output:
  json.dump(decoded, output, indent=4)
