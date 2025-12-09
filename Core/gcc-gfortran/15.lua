-- stub routine for gcc-15 + gfortran-15 from brew
--
-- install gcc-15 via:
--   brew install gcc@15
--

family("Compiler")

local version = "15"
local homedir = os.getenv("HOME")
local homebrewdir = os.getenv("BREWPATH")
local bindir = pathJoin(homebrewdir,"bin")

-- Setup Modulepath for packages built by this compiler
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir  = pathJoin(mroot,"Compiler/gcc-gfortran-15")
prepend_path("MODULEPATH", mdir)

setenv("CC",pathJoin(bindir,"gcc-15"))
setenv("CXX",pathJoin(bindir,"g++-15"))
setenv("FC",pathJoin(bindir,"gfortran-15"))
setenv("F90",pathJoin(bindir,"gfortran-15"))

-- Bug fix for XCode 16
setenv("SDKROOT","/Library/Developer/CommandLineTools/SDKs/MacOSX26.sdk")
