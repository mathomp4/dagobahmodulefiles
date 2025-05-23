--[[
stub routine for nag 7.2.28

To install NAG, you mount the DMG and then cd to it in /Volumes
Then run INSTALL.sh and put in *absolute* paths:

$HOME/installed/Core/nag/7.2.28/bin

NOTE 1

Until NAG fixes something on their end, you need to run a command
if nagfor is installed in userspace (i.e., you can't change
/usr/local/lib)

You must run:

install_name_tool -id $HOME/installed/Core/nag/7.2.28/lib/NAG_Fortran/libf72rts.dylib $HOME/installed/Core/nag/7.2.28/lib/NAG_Fortran/libf72rts.dylib

I cannot figure out yet how to make this more generic. I'd think
@executable_path should work, but I guess not? Maybe something with
@rpath?

NOTE 2

Before, I had go into Finder and run:

$HOME/installed/Core/nag/7.2.28/lib/NAG_Fortran/nagfor

for permissions issues before I could build anything with it. 
But now it looks like you need admin rights. But once you do that
and cancel then ...

NOTE 3

you seem to be able to just run in Terminal:

$HOME/installed/Core/nag/7.2.28/bin/nagfor

NOTE 4

Well on macOS 15, I now seem to need to go to:

Settings --> Privacy & Security --> Scroll down to Security

Click "Open Anyway' and then try opening in Finder. And *then*
you need Admin rights. 

--]]

family("Compiler")

local nag_version = "7.2.28"
local nag_version_with_name = "nag-" .. nag_version

local homedir = os.getenv("HOME")
local nag_pkgdir = pathJoin(homedir,"installed/Core/nag",nag_version)
local nag_bindir = pathJoin(nag_pkgdir,"bin")
local nag_libdir = pathJoin(nag_pkgdir,"lib/NAG_Fortran")
local nag_mandir = pathJoin(nag_pkgdir,"man")

-- Setup Modulepath for packages built by this compiler
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir  = pathJoin(mroot,"Compiler",nag_version_with_name)
prepend_path("MODULEPATH", mdir)

setenv("CC","clang")
setenv("CXX","clang++")
setenv("FC",pathJoin(nag_bindir,"nagfor"))
setenv("F90",pathJoin(nag_bindir,"nagfor"))
setenv("ESMA_FC","nagfor")

prepend_path("PATH",nag_bindir)
prepend_path("DYLD_LIBRARY_PATH",nag_libdir)
prepend_path("LD_LIBRARY_PATH",nag_libdir)
prepend_path("LIBRARY_PATH",nag_libdir)
--prepend_path("INCLUDE",nag_incdir)
prepend_path("MANPATH",nag_mandir)

setenv("NAG_KUSARI_FILE",pathJoin(homedir,"nag.key"))

-- Set MACOSX_DEPLOYMENT_TARGET here as it has issues with Intel, but
-- you can't just have a pushenv to a blank (as it breaks CMake)
-- NOTE: This might not be needed anymore. TEST THIS MATT!
local sw_vers = subprocess("sw_vers -productVersion"):gsub("\n$","")
pushenv("MACOSX_DEPLOYMENT_TARGET",sw_vers)

-- per scivision, set OpenMP_ROOT for clang: https://gist.github.com/scivision/16c2ca1dc250f54d34f1a1a35596f4a0
local homebrewdir = os.getenv("BREWPATH")
setenv("OpenMP_ROOT",pathJoin(homebrewdir,"opt/libomp"))
