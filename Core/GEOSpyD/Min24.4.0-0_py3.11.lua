--[[ File for GEOSpyD

Installed using the GEOSpyD installer script on github:

  git@github.com:GMAO-SI-Team/GEOSpyD.git

and I ran

  ./install_miniconda.bash --python_version 3.11 --miniconda_version 24.4.0-0 --prefix /Users/mathomp4/installed/Core/GEOSpyD |& tee install.24.4.0-0_py3.11.log

NOTE: You'll need to set the date below!
--]]

family("Python3")

local homedir = os.getenv("HOME")
local installdir = pathJoin(homedir,"installed/Core/GEOSpyD")

local miniconda_version = "24.4.0-0"
local python_version = "3.11"
local geospyd_version = miniconda_version .. "_py" .. python_version
local builddate = "2024-07-22"

local pathdir = pathJoin(geospyd_version,builddate)
local pkgdir = pathJoin(installdir,pathdir)

-- Setup Modulepath for packages built by this compiler
local mroot = os.getenv("MODULEPATH_ROOT")
local mdir  = pathJoin(mroot,"GEOSpyD",geospyd_version)
prepend_path("MODULEPATH", mdir)

unsetenv("ESMA_F2PY")

prepend_path("PATH",pathJoin(pkgdir,"bin"))
prepend_path("PROJ_LIB",pathJoin(pkgdir,"share/proj"))
prepend_path("MANPATH",pathJoin(pkgdir,"share/man"))
