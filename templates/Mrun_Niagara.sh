#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=40
#SBATCH	--time=24:00:00
#SBATCH --job-name=GIZMO_TEST_1
#SBATCH --output=music_test.txt
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR

module load gcc gsl hdf5 fftw

music_dir="./music"
params_file="./templates/music_dm_only.conf"

mpirun "$music_dir/MUSIC" "$params_file"
