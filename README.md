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