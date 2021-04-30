#!/bin/bash

source /etc/bashrc
export PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin"

BUILD_DIR="/users/khansen/build/build_R_jhpce"
SGE_FLAGS="-clear -V -cwd -S /bin/bash -j yes -l h_stack=256M -l h_vmem=7G -l mf=7G -m n -M kasperdanielhansen@gmail.com"

exec >/dev/null 2>&1

module load sge

cd ${BUILD_DIR}

## For building R-devel
qsub ${SGE_FLAGS} -N cr.bld.devel -o ${BUILD_DIR}/cron_out ${BUILD_DIR}/build.conda.svnR-devel.sh
qsub ${SGE_FLAGS} -N cr.upd.devel -o ${BUILD_DIR}/cron_out -hold_jid cr.bld.devel ${BUILD_DIR}/update.R-devel.sh

## For updatingx
# qsub ${SGE_FLAGS} -N cr.bld.40x -o ${BUILD_DIR}/cron_out ${BUILD_DIR}/build.conda.svnR-4.0.x.sh
qsub ${SGE_FLAGS} -N cr.upd.40x -o ${BUILD_DIR}/cron_out -hold_jid cr.bld.40x ${BUILD_DIR}/update.R-4.0.x.sh

