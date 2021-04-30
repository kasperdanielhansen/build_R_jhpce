#!/bin/bash
#$ -V -j yes -cwd -S /bin/bash

module load conda_R/4.0.x
Rscript --no-init-file -e 'base::hopkins$update()'
Rscript --no-init-file -e 'source("removelock.R")'
# R CMD javareconf
