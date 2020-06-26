#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3:00:00
#SBATCH --mem=4GB
#SBATCH --job-name=trimMono1
#SBATCH --mail-type=END
#SBATCH --mail-user=pmh314@nyu.edu
#SBATCH --output=outputs_trimMono1.out


module purge
module load trim_galore/0.4.4
module load cutadapt/intel/1.12
module load fastqc/0.11.5

RUNDIR=$SCRATCH/BioinformaticsAndGenomes/FastqFiles/Monocytes01
cd $RUNDIR

trim_galore --fastqc --length 40 --trim-n --paired SRR1550998_1.fastq SRR1550998_2.fastq
trim_galore --fastqc --length 40 --trim-n --paired SRR1550993_2.fastq SRR1550993_1.fastq
trim_galore --fastqc --length 40 --trim-n --paired SRR1551102_2.fastq SRR1551102_1.fastq

trim_galore --fastqc --length 40 --trim-n --paired SRR1551096_2.fastq SRR1551096_1.fastq
trim_galore --fastqc --length 40 --trim-n --paired SRR1551041_2.fastq SRR1551041_1.fastq
trim_galore --fastqc --length 40 --trim-n --paired SRR1551034_2.fastq SRR1551034_1.fastq




