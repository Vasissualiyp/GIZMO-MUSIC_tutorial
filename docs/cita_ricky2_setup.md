Return to the [Main README](../README.md)
# Setting up GIZMO on the CITA ricky2 cluster

ricky2 is the submission node for a **separate** cluster from the older CITA machines
(ricky / starq / calamari). It has its own PBS server, OS and software stack, so the
[CITA](cita_setup2.md) instructions do **not** apply here.

| | ricky2 cluster |
|---|---|
| Login / submission node | `ricky2.cita.utoronto.ca` |
| Scheduler | PBS Pro 23 (server `bob2`): `qsub`, `qstat`, `qdel` |
| OS | Rocky Linux 9 |
| Compute nodes | `tpb2xx`: 2x Intel Xeon Gold 6148, **80 cores**, ~189 GB RAM |
| Queues | `earthq`, `marsq`, `mercuryq`, `neptuneq`, `saturnq`, `uranusq` (max 48 h), `jupiterq` (max 96 h) |
| Scratch | `/fs/lustre/scratch2/<user>` |

The login node has the same CPU as the compute nodes, so building with `-march=native` on ricky2
gives a binary that runs on the compute nodes.

### Things to do before you run GIZMO:

Use the OpenHPC toolchain (GCC 14 + Open MPI 5). `gnu14` and `openmpi5` are loaded by default,
but load them explicitly anyway (also in your submission scripts):

```
module load gnu14 openmpi5 hdf5 fftw gsl
```

This gives gcc 14.2, Open MPI 5.0.7 (with UCX and PBS support), HDF5 1.14.6, FFTW 3.3.10 and GSL 2.8.
The `/cita/modules` stack (`gcc/13.2.0`, `openmpi/4.1.x-ucx`, ...) is also visible on ricky2,
but it was built for the older CITA OS. Don't mix the two.

Take the `Makefile` CITA-ricky2 block from the `templates` directory of this tutorial
([`CITA-ricky2Makefile.txt`](../templates/Makefile_systems/CITA-ricky2Makefile.txt)).
In the GIZMO `Makefile`, search for the first `ifeq ($(SYSTYPE),` block and paste the
whole CITA-ricky2 block before it (it just has to be outside any other machine's block).
The block reads the library paths from the variables the OpenHPC modules set
(`GSL_INC`/`GSL_LIB`, `FFTW_INC`/`FFTW_LIB`, `HDF5_INC`/`HDF5_LIB`), so the modules
**must be loaded when you run `make`**.

Set `SYSTYPE` in `Makefile.systype` to `CITA-ricky2`. Make sure it is the only
uncommented `SYSTYPE=` line: make uses the *last* one it reads. On the `starforge_dev`
branch, for example, `SYSTYPE="RUSTY"` is uncommented by default.

Then compile as usual (`make -j8`), see [GIZMO setup](gizmo_setup.md).
Tested on the `starforge_dev` branch (October 2026): the tutorial `Config.sh` builds cleanly,
GIZMO starts under MPI on 1 and 2 compute nodes, and the GIZMO test suite (`pytest`, see
`test/how_to_run_tests.md` in the GIZMO repo) builds and runs its tests on a compute node.

### Things to watch out for

* **Ask for at most 80 cores per node.** A `select=1:ncpus=128` job (the starq/ricky value) will
  never start here.
* **Don't run `mpirun` on the ricky2 login node.** Its locked-memory limit (`ulimit -l` = 8 MB)
  makes UCX fail with `Failed to allocate memory pool ... Failed to create UCP worker`.
  The compute nodes are fine (unlimited). For a quick test, submit a small job instead.
* Output from `-o`/`-j oe` is copied back only when the job ends. Redirect the GIZMO
  output to a file yourself (as in the template) to follow the run live.
* **Python on ricky2** (for analysis or the GIZMO test suite): use the miniconda builds,
  e.g. `/cita/modules/miniconda/python-3.13.13/bin/python3 -m venv myenv`. They ship their
  own OpenSSL. Don't use these:
  * `/cita/modules/python/3.10*`, `3.12*`: they need `libssl.so.1.1`, which Rocky 9 doesn't have.
  * `/cita/modules/python/3.13*`: it works on the login node, but the compute nodes have an older
    OpenSSL (3.2), so `https` downloads fail inside jobs (`unknown url type: https`).
  * `/usr/bin/python3.11`: it can't create venvs (missing sysconfig data).

  Also don't `module load python/...` alongside a venv. Those modules export `PYTHONPATH`,
  which overrides the venv and makes `pip` install into `~/.local`.

### Submitting

Use [`Grun_CITA-ricky2.sh`](../templates/gizmo_submission_scripts/Grun_CITA-ricky2.sh)
as a template and submit it from ricky2:

```
qsub Grun_CITA-ricky2.sh
qstat -u $USER          # Q = queued, R = running
qstat -x -f <jobid>     # details, incl. Exit_status, also after the job finished
qdel <jobid>
```

### MUSIC

MUSIC has not been tested on ricky2 yet. It should build with the same modules
(`gnu14 openmpi5 hdf5 fftw gsl`), with the Makefile paths taken from the same variables.

You're all set to [run GIZMO](gizmo_setup.md).
