# Analysis pipelines

## QC and alignment refinement
### Quality assessment with FastQC

1. Create conda environment:
```
conda activate
conda create -n OVCA_case
```
2. Install fastqc via conda:
```
conda activate OVCA_case
conda install bioconda::fastqc
```
> [!NOTE]
> Change path of directories to your paths

3. Install samtools and index the reference (will need it for later)
```
conda install bioconda::samtools
  # Create dict del fasta:
	samtools dict ./REFERENCE/hg19_chr17.fa -o ./REFERENCE/hg19_chr17.dict
  # Indexing fasta:
	samtools faidx ./REFERENCE/hg19_chr17.fa
```

4. Perform fastqc
``` 
fastqc -o ./fastqc ./Raw_data/*.fastq
```
This /*.fastq serves so that from the file Raw_data, it takes all the fastq files that are there and processes them for fastqc.
Files will be created in the output folder (in this example: -o ./fastqc). 
html files (reports) can be opened using web browser. 

### Alignment
1. Indexing the reference fasta with bwa
```
conda install bwa
bwa index ./REFERENCE/hg19_chr17.fa
```
2. Alignment process (we align both the normal and tumour samples)
```
# Alignment of R1 with R2 against the reference and create a new file with the result called Normal.sam in a file hanging from the working directory called /alignment.
bwa mem -R '@RG\tID:OVCA\tSM:normal' ./REFERENCE/hg19_chr17.fa ./Raw_data/WEx_Normal_R1.fastq ./Raw_data/WEx_Normal_R2.fastq > ./alignment/Normal.sam
# Same for tumour
bwa mem -R '@RG\tID:OVCA\tSM:tumour' ./REFERENCE/hg19_chr17.fa ./Raw_data/WEx_Tumour_R1.fastq ./Raw_data/WEx_Tumour_R2.fastq > ./alignment/Tumour.sam
```
### Refinement of alignment
1. Fixmate tool: https://www.htslib.org/doc/samtools-fixmate.html

	BWA sometimes misses some information on SAM records. With samtools fixmate, we can fill in this information, at the same time that we compress to .bam:
```
samtools fixmate -O bam ./alignment/Normal.sam ./alignment/Normal_fixmate.bam
samtools fixmate -O bam ./alignment/Tumour.sam ./alignment/Tumour_fixmate.bam
```
2. Flagstat: to see some statistics of the generated .bam's
```
samtools flagstat ./alignment/Normal_fixmate.bam
samtools flagstat ./alignment/Tumour_fixmate.bam
```
3. Mark/Remove duplicates: we mark/remove the duplicates (from the PCR), so the Variant Caller will ignore them:

1st we sort, using the _fixmate.bam we generate a _sorted.bam.
Sort is important to do, in order to have an ordered mapping. Because the variant caller requires that the alignment is sorted by genomic positions.

```
samtools sort -O bam -o ./alignment/Tumour_sorted.bam ./alignment/Tumour_fixmate.bam
samtools sort -O bam -o ./alignment/Normal_sorted.bam ./alignment/Normal_fixmate.bam
```

2nd removing duplicates: we use the _sorted.bam to generate a _refined.bam
```
samtools rmdup -S ./alignment/Normal_sorted.bam ./alignment/Normal_refined.bam
samtools rmdup -S ./alignment/Tumour_sorted.bam ./alignment/Tumour_refined.bam
```
4. Finally we index the refined bam's
```
samtools index ./alignment/Normal_refined.bam
samtools index ./alignment/Tumour_refined.bam
```

## Variant identification for somatic and germline small-scale variants
## Variant calling for germline SNVs and Indels using GATK
1. Install GATK via conda:
```
conda install bioconda::gatk4
```
2. Haplotype Caller
```
gatk HaplotypeCaller -R ./REFERENCE/hg19_chr17.fa -I ./alignment/Normal_refined.bam -O ./vcfgermline/normal.vcf
gatk HaplotypeCaller -R ./REFERENCE/hg19_chr17.fa -I ./alignment/Tumour_refined.bam -O ./vcfgermline/tumour.vcf
```
We can have a look at the resulting files: normal.vcf, tumour.vcf

3. vcf file indexing:
```
tabix -p vcf ./vcfgermline/normal.vcf
tabix -p vcf ./vcfgermline/tumour.vcf
```
4. Total count:
```
grep -c "^chr17" ./vcfgermline/normal.vcf
```
	71

## Variant calling for somatic variants: MuTect2
### Tumour-only mode
Enter the reference fasta, the _refined.bam of the tumour and the output file: tumourOnly.vcf (to indicate that this is the tumour only mode)
```
gatk Mutect2 -R ./REFERENCE/hg19_chr17.fa -I ./alignment/Tumour_refined.bam -O ./vcfsomatic/tumourOnly.vcf
```
### Tumour matched normal mode
Enter the reference fasta, the _refined.bam of the tumour and the normal, then -normal normal (the name of the normal used during alignment: @RG\tID:OVCA\tSM:**normal**) and the output file: TumourNormal.vcf (to indicate that this is the tumour matched normal mode)
```
gatk Mutect2 -R ./REFERENCE/hg19_chr17.fa -I ./alignment/Tumour_refined.bam -I ./alignment/Normal_refined.bam -normal normal -O ./vcfsomatic/TumourNormal.vcf
```
Count them:
```
grep -c "^chr17" ./vcfsomatic/tumourOnly.vcf
grep -c "^chr17" ./vcfsomatic/TumourNormal.vcf
```

## Variant Recalibrator
1. Variant Recalibration for the germline variants:
```
$ gatk VariantRecalibrator -R REFERENCE/hg19_chr17.fa -V ./vcfgermline/normal.vcf --resource:dbsnp,known=true,training=true,truth=true,prior=15.0Annotations/dbsnp_138.hg19_chr17.vcf.gz -an QD -an ReadPosRankSum -an FS -an SOR -mode BOTH -O ./vcfgermline/recal/normal.recal --tranches-file ./vcfgermline/recal/normal.tranches
```
2. ApplyVQSR: Va de la mano con el paso anterior. En la columna filter, anota si la variante pasa a filtro o no.
```
$ gatk ApplyVQSR -R REFERENCE/hg19_chr17.fa -V ./vcfgermline/normal.vcf -O ./vcfgermline/recal/normal.recalibrated --truth-sensitivity-filter-level 99.0 --tranches-file ./vcfgermline/recal/normal.tranches --recal-file ./vcfgermline/recal/normal.recal -mode BOTH
```
3. Variant filtering (marking variants in the FILTER column)
```
$ awk -F '\t' '{if ($0 ~ /#/ || $7 == "PASS") print}' ./vcfgermline/recal/normal.recalibrated > ./vcfgermline/recal/normal.onlypass
```
4. Count them after filtering:
```
$ grep -c "^chr17" ./vcfgermline/recal/normal.onlypass
```
	47

