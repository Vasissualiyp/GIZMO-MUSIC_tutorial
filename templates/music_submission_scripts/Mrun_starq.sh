#!/bin/bash -l
#PBS -l nodes=1:ppn=128
#PBS -l walltime=12:00:00
#PBS -r n
#PBS -j oe
#PBS -q starq

# NOTE: workq only allows nodes=1 and ppn<=8

# Directories
music_dir="./music"
params_file="./templates/music_dm_only.conf"

# Parallelization options
# IMPORTANT: Product of OMP * MPI should be the same as
# nodes * ppn in the PBS header! (see line 2)
OMP_THREADS=1
MPI_NODES=128

#----------------------------------------

module purge
module load gcc/13.2.0 openmpi/4.1.6-gcc-ucx gsl/2.7.1 hdf5/1.12.1-ucx fftw/3.3.10-openmpi-ucx

# Go to your working directory containing the batch script, code and data
cd "$PBS_O_WORKDIR"

# Compile MUSIC
( cd "$music_dir" || echo "directory $music_dir doesn't exist"
  rm ./MUSIC
  make clean
  make -j 20 )

export OMP_NUM_THREADS=$OMP_THREADS

mpirun -np $MPI_NODES -map-by node:SPAN "$music_dir/MUSIC" "$params_file" >& output.log

