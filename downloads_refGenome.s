#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1:00:00
#SBATCH --mem=4GB
#SBATCH --job-name=downloadsRefGenome
#SBATCH --mail-type=END
#SBATCH --mail-user=pmh314@nyu.edu
#SBATCH --output=outputs_DownRefGenomes.out


module purge
module load sra-tools/intel/2.8.1-2

RUNDIR=$SCRATCH/ReferenceGenome
cd $RUNDIR

# Patient of age 52 posttreatment
wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/data/hg38.tar.gz

# Unzip
tar -xvzf hg38.tar.gz































