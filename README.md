# rhds

Learning how to do version control with git

To recreate environment:

git clone <github URL>
cd rhds
mamba env create -f environment.yml
mamba activate rhds
Rscript install.r

To setup config file:
Use config-template.env to create a config.env file. 
Setup file paths to data, results and docs directories

Use: 
source config.env
To initialise this

Run scripts in following order: 
1_extract_data.r    
2_clean_clinical.r  
3_predict_proteins.r  
4_combine.r 
5_analysis.r  

using Rscript <script_name>.r ${datadir} ${resultsdir}


I have also rendered this as a quarto document, doesnt seem to work when rendering it to docs tho...


To run the apptainer:

source scripts/config.env
mkdir -p ${datadir} ${resultsdir} ${docsdir}
apptainer run \
    --fakeroot \
    -B $(pwd) \
    -B ${datadir} -B ${resultsdir} -B ${docsdir} \
    rhds-tcga-r.sif \
    quarto render scripts/analysis.qmd --output-dir ${docsdir}


What is this doing:

We're telling apptainer to run the quarto script using the software within the rhds-tcga-r.sif container.
Thus, all software packages used are those installed in the container.
The only things accessed outside the container are the scripts because they are in the present working directory (-B $(pwd)) and any files in the data, results or docs directories (-B ${datadir} -B ${resultsdir} -B ${docsdir}).
The --fakeroot argument tells apptainer to run as root within the container.

If this command was successful, you should see an updated report analysis.html in ${docsdir}. Check the modification date/time like this:

ls -l ${docsdir}/analysis.html

Snakemake pipeline:

source scripts/config.env
mkdir -p ${docsdir} ${resultsdir} ${datadir}
snakemake \
    --cores 1 \
    --use-apptainer \
    --apptainer-args "--fakeroot -B ${datadir} -B ${resultsdir} -B ${docsdir} -B $(pwd)"