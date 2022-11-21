#!/bin/bash
#SBATCH --job-name=5_H2O2
#SBATCH --output=5_H2O2.o%j
#SBATCH --error=5_H2O2.e%j
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=40
#SBATCH --partition=400p48h
#SBATCH --qos=funded
#SBATCH --time=00:30:00
#SBATCH --mail-user=wnw36@msstate.edu
#SBATCH --mail-type=ALL
#SBATCH --account=060803-362129
#SBATCH --exclusive
ulimit -s unlimited
export OMP_NUM_THREADS=1
echo "SLURM_NTASKS: " $SLURM_NTASKS

module purge
module load intel/2021.2
module load impi/2021.2
module load contrib
module load cp2k/8.2

srun cp2k.popt -i cp2k.inp -o cp2k.out
