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