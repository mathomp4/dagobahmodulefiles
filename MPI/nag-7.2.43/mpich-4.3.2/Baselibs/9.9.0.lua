--[[

This was cloned with:

git clone -j 4 --recurse-submodules -b v9.9.0 https://github.com/GEOS-ESM/ESMA-Baselibs.git ESMA-Baselibs-9.9.0/src

This was built using:

ml nag/7.2.43 mpich/4.3.2

make -j6 install ESMF_COMM=mpich ESMF_COMPILER=nag prefix=$HOME/installed/MPI/nag-7.2.43/mpich-4.3.2/Baselibs/9.9.0/Darwin |& tee makeinstall.nag-7.2.43_mpich-4.3.2.log

NOTE: To build curl on Parcel, I had to do:

brew install automake autoconf libtool

then I had to make symlinks so that it could find these:

ln -s $(brew --prefix)/bin/automake $HOME/bin/automake
ln -s $(brew --prefix)/bin/aclocal $HOME/bin/aclocal
ln -s $(brew --prefix)/bin/glibtool $HOME/bin/libtool

NOTE THE LAST ONE! Brew installs glibtool, so as not to collide with clang libtool

Also: To build udunits2 (and then nco and cdo) you need to install the texinfo package

brew install texinfo

as udunits2 needs makeinfo.

--]]

family("Baselibs")
prereq("nag/7.2.43", "mpich/4.3.2")

local compilername = "nag-7.2.43"
local mpiname = "mpich-4.3.2"

local version = myModuleVersion()
local pathdir = pathJoin("MPI",compilername,mpiname)
local homedir = os.getenv("HOME")
local installdir = pathJoin(homedir,"installed")
local pkgdir = pathJoin(installdir,pathdir,"Baselibs",version)

-- Setup Modulepath for packages built by this MPI stack
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir = pathJoin(mroot,"Baselibs",compilername,mpiname)
prepend_path("MODULEPATH", mdir)

setenv("BASEDIR",pkgdir)
setenv("basedir",pkgdir)
setenv("BASEBIN",pathJoin(pkgdir,"Darwin/bin"))

prepend_path("PATH",pathJoin(pkgdir,"Darwin/bin"))
prepend_path("LD_LIBRARY_PATH",pathJoin(pkgdir,"Darwin/lib"))
prepend_path("DYLD_LIBRARY_PATH",pathJoin(pkgdir,"Darwin/lib"))
prepend_path("MANPATH",pathJoin(pkgdir,"Darwin/share/man"))

setenv("UDUNITS2_XML_PATH",pathJoin(pkgdir,"Darwin/share/udunits/udunits2.xml"))
