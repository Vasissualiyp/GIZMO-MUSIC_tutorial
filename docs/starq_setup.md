Return to the [Main README](../README.md)
# Setting up GIZMO+MUSIC on CITA starq machines

### Things to do before you run GIZMO:

Before you do anything, load these modules:

```
module load gcc/13.2.0 openmpi/4.1.6-gcc-ucx gsl/2.7.1 hdf5/1.12.1-ucx fftw/3.3.10-openmpi-ucx
```

First, take the `Makefile` CITA-starq instructions from `templates` directory of this tutorial.
Then, in GIZMO Makefile, search for "CITA". And insert the whole block before
`ifeq ($(SYSTYPE),"CITA")` statement (Or after its corresponding endif, you just have to
make sure that CITA-starq is not a part of any other machine instructions).

Set `SYSTYPE` in `Makefile.systype` to `CITA-starq`.
You can get more tips from Vasilii in `Makefile`, in the segment that you just pasted.

One important thing is that as of November 2024, you cannot compile starq-related
code on non-starq machines (I believe the reason behind this is in other machines
using Intel processors, while the starq is AMD-based). So you must include compilation
steps in your submission scripts.

You're all set to [run GIZMO](gizmo_setup.md).

### Things to do before you run MUSIC:

```
Under construction...
```

You're all set to [run MUSIC](music_setup.md).
