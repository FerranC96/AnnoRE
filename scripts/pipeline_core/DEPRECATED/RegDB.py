import subprocess


def regDB(snp_list):
    command = 'Rscript'
    path2script = 'regdb.r'
    args = snp_list
    cmd = [command, path2script] + args
    print (cmd)
    subprocess.call(cmd, shell = True)
    print("regdb.py completed")

