# Analysis pipelines

## QC and alignment refinement
### Quality assessment with FastQC
FastQC software is a quality control tool for raw sequenced data.<br>
**Input**: FastQ files<br>
**Output report**: html with plots<br>
The FastQC documentation is available [here](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/).

1. Create conda environment:
```Nushell
conda activate
conda create -n OVCA_case
conda activate OVCA_case
```

2. Install fastqc via conda:
```Nushell
conda install bioconda::fastqc
```

> [!NOTE]
> Change the following path of directories to your paths.

3. Install samtools and index the reference (will need it for later)
```Nushell
conda install bioconda::samtools

# Create dict of the fasta:
samtools dict ./REFERENCE/hg19_chr17.fa -o ./REFERENCE/hg19_chr17.dict

# Indexing fasta:
samtools faidx ./REFERENCE/hg19_chr17.fa
```

4. Perform fastqc
``` Nushell
fastqc -o {outputfolder} {PATH_TO_RAW_DATA}/*.fastq
fastqc -o ./fastqc ./Raw_data/*.fastq
```
`/*.fastq` serves so that from the file Raw_data, it takes all the fastq files that are there and processes them for fastqc. <br>
Files will be created in the output folder (in this example: `-o ./fastqc`). 
html files (reports) can be opened using web browser. 

### Alignment
1. Indexing the reference fasta with bwa
```Nushell
conda install bwa
bwa index ./REFERENCE/hg19_chr17.fa
```

2. Alignment process (we align both the normal and tumour samples)
```Nushell
# Alignment of R1 with R2 against the reference and create a new file with the result called Normal.sam in a file hanging from the working directory called /alignment.
bwa mem -R '@RG\tID:OVCA\tSM:normal' ./REFERENCE/hg19_chr17.fa ./Raw_data/WEx_Normal_R1.fastq ./Raw_data/WEx_Normal_R2.fastq > ./alignment/Normal.sam
# Same for tumour
bwa mem -R '@RG\tID:OVCA\tSM:tumour' ./REFERENCE/hg19_chr17.fa ./Raw_data/WEx_Tumour_R1.fastq ./Raw_data/WEx_Tumour_R2.fastq > ./alignment/Tumour.sam
```
### Refinement of alignment
1. Fixmate tool: https://www.htslib.org/doc/samtools-fixmate.html

	BWA sometimes misses some information on SAM records. With samtools fixmate, we can fill in this information, at the same time that we compress to .bam:
```Nushell
samtools fixmate -O bam ./alignment/Normal.sam ./alignment/Normal_fixmate.bam
samtools fixmate -O bam ./alignment/Tumour.sam ./alignment/Tumour_fixmate.bam
```

2. Flagstat: to see some statistics of the generated .bam's
```Nushell
samtools flagstat ./alignment/Normal_fixmate.bam
samtools flagstat ./alignment/Tumour_fixmate.bam
```

3. Mark/Remove duplicates: we mark/remove the duplicates (from the PCR), so the Variant Caller will ignore them:

1st we sort, using the _fixmate.bam we generate a _sorted.bam.
Sort is important to do, in order to have an ordered mapping. Because the variant caller requires that the alignment is sorted by genomic positions.

```Nushell
samtools sort -O bam -o ./alignment/Tumour_sorted.bam ./alignment/Tumour_fixmate.bam
samtools sort -O bam -o ./alignment/Normal_sorted.bam ./alignment/Normal_fixmate.bam
```

2nd removing duplicates: we use the _sorted.bam to generate a _refined.bam
```Nushell
samtools rmdup -S ./alignment/Normal_sorted.bam ./alignment/Normal_refined.bam
samtools rmdup -S ./alignment/Tumour_sorted.bam ./alignment/Tumour_refined.bam
```

4. Finally we index the refined bam's
```Nushell
samtools index ./alignment/Normal_refined.bam
samtools index ./alignment/Tumour_refined.bam
```

## Variant identification for somatic and germline small-scale (SNVs and Indels) variants using GATK:
### Variant calling for germline variants
1. Install GATK via conda:
```Nushell
conda install bioconda::gatk4
```

2. Haplotype Caller: Variant calling algorithm based on the calculation of genotype likelihoods.
- **Input**: `.bam` file(s) from which to make variant calls
- **Output**: Either a `VCF` or `GVCF` file with raw, unfiltered SNP and indel calls.<br>
	Regular VCFs must be filtered either by variant recalibration (Best Practice) or hard-filtering before use in downstream analyses. If using the GVCF workflow, the output is a GVCF file that must first be run through GenotypeGVCFs and then filtering must be done before further analysis.

**Basic mode** (no GVCF)
```Nushell
gatk HaplotypeCaller \
-R reference.fasta \		# Reference genome (FASTA)
-I preprocessed_reads.bam \	# Input file (BAM)
-O germline_variants.vcf  	# Output file (VCF)
```

To produce a reference-blocked GVCF, substitute the output filename and add:
```Nushell
-O germline_variants.g.vcf \
-ERC GVCF
```

Haplotype Caller Overview [here](hhttps://gatk.broadinstitute.org/hc/en-us/articles/360037225632-HaplotypeCaller)

We used the following paths to the required files:
```Nushell
gatk HaplotypeCaller -R ./REFERENCE/hg19_chr17.fa -I ./alignment/Normal_refined.bam -O ./vcfgermline/normal.vcf
gatk HaplotypeCaller -R ./REFERENCE/hg19_chr17.fa -I ./alignment/Tumour_refined.bam -O ./vcfgermline/tumour.vcf
```

We can have a look at the resulting files: normal.vcf, tumour.vcf
![image](https://github.com/user-attachments/assets/881eaef4-8c23-4c3a-b80f-77ffff57aee4)
Con una almohadilla se muestra el significado de cada columna: cromosoma en el que está la variante, posición genómica, ID, alelo de referencia, alelo alternativo con la mutación encontrada, score de calidad, filtros, información adicional con la anotación, formato del siguiente campo y normal. Dentro del formato, se distinguen: GT indica el genotipo, AD el número de lecturas que soporta la variante (en formato referencia, variante) y DP el total de lecturas.

3. vcf file indexing:
```Nushell
tabix -p vcf ./vcfgermline/normal.vcf
tabix -p vcf ./vcfgermline/tumour.vcf
```

4. Total count:
```Nushell
grep -c "^chr17" ./vcfgermline/normal.vcf
```
	71

### Variant calling for somatic variants: MuTect2
#### Tumour-only mode
Enter the reference fasta, the _refined.bam of the tumour and the output file: tumourOnly.vcf (to indicate that this is the tumour only mode)
```Nushell
gatk Mutect2 -R ./REFERENCE/hg19_chr17.fa -I ./alignment/Tumour_refined.bam -O ./vcfsomatic/tumourOnly.vcf
```

#### Tumour matched normal mode
Enter the reference fasta, the _refined.bam of the tumour and the normal, then -normal normal (the name of the normal used during alignment: @RG\tID:OVCA\tSM:**normal**) and the output file: TumourNormal.vcf (to indicate that this is the tumour matched normal mode)
```Nushell
gatk Mutect2 -R ./REFERENCE/hg19_chr17.fa -I ./alignment/Tumour_refined.bam -I ./alignment/Normal_refined.bam -normal normal -O ./vcfsomatic/TumourNormal.vcf
```

Count them:
```Nushell
grep -c "^chr17" ./vcfsomatic/tumourOnly.vcf
grep -c "^chr17" ./vcfsomatic/TumourNormal.vcf
```

### Variant Recalibrator
Variant recalibrator builds a recalibration model to score variant quality and then filters
by that quality. <br>
It checks the probability that a variant is a true genetic variant versus a sequencing or data processing artifact. This allows to evaluate the probability that each call is real. <br>
The result is a score called the VQSLOD that gets added to the INFO field of each
variant. <br>
This step is usually done for SNPs and INDELs separately.

GATK documentation for [variant recalibrator](https://gatk.broadinstitute.org/hc/en-us/articles/360036510892-VariantRecalibrator).

1. Variant Recalibration for the germline variants:
```Nushell
$ gatk VariantRecalibrator -R REFERENCE/hg19_chr17.fa -V ./vcfgermline/normal.vcf --resource:dbsnp,known=true,training=true,truth=true,prior=15.0Annotations/dbsnp_138.hg19_chr17.vcf.gz -an QD -an ReadPosRankSum -an FS -an SOR -mode BOTH -O ./vcfgermline/recal/normal.recal --tranches-file ./vcfgermline/recal/normal.tranches
```

2. ApplyVQSR: Va de la mano con el paso anterior. En la columna filter, anota si la variante pasa a filtro o no. Documentacion for ApplyVQSR [aquí](https://gatk.broadinstitute.org/hc/en-us/articles/360037056912-ApplyVQSR)
```Nushell
$ gatk ApplyVQSR -R REFERENCE/hg19_chr17.fa -V ./vcfgermline/normal.vcf -O ./vcfgermline/recal/normal.recalibrated --truth-sensitivity-filter-level 99.0 --tranches-file ./vcfgermline/recal/normal.tranches --recal-file ./vcfgermline/recal/normal.recal -mode BOTH
```

3. Variant filtering (Through this process, variants are not filtered, but only marked in the FILTER column. If desired, they could be filtered using further bash commands)
```Nushell
$ awk -F '\t' '{if ($0 ~ /#/ || $7 == "PASS") print}' ./vcfgermline/recal/normal.recalibrated > ./vcfgermline/recal/normal.onlypass
```

4. Count them after filtering:
```Nushell
$ grep -c "^chr17" ./vcfgermline/recal/normal.onlypass
```
	47

#### Data format cheat sheet
![image](https://github.com/user-attachments/assets/0353d06c-274a-4897-a8d7-6f6b3b335b4a)
