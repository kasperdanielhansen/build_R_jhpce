#!/bin/bash
#$ -V -j yes -S /bin/bash
#$ -m n -M kasperdanielhansen@gmail.com

set -e

R_VERSION=3.6.x
SVNLOC=https://svn.r-project.org/R/branches/R-3-6-branch

## module load conda_R/${R_VERSION}
module load conda_R/${R_VERSION}
module load conda
CONDA_PREFIX=`conda info --json | grep default_prefix | sed 's|  "default_prefix": "||' | sed 's|",$||'`
export PATH=${CONDA_PREFIX}/texlive/bin/x86_64-linux:${PATH} # Required in case custom texlive is not at the root of the PATH

SRCDIR=R-${R_VERSION}-src
BUILDDIR=R-${R_VERSION}-build

if [ ! -d ${SRCDIR} ]; then
    svn co ${SVNLOC}  ${SRCDIR}
fi
cd ${SRCDIR}
svn up || exit 1
tools/rsync-recommended || exit 1
tools/link-recommended || exit 1
cd ..
rm -rf ${BUILDDIR}
mkdir ${BUILDDIR}
cd ${BUILDDIR}
export LANG=en_US.UTF-8
export TZ="US/Eastern"
../${SRCDIR}/configure SHELL='/bin/bash' \
   --prefix="${CONDA_PREFIX}/R/${R_VERSION}" \
   CC="x86_64-conda_cos6-linux-gnu-gcc" \
   CXX="x86_64-conda_cos6-linux-gnu-g++" \
   F77="x86_64-conda_cos6-linux-gnu-gfortran" \
   FC="$F77" \
   CFLAGS="-Wall -mtune=amdfam10 -g -O2 -I${CONDA_PREFIX}/include"\
   CXXFLAGS="-Wall -mtune=amdfam10 -g -O2 -I${CONDA_PREFIX}/include" \
   F77FLAGS="-Wall -g -O2 -mtune=amdfam10 -I${CONDA_PREFIX}/include" \
   FCFLAGS="$F77FLAGS" \
   LDFLAGS="-L${CONDA_PREFIX}/lib -Wl,-rpath-link=${CONDA_PREFIX}/lib" \
   --enable-R-shlib\
   --enable-memory-profiling | tee ../configure-${R_VERSION}
make
make check
make install
