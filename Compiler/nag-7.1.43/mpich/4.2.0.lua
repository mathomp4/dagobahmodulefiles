-- [[
--
-- Extra options based on flags seen:
--
--   https://fortran-lang.discourse.group/t/nag-compiler-and-mpich-4-0/2967/12
--
-- This was built using:
--
-- $ mkdir build-nag-7.1.43 && cd build-nag-7.1.43
-- $ ../configure CC=clang CXX=clang++ FC=nagfor \
--     MPICHLIB_FFLAGS='-mismatch -fpp' MPICHLIB_FCFLAGS='-mismatch -fpp' --enable-f08 \
--     CFLAGS="-I$HOME/installed/Core/nag/7.1.43/lib/NAG_Fortran" \
--     --prefix=$HOME/installed/Compiler/nag-7.1.43/mpich/4.2.0 |& tee configure.nag-7.1.43.log
--
-- $ mv config.log config.nag-7.1.43.log
-- $ make -j4 |& tee make.nag-7.1.43.log
-- $ make install |& tee makeinstall.nag-7.1.43.log
-- $ make check |& tee makecheck.nag-7.1.43.log
--
-- ]]

family("MPI")
prereq("nag/7.1.43")

local compilername = "nag-7.1.43"

local version = "4.2.0"
local compiler = pathJoin("Compiler",compilername)
local homedir = os.getenv("HOME")
local installdir = pathJoin(homedir,"installed")
local pkgdir = pathJoin(installdir,compiler,"mpich",version)

-- Setup Modulepath for packages built by this MPI stack
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir = pathJoin(mroot,"MPI/nag-7.1.43",("mpich-"..version))
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

-- setenv("OMPI_MCA_btl_tcp_if_include","lo0")
setenv("OMPI_MCA_btl","^tcp")
