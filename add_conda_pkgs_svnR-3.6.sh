#!/bin/bash
set -e

CONDA_VERSION=3-4.6.14
R_NAME=svnR-3.6
module load conda/${CONDA_VERSION}

source activate /jhpce/shared/jhpce/core/conda/miniconda${CONDA_VERSION}/envs/${R_NAME}

## Installing X11 from conda-forge
conda install -c conda-forge \
  xorg-kbproto\
  xorg-libice\
  xorg-libsm\
  xorg-libx11\
  xorg-libxau\
  xorg-libxext\
  xorg-libxrender\
  xorg-libxt\
  xorg-renderproto\
  xorg-xextproto\
  xorg-xproto

## Installing texlive
## This requires the presence of `install-tl-20190904/install-tl`
## which is the "standard" texlive installation script
install-tl-20190904/install-tl --profile conda_${R_NAME}_texlive.profile
export PATH=/jhpce/shared/jhpce/core/conda/miniconda${CONDA_VERSION}/envs/${R_NAME}/texlive/bin/x86_64-linux:${PATH}
texhash
tlmgr paper letter
fmtutil-sys --all
tlmgr install inconsolata
