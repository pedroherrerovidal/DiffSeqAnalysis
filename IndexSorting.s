#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00
#SBATCH --mem=20GB
#SBATCH --job-name=trimMono1
#SBATCH --mail-type=END
#SBATCH --mail-user=pmh314@nyu.edu
#SBATCH --output=outputs_indexSortMono02vit.out
#SBATCH --array=1-3

module purge
module load hisat2/intel/2.0.5
module load samtools/intel/1.3.1

RUNDIR=$SCRATCH/BioinformaticsAndGenomes/FastqFiles/Monocytes02
cd $RUNDIR

filename=MonoC_vitD_trimmed_0${SLURM_ARRAY_TASK_ID}

hisat2 --threads 16 -x $SCRATCH/ReferenceGenome/hg38/genome -U ${filename}.fq | samtools view -bS -@ 16 > ${filename}.bam
samtools sort -@ 16 ${filename}.bam -o ${filename}.sorted.bam 
samtools index ${filename}.sorted.bam

echo "DONE"



