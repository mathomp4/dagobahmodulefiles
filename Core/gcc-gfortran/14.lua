-- stub routine for gcc-14 + gfortran-14 from brew
--
-- install gcc-14 via:
--   brew install gcc@14
--

family("Compiler")

local version = "14"
local homedir = os.getenv("HOME")
local homebrewdir = pathJoin(homedir,".homebrew/brew")
local bindir = pathJoin(homebrewdir,"bin")

-- Setup Modulepath for packages built by this compiler
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir  = pathJoin(mroot,"Compiler/gcc-gfortran-14")
prepend_path("MODULEPATH", mdir)

setenv("CC",pathJoin(bindir,"gcc-14"))
setenv("CXX",pathJoin(bindir,"g++-14"))
setenv("FC",pathJoin(bindir,"gfortran-14"))
setenv("F90",pathJoin(bindir,"gfortran-14"))

-- Bug fix for XCode 16
setenv("SDKROOT","/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk")
