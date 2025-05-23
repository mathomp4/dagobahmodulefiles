-- stub routine for LLVM clang + flang-new from brew
--
-- install flang-new from brew:
--   brew install flang-new
--
-- NOTE: We are using LLVM clang and flang-new from brew and not Apple clang

family("Compiler")

local version = "19"
local homedir = os.getenv("HOME")
local homebrewdir = os.getenv("BREWPATH")
local brewllvmdir = pathJoin(homebrewdir,"opt/llvm")
local cbindir = pathJoin(brewllvmdir,"bin")
local fbindir = pathJoin(homebrewdir,"bin")

-- Setup Modulepath for packages built by this compiler
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir  = pathJoin(mroot,"Compiler/llvmclang-flang-19")
prepend_path("MODULEPATH", mdir)

setenv("CC",pathJoin(cbindir,"clang"))
setenv("CXX",pathJoin(cbindir,"clang++"))
setenv("FC",pathJoin(fbindir,"flang-new"))
setenv("F90",pathJoin(fbindir,"flang-new"))

prepend_path("PATH",cbindir)
prepend_path("LDFLAGS","-L"..pathJoin(brewllvmdir,"lib"))
prepend_path("CPPFLAGS","-I"..pathJoin(brewllvmdir,"include"))

-- per scivision, set OpenMP_ROOT for clang: https://gist.github.com/scivision/16c2ca1dc250f54d34f1a1a35596f4a0
setenv("OpenMP_ROOT",pathJoin(homebrewdir,"opt/libomp"))
