# RNA-Seq Analysis

**Author:** *Deyanira Borroto Alburquerque*

### Abstract

***This RNA-Seq analysis is based on 17 samples (4–5 independent biological replicates of LLI-NT, LLI-VIP, ALI-NT, and ALIVIP differentiated Caco-2 cells).***\
***"The goal of the project is to investigate the impact of liquid-liquid interface (LLI) and air-liquid interface (ALI) with addition of vasointestinal peptide (VIP) on intestinal barrier properties and mucus production of Caco-2 cell cultures. Caco-2 cells were cultured in transwell plates under LLI and ALI condition and VIP were added to basolateral compartment. LLI-NT, LLI-VIP, ALI-NT and ALI-VIP were collected and analysis using RNAseq." (https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=study&acc=SRP489490)***

**Keywords:** RNA-Seq; Next-generation sequencing; Data analysis; Differentially expressed genes

### Getting the experiment Data

The data utilized for this RNA-seq analysis was obtained from the "Air-liquid interface Caco-2 culture with vasointestinal peptide mimicks gut mucosal barrier function in permeability and bacterial infection" [study](https://pubmed.ncbi.nlm.nih.gov/39714032/).

> To get the data the GEO accession [GSE283451](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE283451) was accessed.\
> Where the Raw data available in SRA was found under the BioProject accession [PRJNA1076117](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA1076117&o=acc_s%3Aa).

#### The SRA Run Selector gives us some information of our dataset:

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

\*(selected the most relevant)

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

By clicking in Download \> `Metadata` the SraRunTable.csv is obtained.

!!! Ver como hicimos estos pasos de limpieza de la tabla de metadatos en Chipseq.

## Chapter One: Overview

Do you know the way?

------------------------------------------------------------------------

## Chapter Two: Foo

Foo is the way...

------------------------------------------------------------------------