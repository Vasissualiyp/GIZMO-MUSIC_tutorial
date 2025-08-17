Return to the [Main README](../README.md)
# Setting up GIZMO+MUSIC on SciNet Trillium cluster

### Things to do before you run GIZMO:

Before you do anything, load these modules:

```
module load StdEnv/2023 gcc/12.3 openmpi/4.1.5 fftw-mpi/3.3.10 gsl/2.7 hdf5/1.14.2
```

First, take the `Makefile` Trillium instructions from `templates` directory of this tutorial.
Then, in GIZMO Makefile, search for "CITA". And insert the whole block before
`ifeq ($(SYSTYPE),"CITA")` statement (Or after its corresponding endif, you just have to
make sure that Trillium is not a part of any other machine instructions).

Set `SYSTYPE` in `Makefile.systype` to `Trillium`.
You can get more tips from Vasilii in `Makefile`, in the segment that you just pasted.

You're all set to [run GIZMO](gizmo_setup.md).

### Things to do before you run MUSIC:

```
module load StdEnv/2023 gcc/12.3 openmpi/4.1.5 fftw-mpi/3.3.10 gsl/2.7 hdf5/1.14.2
```

So you can just use the same modules as GIZMO.

Similar to GIZMO, you should include compilation steps in your submission script.

You're all set to [run MUSIC](music_setup.md).
