# Sequencing data processing and analysis

Here we implemented a processing and analysis pipeline to extract information from sequencing data to provide insight for Multiple sclerosis (MS) treatments. 

**This preprocessing pipeline works on all transcriptomic sequencing data, and the analysis and visualization script can be used for any table of counts (genomics data and beyond).**

MS is a neurodegenerative diseases that affects more than 2.3 million people worldwide. It is characterized by a loss of nerve myeline which results in slower synaptic transmission and possible cell death leading to walking difficulties, vision problems, fatigue, numbness and a range of cognitive changes. The cause is unknown but it is associated with autoimmune processes.

Here we look at changes in the gene profile of human immune cells in response to the two of the most common treatments for the disease: [interferon-beta](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA258216) and [vitamin D](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA285092). We compared large scale squencing data across conditions using the following analysis pipeline:

## Download raw reads from open source repositories
Run [downloads_refGenome.s](downloads_refGenome.s) to download files. This step is optional. The rest of the processing and analysis pipeline works on all SRA sequencing data.

## Asses quality of the raw data
We used [FASTQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to get a comprehensive description sequencing reads' quality. This allows for visual and quantitative inspection of the data quality to inform data processing and filtering. Run [fastq.s](fastq.s).

## Data preprocessing and filtering
Based of the FASTQC output, we filter the reads using [Trim-galore](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/), which provides flexible preprocessing of data reads. Run [Trimming.s](Trimming.s) to use chosen hyperparameters for these datasets.

Note: one should asses data quality after any preprocessing step.

## Align reads to the reference genome
Here we use [hiSAT2](http://daehwankimlab.github.io/hisat2/) to identify the genes and DNA sequences from the human DNA that our reads come from for all conditions. Run [IndexSorting.s](IndexSorting.s) script.

## Generate and structure data
To inspect differences in gene regulation across treatments, we generated table of counts with patients (observations) as columns and genes as rows (features). We used [HTSeq](https://htseq.readthedocs.io/en/release_0.11.1/count.html), implemented in [htseq.s](htseq.s).

## Gene expression analysis
We extracted significantily modulated genes for across conditions, correcting for multiple data comparisons, did unsupervised exploration of data structure using multidimensional scaling (MDS) and draw predictions between treatment conditions using generalized linear models (GLMs). We use [edgeR](https://bioconductor.org/packages/release/bioc/html/edgeR.html), [GGally](https://cran.r-project.org/web/packages/GGally/index.html), [heatmap3](https://www.rdocumentation.org/packages/heatmap3/versions/1.1.7/topics/heatmap3), [biomaRt](https://bioconductor.org/packages/release/bioc/html/biomaRt.html), [statmod](https://cran.r-project.org/web/packages/statmod/index.html) and built in R modules to this end. Run [AnalysisVisualization.R](AnalysisVisualization.R) to visualize and analyze the sequencing data.


