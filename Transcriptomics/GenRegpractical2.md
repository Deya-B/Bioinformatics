### Objetivo:
cellmarkfiletable – A tab delimited file each row contains the cell type or other identifier for a groups of marks,
then the associated mark, then the name of a bed file, and optionally a corresponding control bed file:

```
cell1 mark1 cell1_mark1.bed cell1_control.bed
cell1 mark2 cell1_mark2.bed cell1_control.bed
cell2 mark1 cell2_mark1.bed cell2_control.bed
cell2 mark2 cell2_mark2.bed cell2_control.bed
```

#### Extracting cases:
Tried the following with results:
```
less archivos.tar.gz | awk '/archivos\/w/ {print  $6}'
archivos/wgEncodeBroadHistoneMonocd14ro1746CtcfAlnRep1_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746CtcfAlnRep2_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K04me1AlnRep1_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K04me1AlnRep2_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K04me3AlnRep1_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K04me3AlnRep2_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K09me3AlnRep1_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K09me3AlnRep2_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K27acAlnRep1_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K27acAlnRep2_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K27me3AlnRep1_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K27me3AlnRep2_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K36me3AlnRep1_RM_chr16.bed.gz
archivos/wgEncodeBroadHistoneMonocd14ro1746H3K36me3AlnRep2_RM_chr16.bed.gz
```

Improved with cut:
```
less archivos.tar.gz | awk '/archivos\/w/ {print  $6}' | cut -d "/" -f2
less archivos.tar.gz | awk '/archivos\/w/ {print  $6}' | cut -d "/" -f2 > cases.txt

wgEncodeBroadHistoneMonocd14ro1746CtcfAlnRep1_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746CtcfAlnRep2_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K04me1AlnRep1_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K04me1AlnRep2_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K04me3AlnRep1_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K04me3AlnRep2_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K09me3AlnRep1_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K09me3AlnRep2_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K27acAlnRep1_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K27acAlnRep2_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K27me3AlnRep1_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K27me3AlnRep2_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K36me3AlnRep1_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746H3K36me3AlnRep2_RM_chr16.bed.gz
```

Tried with the following, but the unique part was not extracted:
```
awk -F'/' '{split($2, a, "_"); print a[1]}' test2.txt
wgEncodeBroadHistoneMonocd14ro1746CtcfAlnRep1
wgEncodeBroadHistoneMonocd14ro1746CtcfAlnRep2
wgEncodeBroadHistoneMonocd14ro1746H3K04me1AlnRep1
wgEncodeBroadHistoneMonocd14ro1746H3K04me1AlnRep2
wgEncodeBroadHistoneMonocd14ro1746H3K04me3AlnRep1
wgEncodeBroadHistoneMonocd14ro1746H3K04me3AlnRep2
wgEncodeBroadHistoneMonocd14ro1746H3K09me3AlnRep1
wgEncodeBroadHistoneMonocd14ro1746H3K09me3AlnRep2
wgEncodeBroadHistoneMonocd14ro1746H3K27acAlnRep1
wgEncodeBroadHistoneMonocd14ro1746H3K27acAlnRep2
wgEncodeBroadHistoneMonocd14ro1746H3K27me3AlnRep1
wgEncodeBroadHistoneMonocd14ro1746H3K27me3AlnRep2
wgEncodeBroadHistoneMonocd14ro1746H3K36me3AlnRep1
wgEncodeBroadHistoneMonocd14ro1746H3K36me3AlnRep2
```

With sed it was possible to get it:
```
sed -E 's#^archivos/wgEncodeBroadHistoneMonocd14ro1746([^Aln]+).*#\1#' test2.txt > id.txt
Ctcf
Ctcf
H3K04me1
H3K04me1
H3K04me3
H3K04me3
H3K09me3
H3K09me3
H3K27ac
H3K27ac
H3K27me3
H3K27me3
H3K36me3
H3K36me3
```

- **Explicación**:
  - `-E`: Habilita expresiones regulares extendidas.
  - `s#^archivos/wgEncodeBroadHistoneMonocd14ro1746([^Aln]+).*#\1#`: Busca el patrón y extrae la parte única que precede a Aln.
    - `^archivos/wgEncodeBroadHistoneMonocd14ro1746`: Coincide con el prefijo de la línea.
    - `([^_]+)`: Captura la parte única (todo hasta el primer `_`).
    - `.*`: Coincide con el resto de la línea.
    - `\1`: Reemplaza la línea completa con la parte capturada.

```
sed -E 's#^.*(Rep[12]).*#\1#' test2.txt
sed -E 's#^.*(Rep[12]).*#\1#' test2.txt > rep.txt

Rep1
Rep2
Rep1
Rep2
Rep1
Rep2
Rep1
Rep2
Rep1
Rep2
Rep1
Rep2
Rep1
Rep2
```

#### Extracting controls: 
```
less input.tar.gz | awk '/input\/w/ {print  $6}' | cut -d "/" -f2
wgEncodeBroadHistoneMonocd14ro1746ControlAlnRep1_RM_chr16.bed.gz
wgEncodeBroadHistoneMonocd14ro1746ControlAlnRep2_RM_chr16.bed.gz

less input.tar.gz | awk '/input\/w/ {print  $6}' | cut -d "/" -f2 > controls.txt
```

---


### All in a script
```
#!/bin/bash

## ChromHMM SETUP

# Create file hg19_chr16.txt in CHROMSIZES folder
cd /home/deya/2TRREP-Transcriptomica/Genomic_Regulation/ChromHMM/CHROMSIZES
echo "chr16 90354753" > hg19_chr16.txt

# Create the file config_chromHmm_bin.txt as described in the manual page 6
cd /home/deya/2TRREP-Transcriptomica/Genomic_Regulation

## Get cases:
less archivos.tar.gz | awk '/archivos\/w/ {print  $6}' | cut -d "/" -f2 > testcases.txt
sed -E 's#^wgEncodeBroadHistoneMonocd14ro1746([^Aln]+).*#\1#' testcases.txt > testid.txt
sed -E 's#^.*(Rep[12]).*#\1#' testcases.txt > testrep.txt

## Get controls:
less input.tar.gz | awk '/input\/w/ {print  $6}' | cut -d "/" -f2 > testcontrols.txt

## Join columns:
paste testid.txt testrep.txt testcases.txt > TESTconfig_chromHmm_bin.txt

## The controls were entered manually into Rep1 and Rep2
## Maybe include with if cut -d "\t" f-2 == Rep1 > paste line 1 from controlfile.txt 
# in last column else paste line 2...
```
