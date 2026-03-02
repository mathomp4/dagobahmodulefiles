-- stub routine for Apple clang + flang from brew
--
-- install flang from brew:
--   brew install flang
--
-- NOTE: We are using Apple Clang not LLVM Clang from brew

family("Compiler")

local version = "21"
local homedir = os.getenv("HOME")
local homebrewdir = os.getenv("BREWPATH")
local cbindir = pathJoin("/usr/bin")
local fbindir = pathJoin(homebrewdir,"bin")

-- Setup Modulepath for packages built by this compiler
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir  = pathJoin(mroot,"Compiler/appleclang-flang-21")
prepend_path("MODULEPATH", mdir)

setenv("CC",pathJoin(cbindir,"clang"))
setenv("CXX",pathJoin(cbindir,"clang++"))
setenv("FC",pathJoin(fbindir,"flang"))
setenv("F90",pathJoin(fbindir,"flang"))

-- This was apparently needed in the past, but at the moment, doesn't
-- seem to be necessary. Keeping it commented out for now.
setenv("LDFLAGS","-lc++")

-- per scivision, set OpenMP_ROOT for clang: https://gist.github.com/scivision/16c2ca1dc250f54d34f1a1a35596f4a0
setenv("OpenMP_ROOT",pathJoin(homebrewdir,"opt/libomp"))
