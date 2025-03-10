# RNA-Seq Analysis

**Author:** *Deyanira Borroto Alburquerque*

### Abstract

***This RNA-Seq analysis is based on 17 samples (4–5 independent biological replicates of LLI-NT, LLI-VIP, ALI-NT, and ALIVIP differentiated Caco-2 cells).***\
***"The goal of the project is to investigate the impact of liquid-liquid interface (LLI) and air-liquid interface (ALI) with addition of vasointestinal peptide (VIP) on intestinal barrier properties and mucus production of Caco-2 cell cultures. Caco-2 cells were cultured in transwell plates under LLI and ALI condition and VIP were added to basolateral compartment. LLI-NT, LLI-VIP, ALI-NT and ALI-VIP were collected and analysis using RNAseq." (https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=study&acc=SRP489490)***


**Keywords:** RNA-Seq; Next-generation sequencing; Data analysis; Differentially expressed genes

### Introduction
The challenge that presents here is that simulating the intestinal mucosa for in vitro assays of a mucus layer is difficult. In fact, the widely used intestinal cell-line Caco-2, under normal culture conditions lack a mucus layer. It is important to represent adequately the intestinal mucosal barrier since this plays an important role in healthy microbe–host interactions, it regulates the passage of nutrients and prevents invasion by pathogens.

Here we will investigate the impact that the different culture conditions have on the total transcriptome, related to mucus production and epithelial barrier properties.

### Methods

#### Getting the experiment Data

The data utilized for this RNA-seq analysis was obtained from the *"Air-liquid interface Caco-2 culture with vasointestinal peptide mimicks gut mucosal barrier function in permeability and bacterial infection"* [study](https://pubmed.ncbi.nlm.nih.gov/39714032/).

> To get the data the following GEO accession [GSE283451](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE283451) was used, where the Raw data available in SRA was found under the BioProject accession: PRJNA1076117.

#### Some information about the dataset:

| General information\* |                                            |
|-----------------------|--------------------------------------------|
| Assay Type            | RNA-Seq                                    |
| Instrument            | NextSeq 2000                               |
| Platform              | ILLUMINA                                   |
| LibraryLayout         | PAIRED                                     |
| LibrarySource         | TRANSCRIPTOMIC                             |
| Collection_Date       | 2022                                       |
| cell_line             | Caco-2                                     |
| Organism              | Homo sapiens                               |
| tissue                | epithelial colorectal adenocarcinoma cells |

\**(selected the most relevant from the SRA Run Selector [page](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA1076117&o=acc_s%3Aa))*

**Specific information** on the libraries, which consist of 17 samples:

![Figure 1. Libraries](/images/samples.png)

This is how they are distributed:

```         
GSM8662632  Caco-2 cells, Liquid-Liquid, no treatment, replicate 1
GSM8662633  Caco-2 cells, Liquid-Liquid, no treatment, replicate 2
GSM8662634  Caco-2 cells, Liquid-Liquid, no treatment, replicate 3
GSM8662635  Caco-2 cells, Liquid-Liquid, no treatment, replicate 4

GSM8662636  Caco-2 cells, Liquid-Liquid, VIP treatment, replicate 1
GSM8662637  Caco-2 cells, Liquid-Liquid, VIP treatment, replicate 2
GSM8662638  Caco-2 cells, Liquid-Liquid, VIP treatment, replicate 3
GSM8662639  Caco-2 cells, Liquid-Liquid, VIP treatment, replicate 4
GSM8662640  Caco-2 cells, Liquid-Liquid, VIP treatment, replicate 5

GSM8662641  Caco-2 cells, Air-Liquid, no treatment, replicate 1
GSM8662642  Caco-2 cells, Air-Liquid, no treatment, replicate 2
GSM8662643  Caco-2 cells, Air-Liquid, no treatment, replicate 3
GSM8662644  Caco-2 cells, Air-Liquid, no treatment, replicate 4

GSM8662645  Caco-2 cells, Air-Liquid, VIP treatment, replicate 1
GSM8662646  Caco-2 cells, Air-Liquid, VIP treatment, replicate 2
GSM8662647  Caco-2 cells, Air-Liquid, VIP treatment, replicate 3
GSM8662648  Caco-2 cells, Air-Liquid, VIP treatment, replicate 4
```

The *Caco-2* cells were grown under four different low-glucose culture conditions:

- liquid–liquid interface non-treated (LLI-NT), 
- liquid–liquid interface with addition of vasointestinal peptide (VIP) in the basolateral compartment (LLI-VIP),
- air–liquid interface non-treated in which media was removed from the apical compartment (ALI-NT), and 
- air–liquid interface with VIP added to the basolateral compartment (ALI-VIP)

> Gastrointestinal peptides, such as VIP, are known as critical regulators for the gut barrier, that would likely enhance mucus production

RNA was analyzed for 4–5 independent biological replicates of LLI-NT, LLI-VIP, ALI-NT, and ALI-VIP differentiated Caco-2 cells.

By clicking in Download \> `Metadata` the SraRunTable.csv is obtained.

#### Performing the pipeline


### Results
