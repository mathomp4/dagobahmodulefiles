-- spack-stack meta-module: loads stack-gcc, stack-openmpi, geos-gcm-env
-- equivalent to:
--   module use ~/spack-stack/spack-stack-dev/envs/ge-gcc-15.2.0/modules/Core
--   ml stack-gcc stack-openmpi geos-gcm-env

family("stack")

local spack_root = "/Users/mathomp4/spack-stack/spack-stack-dev/envs/ge-gcc-15.2.0/modules"

-- Level 1: Core (exposes stack-gcc)
prepend_path("MODULEPATH", pathJoin(spack_root, "Core"))

-- Level 2: stack-gcc prepends these (exposes stack-openmpi)
prepend_path("MODULEPATH", pathJoin(spack_root, "gcc/15.2.0"))
prepend_path("MODULEPATH", pathJoin(spack_root, "apple-clang/21.0.0"))

-- Level 3: stack-openmpi prepends these (exposes geos-gcm-env)
prepend_path("MODULEPATH", pathJoin(spack_root, "openmpi/5.0.10/gcc/15.2.0"))
prepend_path("MODULEPATH", pathJoin(spack_root, "openmpi/5.0.10/apple-clang/21.0.0"))

-- Load the three spack-stack modules
load("stack-gcc/15.2.0")
load("stack-openmpi/5.0.10")
load("geos-gcm-env/11.10.0-debug")
