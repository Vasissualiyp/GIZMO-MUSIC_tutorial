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

If you are using the new C++ code from [github.com/pfhopkins/gizmo](https://github.com/pfhopkins/gizmo)
(see [GIZMO setup](gizmo_setup.md#git-clone-gizmo-repo)), also add `CXX = mpicxx` to that block, right below
the `CC = mpicc` line. The template in `templates` was written for the older C code and does not have it yet.

Set `SYSTYPE` to `Trillium`. The easiest way is to do it once for good, by creating `~/.gizmo` on Trillium:
```
echo 'SYSTYPE="Trillium"' > ~/.gizmo
```
Alternatively, set it in `Makefile.systype` as before (see [here](gizmo_setup.md#makefilesystype) for details).
You can get more tips from Vasilii in `Makefile`, in the segment that you just pasted.

*Old code only:* if you are still on the archived Bitbucket `master` branch (August 12th, 2025 version)
and the code fails to compile, fix the imbalanced brackets by adding 2 brackets in line 861 in file 
`galaxy_sf/blackholes/blackhole_swallow_and_kick.c`. The new GitHub code doesn't have this problem
(the file is now `sinks/sink_swallow_and_kick.cc`).

You're all set to [run GIZMO](gizmo_setup.md).

### Things to do before you run MUSIC:

```
module load StdEnv/2023 gcc/12.3 openmpi/4.1.5 fftw-mpi/3.3.10 gsl/2.7 hdf5/1.14.2
```

So you can just use the same modules as GIZMO.

Similar to GIZMO, you should include compilation steps in your submission script.

You're all set to [run MUSIC](music_setup.md).
