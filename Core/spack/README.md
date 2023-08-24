# How to make these modulefiles

These modulefiles were made by using `sh_to_modulefile` from lmod which is located at:
```
$(brew --prefix)/opt/lmod/libexec/sh_to_modulefile
```

You then run, say:
```
sh_to_modulefile /path/to/spack/share/spack/setup-env.sh > module.lua
```

## Using source\_sh

I had tried to use `source_sh` by doing:

```lua
-- -*- lua -*-
  
local homedir = os.getenv("HOME")
local spackdir = "spack"
local spackroot = pathJoin(homedir, spackdir)
setenv("SPACK_ROOT", spackroot)
source_sh("zsh", pathJoin(spackroot, "share/spack/setup-env.sh"))
```

but this doesn't seem to work for me. See https://sourceforge.net/p/lmod/mailman/message/37884610/
