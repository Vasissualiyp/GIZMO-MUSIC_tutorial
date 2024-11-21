#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=40
#SBATCH	--time=24:00:00
#SBATCH --job-name=GIZMO_TEST_1
#SBATCH --output=gizmo_test.txt
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR

module load intel intelmpi gsl hdf5 fftw

gizmo_dir="./gizmo"
params_file="./templates/gizmo_dm.params"

mpirun "$gizmo_dir/GIZMO" "$params_file"
