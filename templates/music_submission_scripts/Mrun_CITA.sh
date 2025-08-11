#!/bin/bash -l
#PBS -l nodes=1:ppn=128
#PBS -l walltime=12:00:00
#PBS -r n
#PBS -j oe
#PBS -q workq

# NOTE: workq only allows nodes=1 and ppn<=8

# Directories
music_dir="./music"
params_file="./templates/music_dm_only.conf"

# Parallelization options
# IMPORTANT: Product of OMP * MPI should be the same as
# nodes * ppn in the PBS header! (see line 2)
OMP_THREADS=2
MPI_NODES=64

#----------------------------------------

module purge
module load gcc gdf5 gsl fftw

# Go to your working directory containing the batch script, code and data
cd "$PBS_O_WORKDIR"

export OMP_NUM_THREADS=$OMP_THREADS

mpirun -np $MPI_NODES -map-by node:SPAN "$music_dir/MUSIC" "$params_file" >& output.log

