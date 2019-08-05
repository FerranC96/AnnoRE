import requests, sys, json


def functann(SNP_ids):
    server = "https://rest.ensembl.org"
    ext = "/vep/human/id"
    headers={ "Content-Type" : "application/json", "Accept" : "application/json"}
    input_ids={}
    input_ids["ids"] = SNP_ids
    data = json.dumps(input_ids)
    r = requests.post(server+ext, headers=headers, data=data)
    
    if not r.ok:
        r.raise_for_status()
        sys.exit()
    decoded = r.json()
    #Write to json -> Not necessary, should instead return object to be formated in our format.
    with open("results.json","w") as output:
        json.dump(decoded, output, indent=4)
    return decoded

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #