#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=192
#SBATCH	--time=24:00:00
#SBATCH --job-name=MUSIC_TEST_1
#SBATCH --output=music_test.txt
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR

module load StdEnv/2023 gcc/12.3 openmpi/4.1.5 fftw-mpi/3.3.10 gsl/2.7 hdf5/1.14.2

music_dir="./music"
params_file="./templates/music_dm_only.conf"

mpirun "$music_dir/MUSIC" "$params_file"
