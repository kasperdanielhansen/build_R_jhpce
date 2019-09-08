#!/bin/bash
set -e

CONDA_VERSION=3-4.6.14
R_NAME=svnR-3.6

module load conda/${CONDA_VERSION}
conda env create --prefix /jhpce/shared/jhpce/core/conda/miniconda${CONDA_VERSION}/envs/${R_NAME} -f conda_${R_NAME}.yml

## The following packages gets grabbed from conda-forge
## conda install -c conda-forge -f conda_${R_NAME}_pkglist.txt
## We now install texlive, since texlive from conda is broken
