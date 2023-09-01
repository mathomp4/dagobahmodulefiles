-- stub routine for gcc-13 + gfortran-13 from brew  
--
-- install gcc-13 via:
--   brew install gcc@13
-- 

family("Compiler")

local version = "13"
local homedir = os.getenv("HOME")
local homebrewdir = pathJoin(homedir,".homebrew/brew")
local bindir = pathJoin(homebrewdir,"bin")

-- Setup Modulepath for packages built by this compiler
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir  = pathJoin(mroot,"Compiler/gcc-gfortran-13")
prepend_path("MODULEPATH", mdir)

setenv("CC",pathJoin(bindir,"gcc-13"))
setenv("CXX",pathJoin(bindir,"g++-13"))
setenv("FC",pathJoin(bindir,"gfortran-13"))
setenv("F90",pathJoin(bindir,"gfortran-13"))
