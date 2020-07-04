# Sequencing data processing and analysis

Here we implemented a processing and analysis pipeline to extract information from sequencing data to provide insight for Multiple sclerosis (MS) treatments. 

MS is a neurodegenerative diseases that affects more than 2.3 million people worldwide. It is characterized by a loss of nerve myeline which results in slower synaptic transmission and possible cell death leading to walking difficulties, vision problems, fatigue, numbness and a range of cognitive changes. The cause is unknown but it is associated with autoimmune processes.

Here we look at changes in the gene profile of human immune cells in response to the two of the most common treatments for the disease: [interferon-beta](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA258216) and [vitamin D](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA285092). We compared large scale squencing data across conditions using the following analysis pipeline:

## Download raw reads from open source repositories
Run [downloads_refGenome.s](downloads_refGenome.s) to download files. This step is optional. The rest of the processing and analysis pipeline works on all SRA sequencing data.

## Asses quality of the raw data
We used [FASTQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to get a comprehensive description sequencing reads' quality. This allows for visual and quantitative inspection of the data quality to inform data processing and filtering. Run [fastq.s](fastq.s).

## Data preprocessing and filtering



