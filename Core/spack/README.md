# Using source_\sh

Note that for these modulefiles to work, you need at least Lmod 8.7.32 as that has a bug fix for
using `source_sh`.

## Modulefiles via sh_to_modulesfile

Before the bugfix above, modulefiles were made by using `sh_to_modulefile` from lmod which is located at:
```
$(brew --prefix)/opt/lmod/libexec/sh_to_modulefile
```

You then run, say:
```
sh_to_modulefile /path/to/spack/share/spack/setup-env.sh > module.lua
```
