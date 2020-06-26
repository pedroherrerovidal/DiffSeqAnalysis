## Get packages
source(source("http://bioconductor.org/biocLite.R"))
biocLite("edgeR")
library("edgeR")
library(GGally)
library(heatmap3)
biocLite("biomaRt")
library(biomaRt)
biocLite("statmod")
library(statmod)


## Paired analysis for MS patient monocytes
# Read data
rawdata <-read.delim("C:/Users/Pedro/Documents/Universidades/NYU/Biology Master/Bioinformatics and genomes/MS_Counts.txt", row.name="GENE")
rawdata <- rawdata[ rowSums(rawdata) > 0, ]
y <- DGEList(counts=rawdata[,1:6], genes=rawdata[,0])

# Filtering and normalization
o <- order(rowSums(y$counts), decreasing=TRUE)
y <- y[o,]
#d <- duplicated(y$genes$Symbol)
#y <- y[!d,]
nrow(y)


y$samples$lib.size <- colSums(y$counts)

y <- calcNormFactors(y)
y$samples

plotMDS(y)

Patient <- factor(c(52,36,35,52,36,35))
Tissue <- factor(c("C","C","C","T","T","T"))
data.frame(Sample=colnames(y),Patient,Tissue)

design <- model.matrix(~Patient+Tissue)
rownames(design) <- colnames(y)
design

y <- estimateDisp(y, design, robust=TRUE)
y$common.dispersion

plotBCV(y)

fit <- glmFit(y, design)

lrt <- glmLRT(fit)
topTags(lrt)

colnames(design)

o <- order(lrt$table$PValue)
cpm(y)[o[1:10],]


is.de <- decideTestsDGE(lrt)
summary(is.de)

#plotMD(lrt)
#abline(h=c(-1, 1), col="blue")

plotMD(lrt, status=is.de, values=c(1,-1), col=c("red","blue"),legend="topright")
abline(h=c(-1, 1), col="blue")


all <- topTags(lrt,n=Inf)
all.005 <- all[all$table$FDR < 0.05,]
deg <- all.005$table
deg.up <- deg[deg$logFC > 0,]
deg.down <- deg[deg$logFC < 0,]

head(deg.up)
head(deg.down)

mart <- useDataset(dataset = "hsapiens_gene_ensembl", 
                   mart    = useMart("ENSEMBL_MART_ENSEMBL",
                                     host    = "www.ensembl.org"))

geneSet <- row.names(deg.up)

resultTable.up <- getBM(attributes = c("wikigene_name","description"),
                     filters    = "hgnc_symbol", 
                     values     = geneSet, 
                     mart       = mart)

resultTable.up

geneSet <- row.names(deg.down)

resultTable.down <- getBM(attributes = c("wikigene_name","description"),
                     filters    = "hgnc_symbol", 
                     values     = geneSet, 
                     mart       = mart)

resultTable.down

## Unpaired analysis for MS patient monocytes
## Open the Table of Counts as data frame
MS.raw <- read.delim("C:/Users/Pedro/Documents/Universidades/NYU/Biology Master/Bioinformatics and genomes/MonoC_Counts.txt", row.name="GENE")

# remove genes with no its
MS.counts <- MS.raw[ rowSums(MS.raw) > 0, ]

## edgeR analysis: Multiple Sclerosis patient samples
#define groups 
group<-c("control","control","control","vitD","vitD","vitD")
dge.MS <-DGEList(counts=MS.counts, group=group)
dge.MS = calcNormFactors(dge.MS)
plotMDS(dge.MS,col=c("deepskyblue","deepskyblue4")[factor(dge.MS$samples$group)])
dge.MS=estimateCommonDisp(dge.MS)
dge.MS=estimateTagwiseDisp(dge.MS)

ggpairs(dge.MS$pseudo.counts[,], title = 'MS Pearson correlation summary', lower=list(col="yellow"))

plotMeanVar(dge.MS, show.tagwise.vars=TRUE, NBline=TRUE)
plotBCV(dge.MS)
de.MS<-exactTest(dge.MS)

# Get top tags
tt.MS = topTags(de.MS,n=nrow(dge.MS))

# Get depth-adjusted reads per million for some of the top differentially abundant genes:
nc.MS <- cpm(dge.MS,normalized.lib.sizes=TRUE)
rn.MS <- rownames(tt.MS$table)
cpm.adj.MS <- nc.MS[rn.MS,order(dge.MS$samples$group)]

# Get genes with a FDR lower than 0.005
deg.MS <- rn.MS[tt.MS$table$FDR < 0.05]
# Plot MA plot highlighting differentially abundant strains
plotSmear(dge.MS, de.tags=deg.MS, cex=0.5, col="cyan1")
abline(h=c(-1,1), col="gray")

# Clustering
adj.deg.table.MS <- cpm.adj.MS[deg.MS,]
expt.cor.MS <- cor(as.matrix(adj.deg.table.MS[,]), method="pearson")
expt.cor.dist.MS <- as.dist(1-expt.cor.MS)
expr.cor.hclust.MS <- hclust(expt.cor.dist.MS , method="average")
plot(expr.cor.hclust.MS)

# Clustering by gene
adj.deg.table.t.MS <- t(adj.deg.table.MS)
expt.cor.t.MS <- cor(as.matrix(adj.deg.table.t.MS[,]), method="pearson")
expt.cor.dist.t.MS <- as.dist(1-expt.cor.t.MS)
expr.cor.hclust.t.MS <- hclust(expt.cor.dist.t.MS , method="average")
plot(expr.cor.hclust.t.MS)

# Heatmap3
heatmap3(adj.deg.table.MS, col=colorRampPalette(c('deepskyblue4','white','firebrick'))(100))

# Up and downregulated genes
two.groups.genes <-cutree(expr.cor.hclust.t.MS, k=2)
over.exp <- as.logical(two.groups.genes-1)
down.exp <- !over.exp
down.exp.table.MS <- adj.deg.table.MS[down.exp,]
over.exp.table.MS <- adj.deg.table.MS[over.exp,]
down.exp.genes.MS <- row.names(down.exp.table.MS)
over.exp.genes.MS <- row.names(over.exp.table.MS)


mart <- useDataset(dataset = "hsapiens_gene_ensembl", 
                   mart    = useMart("ENSEMBL_MART_ENSEMBL",
                                     host    = "www.ensembl.org"))

geneSet <- over.exp.genes.MS

resultTable.up.mc <- getBM(attributes = c("wikigene_name","description"),
                        filters    = "hgnc_symbol", 
                        values     = geneSet, 
                        mart       = mart)

resultTable.up.mc

geneSet <- down.exp.genes.MS

resultTable.up.mc <- getBM(attributes = c("wikigene_name","description"),
                           filters    = "hgnc_symbol", 
                           values     = geneSet, 
                           mart       = mart)

resultTable.down.mc

## PART 3 intersection
match.MSMC <- intersect(row.names(deg),deg.MS) # for all deg

match.MSMC.up <- intersect(row.names(deg.up),over.exp.genes.MS)
match.MSMC.down <- intersect(row.names(deg.down),down.exp.genes.MS)

match.MS.up.MC.down <- intersect(row.names(deg.up),down.exp.genes.MS)
match.MS.down.MC.up <- intersect(row.names(deg.down),over.exp.genes.MS)

length(match.MSMC)
length(match.MSMC.up)
length(match.MSMC.down)
length(match.MS.up.MC.down)
length(match.MS.down.MC.up)
