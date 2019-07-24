import subprocess


def run_vpe(dins, fora, cache="~/.vep", extra=""):
    subprocess.call(["bash","run_vep.sh", dins, fora, cache, extra])


