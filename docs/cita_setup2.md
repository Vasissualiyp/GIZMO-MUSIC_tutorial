Return to the [Main README](../README.md)
# Setting up GIZMO+MUSIC on CITA machines

### Things to do before you run GIZMO:

Before you do anything, load these modules:

```
module load gcc/13.2.0 openmpi/4.1.6-gcc gsl/2.7.1 hdf5/1.12.1 fftw/3.3.10-openmpi
```

First, take the `Makefile` CITA-new instructions from `templates` directory of this tutorial.
Then, in GIZMO Makefile, search for "CITA". And insert the whole block before
`ifeq ($(SYSTYPE),"CITA")` statement (Or after its corresponding endif, you just have to
make sure that CITA-new is not a part of any other machine instructions).

Set `SYSTYPE` in `Makefile.systype` to `CITA-new`.
You can get more tips from Vasilii in `Makefile`, in the segment that you just pasted.

You're all set to [run GIZMO](gizmo_setup.md).

### Things to do before you run MUSIC:

```
module load gcc/13.2.0 gsl/2.7.1 hdf5/1.12.1 fftw/3.3.10-openmpi
```

So you can just use the same modules as GIZMO.

Similar to GIZMO, you should include compilation steps in your submission script.

You're all set to [run MUSIC](music_setup.md).
