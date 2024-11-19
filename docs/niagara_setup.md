Return to the [Main README](../README.md)
# Setting up GIZMO+MUSIC on SciNet Niagara Cluster

### Things to do before you run GIZMO:

Before you do anything, load these modules:


```
module load intel intelmpi gsl hdf5 fftw
```

Set `SYSTYPE` in `Makefile.systype` to `SciNet`.
You can get more tips from Fergus in `Makefile`, just search for
`SciNet` string.

You're all set to [run GIZMO](gizmo_setup.md).

### Things to do before you run MUSIC:

```
module load gcc hdf5 gsl fftw
```

So you can just use the same modules as GIZMO, other than the compiler
(it requires gcc, not intel)

You're all set to [run MUSIC](music_setup.md).
