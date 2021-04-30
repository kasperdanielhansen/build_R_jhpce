#!/bin/bash
set -e -u
cp Rprofile.site /jhpce/shared/jhpce/core/conda/miniconda3-4.6.14/envs/svnR-4.0/R/4.0/lib64/R/etc
cp Rprofile.site /jhpce/shared/jhpce/core/conda/miniconda3-4.6.14/envs/svnR-4.0.x/R/4.0.x/lib64/R/etc
cp Rprofile.site /jhpce/shared/jhpce/core/conda/miniconda3-4.6.14/envs/svnR-devel/R/devel/lib64/R/etc
