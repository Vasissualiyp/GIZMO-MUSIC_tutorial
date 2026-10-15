#!/bin/bash -l
#PBS -l select=1:ncpus=80:mpiprocs=80
#PBS -l place=scatter:excl
#PBS -l walltime=48:00:00
#PBS -r n
#PBS -j oe
#PBS -q earthq
#PBS -N GIZMO_TEST_1

# CITA ricky2 cluster (PBS Pro server bob2). Submit from ricky2 with `qsub Grun_CITA-ricky2.sh`.
# Nodes have 80 cores (2x Xeon Gold 6148) and ~189 GB of RAM; ask for at most ncpus=80 per node,
# otherwise the job will sit in the queue forever.
# Queues: earthq, marsq, mercuryq, neptuneq, saturnq, uranusq (max 48h), jupiterq (max 96h).
# Multi-node: e.g. `#PBS -l select=4:ncpus=80:mpiprocs=80` (mpirun picks the hosts up from PBS).
#
# Hybrid MPI+OpenMP: if Config.sh has OPENMP=N, use mpiprocs=80/N and set OMP_THREADS=N below,
# e.g. select=1:ncpus=80:mpiprocs=40 with OMP_THREADS=2.

# Directories
gizmo_dir="./gizmo"
params_file="./templates/gizmo_dm.params"

OMP_THREADS=1

#----------------------------------------

module load gnu14 openmpi5 hdf5 fftw gsl

cd "$PBS_O_WORKDIR"

export OMP_NUM_THREADS=$OMP_THREADS
NRANKS=$(wc -l < "$PBS_NODEFILE")   # one line per mpiproc

mpirun -np "$NRANKS" "$gizmo_dir/GIZMO" "$params_file" > output.log 2>&1
