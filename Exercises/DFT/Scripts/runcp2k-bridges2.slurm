#!/bin/bash
#SBATCH --job-name=MYCP2K
#SBATCH --output=MYCP2K.o%j
#SBATCH --error=MYCP2K.e%j
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --partition=RM
#SBATCH --time=00:30:00
#SBATCH --account=see220002p
#SBATCH --exclusive
ulimit -s unlimited
export OMP_NUM_THREADS=1
echo "SLURM_NTASKS: " $SLURM_NTASKS

module load gcc/10.2.0 openmpi/4.0.5-gcc10.2.0
module load CP2K/8.1-gcc10.2.0-openmpi4.0.5.lua

mpirun -np $SLURM_NTASKS cp2k.popt -i cp2k.inp -o cp2k.out
