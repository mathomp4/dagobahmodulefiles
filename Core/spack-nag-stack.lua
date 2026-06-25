-- spack-stack meta-module: loads stack-nag, stack-openmpi, geos-gcm-env
-- equivalent to:
--   module use ~/spack-stack/spack-stack-dev/envs/ge-nag-7.2.7243/modules/Core
--   ml stack-nag stack-openmpi geos-gcm-env

family("stack")

local spack_root = "/Users/mathomp4/spack-stack/spack-stack-dev/envs/ge-nag-7.2.7243/modules"

-- Level 1: Core (exposes stack-nag)
prepend_path("MODULEPATH", pathJoin(spack_root, "Core"))

-- Level 2: stack-nag prepends these (exposes stack-openmpi)
prepend_path("MODULEPATH", pathJoin(spack_root, "nag/7.2.7243"))
prepend_path("MODULEPATH", pathJoin(spack_root, "apple-clang/21.0.0"))

-- Level 3: stack-openmpi prepends these (exposes geos-gcm-env)
prepend_path("MODULEPATH", pathJoin(spack_root, "openmpi/5.0.7/nag/7.2.7243"))
prepend_path("MODULEPATH", pathJoin(spack_root, "openmpi/5.0.7/apple-clang/21.0.0"))

-- Load the three spack-stack modules
load("stack-nag/7.2.7243")
load("stack-openmpi/5.0.7")
load("geos-gcm-env/11.10.0-debug")
