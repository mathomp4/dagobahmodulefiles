--[[

This was built using:

wget https://www.mpich.org/static/downloads/4.3.2/mpich-4.3.2.tar.gz
tar -xf mpich-4.3.2.tar.gz
cd mpich-4.3.2

ml clang-gfortran/15

mkdir build-clang-gfortran-15 && cd build-clang-gfortran-15

../configure --disable-wrapper-rpath --disable-wrapper-runpath \
  CC=clang CXX=clang++ FC=gfortran-15 \
  --prefix=$HOME/installed/Compiler/clang-gfortran-15/mpich/4.3.2 |& tee configure.clang-gfortran-15.log

mv config.log config.clang-gfortran-15.log
make -j6 |& tee make.clang-gfortran-15.log
make install |& tee makeinstall.clang-gfortran-15.log
make check |& tee makecheck.clang-gfortran-15.log

--]]

family("MPI")
prereq("clang-gfortran/15")

local compilername = "clang-gfortran-15"

local version = "4.3.2"
local compiler = pathJoin("Compiler",compilername)
local homedir = os.getenv("HOME")
local installdir = pathJoin(homedir,"installed")
local pkgdir = pathJoin(installdir,compiler,"mpich",version)

-- Setup Modulepath for packages built by this MPI stack
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir = pathJoin(mroot,"MPI/clang-gfortran-15",("mpich-"..version))
prepend_path("MODULEPATH", mdir)

setenv("MPICH",pkgdir)
setenv("MPIHOME",pkgdir)
setenv("MPI_HOME",pkgdir)

prepend_path("PATH",pathJoin(pkgdir,"bin"))
prepend_path("LD_LIBRARY_PATH",pathJoin(pkgdir,"lib"))
prepend_path("DYLD_LIBRARY_PATH",pathJoin(pkgdir,"lib"))
prepend_path("LIBRARY_PATH",pathJoin(pkgdir,"lib"))
prepend_path("INCLUDE",pathJoin(pkgdir,"include"))
prepend_path("MANPATH",pathJoin(pkgdir,"share/man"))

