## Block 1: Characterizing the Genome Through NGS

### Introduction to Translational Genomics:
- Genomics has revolutionized biology, transitioning from isolated studies to system-level data-driven research.
- The **Human Genome Project (HGP)** laid foundational frameworks in sequencing technologies, bioinformatics, and industrial applications.
- Collaborative efforts and population studies have greatly advanced variant annotation but leave room for improvement.
- Current focus: Integrating DNA sequencing with molecular and epidemiological data to enhance health and disease insights.

### Sequencing Methods:
- **Sanger Sequencing**: A foundational method using chain termination with ddNTPs.
- **Next-Generation Sequencing (NGS)**: Enables massive parallel DNA sequencing, categorized into:
  - **By Synthesis**: Includes Pyrosequencing and Illumina (Cyclic Reversible Termination).
  - **By Ligation**: Utilizes methods like SOLiD and Nanoballs.
- **QPhred Score**: Measures sequencing accuracy (higher = better).
- Library preparation techniques improve error rates and quantification.

### Alignment and Formats:
- Alignment maps reads to the genome using algorithms optimized for different sequencing templates.
- Formats like **FASTQ**, **FASTA**, **SAM/BAM**, and **VCF** are essential for storing sequencing, alignment, and variant data.

### Genome Assembly and Structural Variants:
- **Whole Genome Sequencing (WGS)** provides a comprehensive genomic view but is costlier.
- Structural variations, detected via computational approaches, include CNVs, recombination errors, etc.
- Long-read sequencing dramatically enhances assembly and variant detection accuracy.

---

## Block 2: Genomic Variants – Techniques, Variant Calling, and Annotation

### Genetic Variant Analysis:
- Steps include quality control, alignment, variant calling, and annotation.
- Tools like GATK streamline somatic and germline variant analysis pipelines.
- Annotation leverages databases to filter and prioritize variants for clinical or research relevance.

---

## Block 3: Genome-Wide Association Studies (GWAS)

### Overview:
- GWAS identifies genetic variations linked to traits or diseases by studying allele frequency and phenotype relationships.
- Key steps include selecting populations, genotyping, data processing, and statistical association tests.

### Study Design:
- GWAS can be population-based (case-control) or family-based.
- Strategies address **population stratification** and covariate control for robust association detection.

### Advantages and Limitations:
- Strengths: Insights into genetic contributions to complex traits.
- Challenges: Population structure biases and the need for large sample sizes.

---

## Block 4: Molecular Epidemiology

### Topics:
- Explores biobanks, traits (monogenic to polygenic), and the role of **Polygenic Risk Scores (PRS)** in personalized medicine.
- PRS calculation involves statistical methods accounting for LD redundancy and effect size noise.

### Key Concepts:
- Differentiation between monogenic, oligogenic, and polygenic disorders.
- Techniques like Mendelian Randomization (MR) infer causal relationships using genetic variants.

### Challenges:
- Complex interplay of genomic, environmental, and phenotypic data requires advanced computational methods and robust databases.

---

### Polygenic Risk Scores (PRS) – Detailed Explanation

#### **Monogenic vs. Polygenic Disorders**
- **Monogenic Disorders**:
  - Result from mutations in a single gene.
  - Often follow Mendelian inheritance patterns (e.g., dominant, recessive, or X-linked).
  - Examples: Cystic fibrosis (CFTR gene), Huntington’s disease (HTT gene).
  - High penetrance: A mutation almost always leads to the associated phenotype or disease.
  - Relatively simpler to study and diagnose due to the single causative genetic locus.

- **Polygenic Disorders**:
  - Result from the combined influence of many genetic variants (SNPs) across the genome.
  - Each SNP has a small effect, but together they significantly increase disease risk or trait expression.
  - Often influenced by environmental and lifestyle factors, making them complex.
  - Examples: Diabetes, hypertension, and psychiatric disorders like schizophrenia.
  - Low to moderate penetrance: The presence of risk alleles increases the probability of the disorder but doesn’t guarantee it.

---

#### **What is a Polygenic Risk Score (PRS)?**
- **Definition**:
  - PRS is a quantitative measure that aggregates the effects of multiple genetic variants (SNPs) across the genome to estimate an individual's genetic predisposition to a particular trait or disease.
  - Each variant's contribution is weighted by its effect size, which is typically derived from Genome-Wide Association Studies (GWAS).

- **Importance for Personalized Medicine**:
  - **Risk Stratification**: Identifies individuals at high risk for developing specific diseases, enabling targeted interventions.
  - **Preventive Care**: Guides lifestyle or medical interventions to mitigate risk.
  - **Treatment Decisions**: Informs drug selection and therapy based on genetic predisposition.
  - **Population Health**: Assists in designing screening programs by identifying genetic subgroups.

---

#### **Calculation of PRS**
- **General Formula**:  
  \[
  PRS = \sum (\text{Effect Size of SNP} \times \text{Allele Count for SNP})
  \]
  - **Effect Size**: Typically derived from GWAS and represents the impact of a particular SNP on the trait or disease.
  - **Allele Count**: Number of risk alleles an individual carries for that SNP (0, 1, or 2).

---

#### **Challenges and Improvements in PRS Calculation**
1. **Challenges**:
   - **Redundancy by SNPs in Linkage Disequilibrium (LD)**:
     - LD refers to the non-random association of alleles at different loci.
     - Closely linked SNPs can introduce redundancy, overestimating their contribution to PRS.
   - **Noisy Effect Sizes from Limited GWAS Statistical Power**:
     - Effect sizes can be imprecise if GWAS sample sizes are small or if variants have small effect sizes.

2. **Improvements**:
   - **Reducing Redundancy and Noise**:
     - Refine SNP selection and adjust for LD structure.
     - Account for the uncertainty in effect size estimates.

---

#### **Approaches to PRS Calculation**
1. **Pruning and Thresholding (P+T)**:
   - **Pruning**:
     - Removes SNPs in high LD with each other, retaining only the most significant SNP in a region.
     - Ensures independence of SNPs used in the calculation.
   - **Thresholding**:
     - Includes only SNPs with p-values below a certain significance threshold from GWAS results.
     - Balances signal (true associations) and noise (false positives).

2. **Shrinkage Methods**:
   - Use statistical models to shrink noisy or redundant effects, improving the robustness of PRS.
   - Examples:
     - **LD Pred**:
       - Models the correlation between SNPs due to LD.
       - Adjusts effect sizes to account for shared variance.
     - **Bayesian Approaches**:
       - Incorporate prior information (e.g., effect size distributions) to better estimate SNP contributions.
   - **Advantages**:
     - Addresses both LD redundancy and noisy effect sizes.
     - Produces more accurate and reproducible PRS estimates.

---

### Applications of PRS
- **Risk Prediction**:
  - Identifying individuals at higher genetic risk for diseases like cardiovascular disease or Alzheimer’s.
- **Public Health**:
  - Tailoring health interventions based on genetic predisposition.
- **Research**:
  - Understanding the genetic architecture of complex traits.

