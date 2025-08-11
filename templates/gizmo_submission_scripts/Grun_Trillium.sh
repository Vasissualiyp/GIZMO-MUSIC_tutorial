#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=192
#SBATCH	--time=24:00:00
#SBATCH --job-name=GIZMO_TEST_1
#SBATCH --output=gizmo_test.txt
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR

module load StdEnv/2023 gcc/12.3 openmpi/4.1.5 fftw-mpi/3.3.10 gsl/2.7 hdf5/1.14.2

gizmo_dir="./gizmo"
params_file="./templates/gizmo_dm.params"

mpirun "$gizmo_dir/GIZMO" "$params_file"
