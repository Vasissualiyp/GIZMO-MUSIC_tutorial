#!/bin/bash -l
#PBS -l nodes=1:ppn=128
#PBS -l walltime=12:00:00
#PBS -r n
#PBS -j oe
#PBS -q starq

# NOTE: workq only allows nodes=1 and ppn<=8

# Directories
gizmo_dir="./gizmo"
params_dir="./templates"

# Parallelization options
# IMPORTANT: Product of OMP * MPI should be the same as
# nodes * ppn in the PBS header! (see line 2)
OMP_THREADS=2
MPI_NODES=64

#----------------------------------------

module purge
module load gcc/13.2.0 openmpi/4.1.6-gcc-ucx gsl/2.7.1 hdf5/1.12.1-ucx fftw/3.3.10-openmpi-ucx

# Go to your working directory containing the batch script, code and data
cd "$PBS_O_WORKDIR"

# Compile GIZMO
( cd "$gizmo_dir" || echo "directory $gizmo_dir doesn't exist"
  rm ./GIZMO
  make clean
  make -j 20 )

export OMP_NUM_THREADS=$OMP_THREADS

mpirun -np $MPI_NODES -map-by node:SPAN "$gizmo_dir/GIZMO" "$params_dir/gizmo.params" >& output.log

