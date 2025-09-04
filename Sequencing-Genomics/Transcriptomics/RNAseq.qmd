---
title: "RNA-Seq Analysis"
author: Deyanira Borroto Alburquerque
bibliography: references.bibtex
format:
  pdf:
    toc: true
    toc-depth: 2          
    number-sections: true
    colourlinks: true
    mainfont: "Arial" 
    highlight-style: pygments         
    keep-tex: true                 
    pdf-engine: xelatex
---

# Abstract {#abstract}

The RNA sequencing (RNA-seq) protocol is initiated with the conversion of RNA (from mRNA or rRNA) into cDNA. These are fragmented and ligated to adapters and indexes. The resulting cDNA fragments are then "read" by high-throughput sequencing.

This protocol has the aim of analyzing an RNA sequencing dataset in order to identify diferentially expressed and corregulated genes and attemp to infer biological meaning. For this purpose a dataset from an [experiment](https://pmc.ncbi.nlm.nih.gov/articles/PMC11535345/) in which RNA was extracted from the *C17.2* neural stem cell (NSC) line was used. This study has the aim of investigating the impact of Toe1 on the development of NSC.

The pipeline followed can be accessed for viewing and importing by visiting the following [URL](https://usegalaxy.org/published/workflow?id=173ecc0c88090d0e): `https://usegalaxy.org/published/workflow?id=173ecc0c88090d0e`. Can be also viewed in [Appendix H](#appxH).

RNA-seq results were satisfactory with many differentially expressed genes identified and interesting functional analysis with relevant biological meaning.\

**Keywords: RNA-Seq; Next-generation sequencing; Data analysis; Differentially expressed genes**

# Introduction

This RNA-seq analysis pipeline was performed using the [Galaxy](https://usegalaxy.org/) platform and will go through prealignment cleanup, alignment and mapping using the Ensembl gene annotation. This is followed by analysis where statistical tests are run to identify enrichment and diferentially expressed genes (DEGs). For each of these steps quality controls will be performed and examined.

The dataset used consists of *C17.2* cell line derived from isolated NSCs from brains of neonatal mouse and subsequently cultured to diferentiate in controlled conditions. Then single-guide RNA (sgRNA) were designed for Toe1 gene and GFP as negative control, and introduced to the NSCs via lentiviral infection, which allowed the creationg of a knockout (KO) from Toe1 gene @Toe1.

# Methods: RNAseq Data Analysis Workflow

## Getting Experiment Metadata

There were a total of 3 replicates from the control group (WT) and 3 replicates from the Toe1 knockout (KO-Toe1) group. Total RNA was extracted and sequenced from each group using Illumina HiSeq/MiSeq platform.

The sequencing data generated which was deposited in the Gene Expression Omnibus (GEO) with the accession code [GSE254609](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE254609) was accessed.

The `Metadata` (*SraRunTable.csv*) and SRR Accession list (*RunAccesionList.txt*) are obtained from the SRA Run Selector [page](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA1071133&o=acc_s%3Aa). These files are downloaded and uploaded to Galaxy.

The following is the table with the information from the runs:

| Run | BioSample | cell_line | Experiment | genotype | Library Name | LibraryLayout |
|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
| SRR27787864 | SAMN39674447 | differentiated C17.2 | SRX23452620 | WT | GSM8047009 | PAIRED |
| SRR27787865 | SAMN39674448 | differentiated C17.2 | SRX23452619 | WT | GSM8047008 | PAIRED |
| SRR27787860 | SAMN39674443 | differentiated C17.2 | SRX23452624 | Toe1_KO | GSM8047013 | PAIRED |
| SRR27787861 | SAMN39674444 | differentiated C17.2 | SRX23452623 | Toe1_KO | GSM8047012 | PAIRED |
| SRR27787862 | SAMN39674445 | differentiated C17.2 | SRX23452622 | Toe1_KO | GSM8047011 | PAIRED |
| SRR27787863 | SAMN39674446 | differentiated C17.2 | SRX23452621 | WT | GSM8047010 | PAIRED |

## Prealignment Quality Control and Cleanup {#pre}

The sequencing data was obtained with the tool `Faster Download and Extract Reads in FASTQ format` using the "List of SRA accession" (*RunAccesionList.txt*).

### QC on raw reads

The quality control (QC) on raw reads was performed with the `FastQC` tool. This was helpful to take a broad overview of the raw data. Upon exploring the output there were a few failed sections and some warnings but they were all within normal limits for raw reads. It was possible to see the adapter sequences which need to be removed.

### Preprocessing and QC

`Trim Galore` was used to preprocess the reads. This is done to improve quality and mapeability by removing low quality reads and adapter contaminants. This was followed by a second round of QC and was observed that the overall quality improved. The results from this preprocessing can be used for the following steps.

| Raw reads QC           | Preprocessed reads QC      |
|------------------------|----------------------------|
| ![](/images/rawQC.png) | ![](/images/PreprocQC.png) |

> Along all sections, the detailed information for each step can be obtained from the *Appendices* (kept as a "*Memoria* report"). See [Appendix A](#appxA) for more details on this section about "Prealignment QC and Cleanup".

## Alignment and Quantification

### Getting the Reference Files {#ref}

1.  The "gene reference" and "gene definitions" were obtained from [Ensembl Genome Browser](https://www.ensembl.org/info/data/ftp/index.html).
2.  The "transcript to gene mapping" file was also obtained from Ensembl, through [BioMart](https://www.ensembl.org/biomart/martview/bfa9b36304991fb7a3c622faa76de702)
3.  Then the "index file" was also created in Galaxy from the gene definitions file.

> See [Appendix B](#appxB) for more details on this section about "Getting Reference Files".

### Mapping and Alignment {#align}

`Salmon Quant` was used for mapping the alignment and performing quantification. Salmon does a pseudoalignment to the transcriptome and generates gene and transcript level quantifications. Three files are obtained: the aligned sequences (BAM), the gene quantification and the transcript quantification. However the BAM aligned sequences generated by Salmon can not be visualized in IGV since it maps readings against the transcript index not to the genome.

`HISAT2` was therefore used. This tool aligns readings to the genome, and produces the BAM files with genomic coordinates. This is useful for visualization in IGV and obtaining complementary information.

> See [Appendix C](#appxC) for more details about "Mapping and Alignment" steps and parameters.

#### Post Alignment QC {#postalign}

The BAMs from the alignment were visualized on IGV. The following is a general view at the position of the Toe1 gene where we can observe a good coverage. The dataset at the top belongs to the WT and the one below is the Toe1_KO.

Its possible to observe the coverage of the library by observing the coverage graphs. The graph underneeth the coverage represents the junctions, where the links between reads spanning between one or more exons are displayed. This shows that the alignment program dealt well with splicings.

![General View of the alignment.'HISAT2 on data 140' corresponds to a dataset of the WT (run SRR27787863) and 'HISAT2 on data 134' corresponds to the Toe1_KO (run SRR27787860)](/images/GenViewAlignment.png)

In the following image we can see and compare the coverages, after all tracks were selected and "Group Autoscale" was performed. No obvious differences, overexpressed or underexpressed, areas are noted.

![Coverage comparisson. The three datasets in ranges of lilac correspond to the three runs of the WT and the three in yellow correspond to the Toe1_KO.](/images/coverage.png)

In order to properly normalise coverage, to analyze it better, a bigWig was created through the `bamCoverage` tool in Galaxy. The tracks were opened in IGV and overlayed. The following are the results:

![Coverage overlay of WT (lilac) and Toe1_KO (yellow).](/images/overlayCov.png)

Here we can appreciate a pattern of underexpression in the Toe1_KO datasets compared to the WT datasets. Some areas of lower coverage for the mid part of the first exon, and also exons 5,6 and 7, have markedly lower coverage, and therefore expression.

> See [Appendix E](#appxE) for more details on this section about "Post Alignment QC and Filtering".

# Results

## Differential Expression {#diffExp}

To perform the differential expression the `limma` tool was used in Galaxy. This tool analyzes to contrast expression profiles between conditions. To do this it uses a count matrix extracted from the gene quantification previously obtained from Salmon.

The transformation method used was the **"voom"** which transforms raw counts into something that fits linear modeling assumptions and creates a model for each gene. Filtering was done to remove lowly expressed genes. Differentially expressed genes (DEG) testing to perform contrasts was done according to genotypes (Toe1 and WT). Normalisation with trimmed mean of M-values (TMM) was also performed, this adjusts for library size and composition biases. *P* values, adjusted *P* values and log2 fold changes are calculated for each gene. The adjusted *P* values are calculated with the Benjamini-Hochberg false discovery rate (FDR) method to adjust for multiple hypothesis testing.

The results from `limma` are multiple, including an analysis output report, normalised and filtered counts, and the diferentially expressed (DE) genes table.

> See [Appendix F](#appxF) for more details on this section about "DE using `limma`".

### Differential Expression Validation

The *Limma Analysis Output* was explored first, since it serves as a QC and validation of the limma preprocessing and differential expression (DE) analysis.

**Summary of experimental data:**

|  SampleID   | genotype (Primary Factor) |
|:-----------:|:-------------------------:|
| SRR27787860 |           Toe1            |
| SRR27787861 |           Toe1            |
| SRR27787862 |           Toe1            |
| SRR27787863 |            WT             |
| SRR27787864 |            WT             |
| SRR27787865 |            WT             |

It was possible to observe that **normalisation** with TMM correctly scaled the data sets without causing any distortion on them. As we can see in the following plots the samples remain the same after normalisation:

![Normalisation results.](/images/norm.png)

The **Multidimensional Scaling (MDS)** plot, shown below, exhibits the distances between samples based on log2FC ratio of gene expression. The WT samples are clustered to the right, indicating that they have similar expression profiles. Whilst the Toe1_KO samples are towards the left side of the plot although they show some more dispersion on the second dimension, which may be normal due to variations between replicates. This plot was used to validate the data is behaving as expected before interpreting DE results.

![Distance between samples.](/images/MDSPlot.png){width="410"}

The **voom transformation** was also successful in stabilizing the mean-variance relationship within the data as observed in both "voom: Mean-Variance Trend" and "Final Model: Mean-Variance Trend (SA Plot)" plots. The first showed high variance initially (at lower expression values) and lower variance at higher values. The second had a low variance with no major outliers and most values close to the reference line.

Lastly, there are the *differential expression counts* and different **contrast plots** to visualize them:

|           | Up  | Flat  | Down |
|:---------:|:---:|:-----:|:----:|
| *Toe1-WT* | 345 | 13516 |  51  |

345 genes are significantly upregulated (more expressed) in Toe1 compared to WT.\
51 genes are significantly downregulated in Toe1 compared to WT.\
13,516 genes were not significantly changed ("flat").

-   In the MD contrast plot, below, it is possible to observe the log-fold changes (logFC) against the average expression for each gene. The outliers which are coloured in red highlight significantly DE genes which are upregulated in Toe1_KO, whilst the coloured blue highlight the genes downregulated in Toe1_KO.

![Contrast Toe1-WT MD plot.](/images/MDcorrel.png){width="500"}

-   The contrast volcano plot shows a combination of log2FC and statistical significance (p-value). It is possible to see the genes that are both statistically significant and with large magnitude of change. We can see to the left those downregulated and to the right the upregulated. Those which are labeled are the most differentially expressed.

![Contrast Toe1-WT volcano plot.](/images/volcanoCorrel.png){width="500"}

-   The heatmap plot of this constrast adds up to the previous, showing a clear distribution of the upregulated and downregulated top 10 genes per sample. High expression is shown in red and low expression in blue. There is high expresion in 8/10 for the Toe1 datasets.

![Contrast Toe1-WT heatmap plot.](/images/HeatmapCorrel.png){width="500"}

With all the previous it is possible to confirm that the results from limma can be trusted and used and there are a number of uprelugated and downregulated genes that need further examination.

### Differential Expression Results

The DEGs table was filtered and those genes that were with values below an adjusted *P* Value of 0.05 and a logFC over 2 or below -2 were removed. Then, this reduction was applied on the normalized count table from limma to extract those more significant genes. The resulting table was further reduced for visualization purposes in **R** where the top 150 most variable genes were selected. The following heatmap representing the most remarkable differentially expressed genes was generated:

![Most diferentially expressed genes.](/images/heatmap.png)

In the previous image is possible to observe in detail the gene expression of the most differentially expressed genes obtained from the analysis. For the Toe1_KO samples (SRR27787860, SRR27787861 and SRR27787862) a generalized upregulation is noted (lighter colour on the left side), with a few downregulated in a middle portion (Mest and Megf10) and at the lower part of the heatmap (being the most downregulated GM37206).

> See [Appendix G](#appxG) for more details on this section about "Differential Expression Results".

## Functional Enrichment Analysis

This method, also called Gene Ontology (GO) enrichment analysis, is used to evaluate the biological relevance of the genes resulting from the differential expression analysis. Many tools are available to perform this. Here the `gProfiler GOst` tool was used on a filtered list of DE genes that are significanlty changed and the following plot was generated:

![Functional Enrichment Analysis Results.](/images/FA1.png)

A broad view of this functional analysis shows that more than half of the total of genes are affecting biological processes (GO:BP), and the rest are divided between specific molecular activities (GO:MF), cellular locations (GO:CC) and regulatory networks (TF), with a few of them affecting pathways (KEGG).

The knockout of Toe1 gene is affecting biological processes the most. But to see if these are those of our interest, in order to have more interaction with what processes are involved, the `gProfiler GOst` tool was run in it's [website](https://biit.cs.ut.ee/gprofiler/gost). The interest here is to see how Toe1 affects Neural Stem Cell (NSC) behavior and development. Therefore, since we have many results in the "Detailed Results" the filtering will be performed by searching for terms like: stem cell differentiation, neurogenesis, cell proliferation, extracellular matrix (whichi is involved in cell differentiation), the TNF signaling pathway (involved in normal inflammatory and immune responses), and other functions related to the proliferation and differentiation of NSCs.

![Highlighted Functional Enrichment Analysis. The light circles represent less significant terms.](/images/highlightedFA.png)

![Significant Functions Table.](/images/FAtable.png)

> See [Appendix G](#appxG) for more details on this section about "Functional Enrichment Analysis".

# Conclusions

The RNA-seq results indicated that Toe1 primarily affects biological processes such as neurogenesis, immune system, developmental, cell proliferation and immune response processes. But metabolical processes such as protein binding, ion binding and extracellular matrix, are also rather affected. These disruptions can lead to the transmission of downstream signals that affect various functions of bioactive molecules that play key roles in cell survival and proliferation.\
Some transcription factors affected are also relevant. Including the NF-1A, important in nervous system development; NF-kappaB, in survivall and proliferation of NSCs; WT1 and ZIC3 (NSCs proliferation and differentiation respectively).

## Appendix A: Prealignment QC and Cleanup {#appxA}

Go back [up](#pre).

These steps are all performed in the Galaxy platform:

1.  The tool: `Faster Download and Extract Reads in FASTQ format` was used \> select "List of SRA accession", one per line \> The RunAccesionList is automatically selected \> Run Tool.\
    **With this the Pair-End sequencing data that will contain the reads in Fastq format was obtained**.

2.  The `FastQC` tool was used to perform quality control (QC) on raw reads \> select Dataset Collection: pair-end data \> no contaminant or adapter lists were available, therefore we ran with default parameters.\
    **The tool produces a report with all the metrics.**

> This document was examined and kept handy to compare it with the FastQC that we will do after processing the raw reads.

4.  **Preprocess of reads:** was performed with the tool `Trim Galore` for "Paired Collection" with default options.

5.  A second round of **FastQC** is then performed now on the preprocessed reads to assess quality improvements or possible changes.

6.  Step 4 (adjusting parameters) and step 5 would be repeated if the quality is not optimal.

## Appendix B: Getting Reference Files {#appxB}

Go back [up](#ref).

Since we are reproducing the results of an experiment from a paper, we checked in the paper Methods and looked into RNA-sequencing data analysis and find what reference they used.

With this information we obtained the gene reference and gene definitions from the [Ensembl Genome Browser](https://ftp.ensembl.org/pub/release-113/fasta/mus_musculus/dna/):

1.  The **reference** is obtained by entering in Mus musculus \> DNA (FASTA) \> finding the URL link of the fasta file with "...primary_assembly" \> Copy the URL [link](https://ftp.ensembl.org/pub/release-113/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz)

2.  The **gene definitions** are obtained by entering in Mus musculus \> Gene sets \> Finding the gene build version with extension "...113.gtf.gz" \> Copy the URL [link](https://ftp.ensembl.org/pub/release-113/gtf/mus_musculus/Mus_musculus.GRCm39.113.chr.gtf.gz)

3.  Both URL links are then uploaded to Galaxy from Upload \> Paste/Fetch Fasta (two times, to obtain two upload boxes) \> Pasting each link into a different box \> Start

Now we will obtain the relation of the transcripts to the genes from [BioMart tool](https://www.ensembl.org/biomart/martview/bfa9b36304991fb7a3c622faa76de702) from the Ensembl web site:

1.  The transcript to **gene mapping** file is obtained by selecting \> Choose Database: Ensembl Genes \[version\] \> Choose Dataset: Mouse Genes \[version\] \> Click Attributes to select attributes to display \> + Gene \> Deselect everything except "Gene stable ID" and "Transcript stable ID" \> click on RESULTS \> Select "Unique results only" \> Click GO

2.  The resulting file is then uploaded to Galaxy

3.  Is required to invert the order of the columns using the `Sort Column Order by heading` tool \> Identifier column "Column:2" \> was named as "TranscriptToGeneIDs"

### B: Prepare index file

Go back [up](#ref).

The "gene definitions file" needs to be modified to improve the quality of quantification, this is done performing the following:

1.  The tool `Select lines that match an expression` is used on the raw .gtf file with the gene definitions that was previously downloaded \> Set to NOT Matching with pattern `(pseudogene|miRNA)` to remove those transcripts annotated as pseudogenes or miRNAs.

The tool used for alignment (`Salmon`) needs as reference the sequences of the transcripts and a file with the relation of the trascripts to genes. To get the indexed fasta file the `Gffread` tool was used:

1.  "Input feature file": is the "gene definitions (.gtf) file"
2.  Select "Reference Genome": From your history \> the assembly fasta reference downloaded
3.  In "Select fasta outputs" activate the "fasta file with spliced exons for each GFF transcript (-w)" option.
4.  "Feature File Output" was set to GTF (with second column filteredGTF) and "Full Attribute Preservation".

Two files are produced: a gene definition file (.gtf) with the lines of the gtf file and the fasta (.fa) index file wich contains the sequences of the transcripts.

## Appendix C: Mapping and Alignment {#appxC}

Go back [up](#align).

`Salmon Quant` was used in "Reads" mode, in order to perform the mapping.

1.  In "Reference transcriptome" was selected "Use one from history" \> Salmon index: "Transcrits FASTA file" was the processed reference (*gffread of exons.fa*) and "Reference genome": the downloaded *Mus_musculus.primary_assembly.fa*
2.  "Data input": the *paired end collection* of trimmed fastq files \> "Specify the strandedness of the reads": Infer automatically (A) \> Rest as Default
3.  "Write Mappings to BAM File": Enabled
4.  "File containing a mapping of transcripts to genes": enter the mapping between trascripts to genes (*TranscriptToGeneIDs*)
5.  This was run with "Sequence-specific correction" and "Fragment GC bias correction" activated and the rest of parameters as default.

> Several outputs at transcript and gene quantification level are produced. Two quantifications are produced on the table created by Salmon: **TPMs** which is a normalized quantification by the total number of transcripts produced in the experiment; and **NumReads** which are just the counts, how many sequences mapped to that particular transcript or gene.

`HISAT2` was run with the reference genome from *Mus Musculus* GRCm39.assembly.fa downloaded \> on the Paired-end preprocessed collection with Default options.

## Appendix E: Post Alignment QC {#appxE}

Go back [up](#postalign).

The BAMs are visualized following these steps:

1.  Opening IGV locally \> loading reference Genome by entering "Genome" \> "Load Genome from UCSC GenArk..." \> and finding the "GRCm39/mm39"
2.  Then the BAMs are loaded from Galaxy by clicking on the "HISAT2 aligned reads (BAM)" finished job in the 'History' \> Clicking on the datasets one by one \> (within this dataset menu) clicking on "Visualize" \> and finally clicking on "display with IGV ( local )"
3.  This is then opened in the local IGV. The gene of interest (Toe1) is written into the 3rd box ("Enter a gene or locus") \> Click Go
4.  Adjustments for visualization were done, these included: changing colour, zooming into specific areas, removing tracks... \> once the image was as desired this was saved from "File" \> "Save PNG image..."

The `bamCoverage` tool was used to create a bigWig \> The BAMs resulting from HISAT2 were selected from the collections and this tool was run with default parameters.

The resulting tracks were opened in IGV as previously explained \> colour was changed and by selecting all \> right click to open the menu \> selecting "Overlay Tracks..." these were overlayed.

## Appendix F: Differential Expression {#appxF}

Go back [up](#diffExp).

The `limma` tool from Galaxy, to analyze contrasts between conditions, uses the NumReads column from the "Gene quantification" results obtained with Salmon. This has to be provided in the shape of a counts matrix.

The following are the steps to obtain this **counts matrix**:

1.  Samples name and NumReads are extracted from "Gene Quantification" (1st and 5th columns) with `Advanced Cut columns from a table (cut)` \> Dataset Collection: "Sample Salmon Gene Quantification" \> Set Options to: keep; fields; tab \> select 1st and 5th columns

2.  `Column join` was used on the table created in step 1 \> "Identifier column": 1 \> "Number of header lines": 1 \> Set "Add column name to header": No

The **Gene names mapping table** to associate the gene IDs to their names was created:

1.  Same as the transcript to gene mapping file, the names are obtained from Ensembl, by entering [BioMart](https://www.ensembl.org/biomart/martview/bfa9b36304991fb7a3c622faa76de702) and following the same steps as before but now we select "Gene stable ID" and "Gene name" \> click on RESULTS \> Select "Unique results only" \> Click GO \> The resulting file is uploaded to Galaxy

Then `limma` is run:

1.  Select "Differential Expression Method": limma-voom

2.  "Count Files or Matrix?" Single Count Matrix \> Select Single Dataset: Counts Matrix (created before) \> "Input factor information from file?" No \> Add Factor \> "Factor Name *": genotype \> "Groups* ": (group names for the samples separated with commas in the order of the samples in the columns of the count matrix) Toe1,Toe1,Toe1,WT,WT,WT

3.  "Use Gene Annotations?" Yes \> Select Single Dataset: Gene Names mapping table(obtained before)

4.  "Input Contrast information from file?": No \> "Contrast": Toe1-WT \> "Filter Low Counts": Yes \> "Minimum CPM *": 1 \> "Minimum Samples* ": 3

5.  "Output Options:" \> Selected all

6.  "Advanced options:" \> "Minimum Log2 Fold Change \*": 1.0 (as they did on the paper) \> "Test significance relative to a fold-change threshold (TREAT)": Yes \> Rest as Default

## Appendix G: Results and Functional Analysis {#appxG}

Go back [up](#diffExp).

The `gProfiler GOSt` tool will be used to assess the significance of enrichment for DE genes obtained compared to previously defined processes by the Gene Ontology Consortium.

GOst needs a list of genes separated by spaces. It's required to process the DE Table resulting from limma to get it.

### Obtaining the filtered DE genes list from DE Tables:

To filter this table and get only the significantly changed genes the adjusted *P* Value (column 7) and a logFC (column 3) are filtered to values which are considered significant:

1.  First the tool: `Filter data on any column using simple expressions` is used on \> "Dataset Collection:" limma DE tables \> "With following condition:" `c7<0.05 and (c3>2 or c3<-2)`\> "Number of header lines to skip": 1

> This means to select only those genes with values below an adjusted *P* Value of 0.05 and a logFC over 2 or below -2. This filtered table is used later to create a merge with the table of "Normalised Counts" obtained from limma and whith the resulting document produce a the clustered heatmap in **R**.

2.  Then `Advanced Cut` is performed to extract the 2nd column with the gene names\> "Dataset Collection:" output from step 1 \> Set "Operation" to 'Keep' \> fields \> tab \> select 'Column: 2'

3.  `Replace parts of text` was used to replace the 'newline' symbol of the list by a space \> "Dataset Collection:" output from step 2 \> "Find pattern": `\n` (find newlines) \> "Replace with": \<type a space\>, Set to Yes "Find-Pattern is a regular expression" and "Replace all occurences of the pattern".

The list of filtered (significantly changed) DE genes in one line, separated by spaces, was obtained.

### gProfiler GOSt:

The `gProfiler GOSt` can now be run with the filtered gene list:

1.  "Input" \> filtered DE genes list
2.  "Organism:" Common organisms \> "Common organisms:" Mus musculus (mouse)
3.  "Advanced Options:" set to Yes "Export plot", the rest as default.

The output of this tool is a table with the results of the functional enrichment analysis and a plot.

> The tool was ran again with the list of filtered DE genes in its [website](https://biit.cs.ut.ee/gprofiler/gost) to extract the Manhattan plot that illustrates the enrichment analysis results containing the desired functions highlighted and the table. The relevant terms from each process were selected similarly to how it is shown in the following image:

![Selecting GO:BP terms.](/images/BPselect.png)

### Heatmap from filtered DE genes:

To obtain a table that contains the "filtered DE genes" with the "Normalized Counts" that will be used for the heatmap the following steps are done:

1.  The "filtered DE genes" are taken from the first column of the filtered table from step 1 of 'Obtaining the **filtered DE genes list** from DE Tables'. This is performed by opening the `Advanced Cut` tool in Galaxy \> accessing that table as the file to cut within the Collections \> select Column:1 to obtain the Gene IDs
2.  Then `Join two Datasets side by side on a specific field` is used to join the Collection with the "filtered DE Gene IDs" previously created \> using column 1 \> with the Normalised Counts matrix dataset from limma \> and column 1 \> Setting *No* to incomplete, non matching lines and empty columns \> and *Yes* to "Keep header lines"
3.  Finally `Advanced Cut` is used on "Operation": Discard to remove Columns 1 and 2.

A matrix with genes in rows and samples in columns is obtained, from which a clustered heatmap was generated in Rstudio. The matrix is downloaded from Galaxy and read in Rstudio. When the heatmap was produced, the result with the resulting genes (\~300) was too crouded, therefore, the top 150 most variable genes were chosen for visualization. The following were the steps followed to generate an adequate heatmap:

``` r
# Load necessary libraries
library(tidyr)
library(dplyr)
library(pheatmap)
library(viridis)
library(grid)

# Read the data
data <- read.delim(
    "~/Descargas/Galaxy573-[Advanced Cut on data 571].tabular", 
    header = TRUE, sep = "\t")

# Remove empty gene names
df_clean <- data %>% 
  filter(Gene.name != "")

# Select the top 150 most variable genes
df_top150 <- df_clean %>%
  rowwise() %>%
  mutate(sd = sd(c_across(-Gene.name))) %>%  # Calculate standard deviation across samples
  ungroup() %>%
  arrange(desc(sd)) %>%                      # Sort genes by variability (high to low)
  slice_head(n = 150) %>%                    # Select top 150
  select(-sd)                                # Remove the sd column before plotting

# Convert to matrix format
mat <- as.matrix(df_top150[,-1])              # Exclude the Gene.name column
rownames(mat) <- df_top150$Gene.name           # Set gene names as row names

# Save the heatmap as a high-quality PDF
pdf("heatmap_logFC_filtered.pdf", width = 8, height = 30)

# Create heatmap object
p <- pheatmap(mat,
              cluster_cols = TRUE,
              cluster_rows = TRUE,
              color = viridis(100),
              fontsize_row = 4,               # Smaller font for gene names
              fontsize_col = 10,              # Larger font for sample names
              main = "Top 150 Most Variable Genes")

# Draw the heatmap properly inside the PDF
grid::grid.newpage()
grid::grid.draw(p$gtable)

dev.off()
```

## Appendix H: Workflow {#appxH}

Go back [up](#abstract).

![Entire RNA-Seq workflow.](/images/Wflow.png)

![Workflow first part.](/images/WF1.png)

![Workflow second part.](/images/WF2.png)

![Workflow third part.](/images/WF3.png)