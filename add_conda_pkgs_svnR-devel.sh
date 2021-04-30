#!/bin/bash
set -e

CONDA_VERSION=3-4.6.14
R_NAME=svnR-devel
module load conda/${CONDA_VERSION}

source activate /jhpce/shared/jhpce/core/conda/miniconda${CONDA_VERSION}/envs/${R_NAME}

## Installing texlive
## This requires the presence of `install-tl-DATE/install-tl`
## which is the "standard" texlive installation script
install-tl-20200417/install-tl --profile conda_${R_NAME}_texlive.profile
export PATH=/jhpce/shared/jhpce/core/conda/miniconda${CONDA_VERSION}/envs/${R_NAME}/texlive/bin/x86_64-linux:${PATH}
texhash
tlmgr paper letter
fmtutil-sys --all
tlmgr install inconsolata
