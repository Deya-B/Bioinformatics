## High or low intratumor heterogeneity
Find settings of parameters that produce the scenarios you want. Of course, you do not want one simulation, nor two or three. 
You ideally run, say, 100 or 1000 replicates of each scenario and you’d be able to say things like “In 90% of our replicates there is this much intra-tumor heterogeneity”.

Define what the things you simulate or try to see are. For example:
- what is intratumor heterogeneity?
- How do we define and compute it?
- The papers by [Diaz-Colunga and Diaz-Uriarte, 2021](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1009055), and [Diaz-Uriarte and Vasallo, 2019](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1007246), define some of these things. You might want to look at them (including their supplementary material)

You will need to sample from the simulations. 
OncoSimulR allows you to sample in different ways. 
Use the one that matters for your scenario (e.g., single cell or whole-tumor, or bulk sequencing)

El objetivo aquí es dar una serie de recetas para:
- quieres alta heterogeneidad tumoral: haz esto (o "no es posible")
- quieres alta heterogeneidad tumoral con un número muy alto de clones: haz lo otro
- quieres baja heterogeneidad pero tiempos hasta la sustitución muy largos: haz lo de más allá, etc

---

### **Definition of Intratumor Heterogeneity (ITH)**
"Cancer is the result of a gradual accumulation of somatic genetic mutations. While most of the acquired mutations are putatively neutral and have no significant effect on a cell’s phenotype, some confer a selective advantage to the host cell; they are known as driver mutations. Consequently, individual tumors are heterogeneous and typically consist of multiple populations of cells (subclones), each harboring a distinct set of driver mutations and possessing a distinct phenotype, a phenomenon known as intra-tumor heterogeneity (ITH). Detecting ITH helps identify the key events initiating the development of the disease or leading to metastasis, and allows for the determination of a tumor’s subclonal composition." (Khakabimamaghani *et al.*, 2019)

> In other words:
>
> Intratumor heterogeneity (ITH) refers to the genetic, epigenetic, and phenotypic diversity observed within tumor cell populations in a single patient. This diversity results from mutations, epigenetic changes, selection pressures, and other factors during tumor evolution. 

**Importance of ITH:**
- **High ITH**: Associated with treatment resistance, immune evasion, and poor prognosis.
- **Low ITH**: Often seen in tumors with dominant clones and more straightforward evolutionary trajectories.

---

### **Measuring ITH**

To define or compute ITH in a simulation:
1. **Genetic Diversity Metrics:**
   - **Shannon Diversity Index**: Measures the proportion of clones and their diversity.
   - **Simpson’s Diversity Index**: Emphasizes the dominance of certain clones.
   - **Richness**: Counts the number of distinct clones.
   
2. **Clonal Abundance:**
   - Analyze the proportions of clones in the population (dominant clone vs. minor clones).

3. **Homozygosity and Heterozygosity:** 
   - In OncoSimulR, homozygosity/heterozygosity can be tracked explicitly based on specific mutations in tumor suppressors and oncogenes.

---

### **Modeling High and Low ITH in OncoSimulR**

1. **High ITH:**
   - **Parameters:**
     - **Weak Selection, Strong Mutation (WSSM)**:
       - **Mutation rate (\(mu\))**: High values (e.g., \(10^{-4}\) or \(10^{-5}\)).
       - **Fitness landscape**: Neutral or shallow gradients between genotypes.
       - **Population size**: Large.
       - **Sampling model**: Single-cell sampling to capture clonal diversity.
   - **Setup:**
     ```R
     fe_high_ith <- allFitnessEffects(noIntGenes = rep(0.01, 50)) # Weak selection
     high_ith_sim <- oncoSimulIndiv(fe_high_ith,
                                    mu = 1e-4, 
                                    model = "McFL", # Moran or Wright-Fisher
                                    initSize = 1e5)
     plotClonalEvolution(high_ith_sim)  # Visualization
     ```
   - **Expected Results:** Many small clones with varying mutations. No single dominant clone.

2. **High ITH with Many Clones:**
   - Increase the number of genes or loci under consideration and their mutation rates.
   - Example:
     ```R
     fe_many_clones <- allFitnessEffects(epistasis = c("A:B" = 0.2, "B:C" = -0.1), 
                                         geneToModule = c("A" = "Gene1", 
                                                          "B" = "Gene2", 
                                                          "C" = "Gene3"))
     many_clones_sim <- oncoSimulIndiv(fe_many_clones,
                                       mu = 1e-4, 
                                       initSize = 1e6,
                                       model = "Bozic")
     plotClonalEvolution(many_clones_sim)
     ```

3. **Low ITH with Long Time to Substitution:**
   - **Parameters:**
     - **Strong Selection, Weak Mutation (SSWM)**:
       - **Mutation rate (\(mu\))**: Low values (\(10^{-8}\)).
       - **Fitness landscape**: High selection coefficients (dominant genotypes).
       - **Population size**: Small or medium.
       - **Sampling model**: Whole-tumor bulk sampling.
   - **Setup:**
     ```R
     fe_low_ith <- allFitnessEffects(noIntGenes = rep(0.2, 10)) # Strong selection
     low_ith_sim <- oncoSimulIndiv(fe_low_ith,
                                   mu = 1e-8,
                                   initSize = 1e4,
                                   model = "McFL")
     plotClonalEvolution(low_ith_sim)
     ```
   - **Expected Results:** A dominant clone, slow emergence of new clones.

---

### **Sampling in OncoSimulR**

1. **Single-Cell Sampling:**
   - Use to capture high ITH and detect rare clones.
   ```R
   sampleSingleCells(high_ith_sim, n = 100)  # 100 single cells
   ```

2. **Whole-Tumor Sampling:**
   - Provides an overview of the entire population.
   ```R
   sampleWholeTumor(low_ith_sim)
   ```

3. **Bulk Sequencing:**
   - Simulates the typical experimental setup for tumor sequencing.
   ```R
   bulk_data <- samplePopulations(high_ith_sim, timeSample = 50)
   ```

---

### **Scenarios and Recipes**

1. **High Tumor Heterogeneity:**
   - Use high mutation rates and neutral fitness landscapes.
   - **Sampling**: Single-cell sampling.

2. **High Heterogeneity with Many Clones:**
   - Large number of interacting loci.
   - **Sampling**: Single-cell or bulk sequencing.

3. **Low Heterogeneity with Long Substitution Times:**
   - Strong selection, low mutation rates.
   - **Sampling**: Whole-tumor sampling.

---

### **Limitations of OncoSimulR**

1. **High Number of Clones:**
   - Computational burden increases significantly.
   - Simplifications in fitness landscapes might be necessary.

2. **Strong Selection, Weak Mutation with High Heterogeneity:**
   - Difficult to achieve as clones tend to be replaced by fitter clones rapidly.

3. **High Epistatic Interactions:**
   - Modeling complex interaction effects can be limited by computational power.

### References for Further Understanding
- **Papers:** Use the provided DOI references for insights into modeling strategies.
- **Documentation:** Check [OncoSimulR documentation](https://rdiaz02.github.io/OncoSimul/) for parameter specifics.
