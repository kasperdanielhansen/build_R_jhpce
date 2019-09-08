#!/bin/bash
set -e

CONDA_VERSION=3-4.6.14
R_NAME=svnR-3.6.x
module load conda/${CONDA_VERSION}

source activate /jhpce/shared/jhpce/core/conda/miniconda${CONDA_VERSION}/envs/${R_NAME}
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

texlive/install-tl-20190904/install-tl --profile conda_${R_NAME}_texlive.profile
