#!/bin/bash
#SBATCH --nodes=8
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=FastQ_Monocytes_01
#SBATCH --mail-type=END
#SBATCH --mail-user=pmh314@nyu.edu
#SBATCH --output=outputs_FastQmono01.out


module purge
module load fastqc/0.11.5


RUNDIR=$SCRATCH/BioinformaticsAndGenomes/FastqFiles/Monocytes02
cd $RUNDIR

fastqc MonoC_control_01.fastq
fastqc MonoC_control_02.fastq
fastqc MonoC_control_03.fastq

fastqc MonoC_vitD_01.fastq
fastqc MonoC_vitD_02r.fastq
fastqc MonoC_vitD_03.fastq



