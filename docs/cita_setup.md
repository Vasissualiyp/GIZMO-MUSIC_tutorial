Return to the [Main README](../README.md)
# Setting up GIZMO+MUSIC on CITA non-starq machines and HPC clusters

### Things to do before you run GIZMO:

Before you do anything, load these modules:

```
module load intel intelmpi gsl/2.7.1-intel-19.1.3 hdf5/1.12.1-intel fftw/3.3.10-intelmpi
```

Set `SYSTYPE` in `Makefile.systype` to `CITA`.
You can get more tips from Fergus in `Makefile`, just search for
`CITA` string.

You're all set to [run GIZMO](gizmo_setup.md).

### Things to do before you run MUSIC:

```
module load gcc hdf5 gsl fftw
```

So you can just use the same modules as GIZMO, other than the compiler
(it requires gcc, not intel)

You're all set to [run MUSIC](music_setup.md).
