-- stub routine for clang + gfortran-12 from fxcoudert  
--
-- install gfortran-12 via Self Service which uses
--
-- https://github.com/fxcoudert/gfortran-for-macOS/releases
--
-- NOTE: Still needs libomp from brew
--   

family("Compiler")

local version = "12.2-from-dmg"
local homedir = os.getenv("HOME")
local homebrewdir = pathJoin(homedir,".homebrew/brew")
local cbindir = pathJoin("/usr/bin")
local fbindir = "/usr/local/bin"

-- Setup Modulepath for packages built by this compiler
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir  = pathJoin(mroot,"Compiler/clang-gfortran-12.2-from-dmg")
prepend_path("MODULEPATH", mdir)

-- This makes it so that 'which gfortran' returns the path to this compiler
-- Just makes it safer as brew has its own gfortran (which is gfortran-13)
prepend_path("PATH",fbindir)

setenv("CC",pathJoin(cbindir,"clang"))
setenv("CXX",pathJoin(cbindir,"clang++"))
setenv("FC",pathJoin(fbindir,"gfortran"))
setenv("F90",pathJoin(fbindir,"gfortran"))

-- per scivision, set OpenMP_ROOT for clang: https://gist.github.com/scivision/16c2ca1dc250f54d34f1a1a35596f4a0
setenv("OpenMP_ROOT",pathJoin(homebrewdir,"opt/libomp"))
