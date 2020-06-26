#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=htSeqMono2
#SBATCH --mail-type=END
#SBATCH --mail-user=pmh314@nyu.edu
#SBATCH --output=outputs_htSeq_mono02.out



module purge
module load htseq/intel/0.6.1p1
module load pysam/intel/0.11.2.2 


RUNDIR=$SCRATCH/BioinformaticsAndGenomes/FastqFiles/Monocytes02
cd $RUNDIR

htseq-count -f bam MonoC_control_01_trimmed.sorted.bam /scratch/pmh314/RefGen/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf > MonoC_control_01_counts.txt

htseq-count -f bam MonoC_control_02_trimmed.sorted.bam /scratch/pmh314/RefGen/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf > MonoC_control_02_counts.txt

htseq-count -f bam MonoC_control_03_trimmed.sorted.bam /scratch/pmh314/RefGen/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf > MonoC_control_03_counts.txt

htseq-count -f bam MonoC_vitD_01_trimmed.sorted.bam /scratch/pmh314/RefGen/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf > MonoC_vitD_01_counts.txt

htseq-count -f bam MonoC_vitD_02_trimmed.sorted.bam /scratch/pmh314/RefGen/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf > MonoC_vitD_02_counts.txt

htseq-count -f bam MonoC_vitD_03_trimmed.sorted.bam /scratch/pmh314/RefGen/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf > MonoC_vitD_03_counts.txt



echo "DONE"




