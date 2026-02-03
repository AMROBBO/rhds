from dotenv import dotenv_values

myconfig = dotenv_values("scripts/config.env")

datadir = myconfig["datadir"]
resultsdir = myconfig["resultsdir"]
docsdir = myconfig["docsdir"]

onstart:
    print("running analysis pipeline")
    print(myconfig)

rule all:
    input:
        f"{resultsdir}/md5sums.txt"

rule download_data:
    "Download the omic data"
    input:
        "scripts/files.csv"
    output:
        f"{resultsdir}/md5sums.txt"
    container:
        "rhds-tcga-r.sif"
    log:
        f"{resultsdir}/logs/download-data.log"
    shell:
        """
        cd scripts
        bash download-data.sh {datadir} {resultsdir} > {log}
        """