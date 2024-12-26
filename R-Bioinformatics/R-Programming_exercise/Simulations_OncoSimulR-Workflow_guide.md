# “A recipe book for simulations with OncoSimulR” 
(section 5) requires judiciously reading a large paper and understanding what are interesting scenarios to simulate. And, then, becoming familiar with OncoSimulR and running a bunch of simulations.

# Getting started
## 1. Setting Up GitHub
1. Create a GitHub Account.
2. Fork the OncoSimulR Repository:
  - Go to the OncoSimulR GitHub page.
  - Click the "Fork" button to create a copy in your GitHub account.
3. Clone Your Fork Locally.
4. Set Up Remote for Updates. Add the original repository as the upstream remote.

## 2. Installing Dependencies
Install OncoSimulR from Bioconductor:
Installing from Bioconductor ensures all dependencies are met:
```R
# R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("OncoSimulR")
```
or from Linux or other Unixes (Macs), install from GitHub as follows:
```
if (!require("devtools"))
    install.packages("devtools") ## if you don't have it already
library(devtools)
install_github("rdiaz02/OncoSimul/OncoSimulR", 
               dependencies = TRUE)
```
(setting `dependencies = TRUE` ensures that "Suggests" are also installed).

---

# Steps that follow
## 1. Familiarizing with OncoSimulR
Understand the Basics:
- Read the documentation from [OncoSimulR's BioConductor page](https://www.bioconductor.org/packages/devel/bioc/html/OncoSimulR.html), or directly on the [documentation HTML](https://rdiaz02.github.io/OncoSimul/OncoSimulR.html).
- Review examples and vignettes from the documentation or from R itself doing:
  ```
  # R
  browseVignettes("OncoSimulR"). 
  ```
- The best place to start is the vignette created from the [`OncoSimulR/vignettes/OncoSimulR.Rnw`](https://github.com/rdiaz02/OncoSimul/blob/master/OncoSimulR/vignettes/OncoSimulR.Rmd) file that includes both text and code. 
- Review Relevant Literature:
    - Check the following papers (focusing on intra-tumor heterogeneity, mutation rates, and sampling strategies):
      1. [**A picture guide to cancer progression and monotonic accumulation models: Evolutionary assumptions, plausible interpretations, and alternative uses**](https://doi.org/10.48550/arXiv.2312.06824)
      2. [Conditional prediction of consecutive tumor evolution using cancer progression models: What genotype comes next? Plos Computational Biology](https://doi.org/10.1371/journal.pcbi.1009055)
      3. [Every which way? on predicting tumor evolution using cancer progression models. Plos Computational Biology](https://doi.org/10.1371/journal.pcbi.1007246)

## 2. Running Simulations
A big rule is to start small:
- Try simple simulations using example models provided in the vignettes.
- Modify parameters incrementally.
Consider scenarios outlined in the project specs (e.g., heterogeneity, SSWM).

<!--
## Project Reporting
Final Deliverables:
- Code repository on GitHub.
- Detailed presentation summarizing results.
- Simulated scenarios and parameter explanations (as described in Section 5 of the project file).
Documentation:
- Include clear descriptions of simulations and their interpretations in the repository (e.g., via a README.md).
-->

---

# Basics of OncoSimulR
OncoSimulR is an R package designed to simulate cancer evolution under different mutation and selection dynamics. It is particularly useful for studying processes such as tumor heterogeneity, clonal dynamics, and fitness landscapes. Here's a breakdown of the key components:

## 1. Fitness Landscapes
Definition:
- In cancer biology, fitness represents the ability of a cell (or genotype) to survive, proliferate, and pass on its genetic material.
- Higher fitness means a genotype is more likely to dominate the population.

Fitness in OncoSimulR:
- You define fitness values based on genotypes or specific mutations.
- Fitness landscapes can be additive (fitness is summed across mutations) or epistatic (interactions between mutations influence fitness).

Example:
```R
fitness_table <- data.frame(
  Genotype = c("WT", "A", "B", "A, B"),
  Fitness = c(1, 1.2, 0.8, 1.5)
)
```
Here, mutation A increases fitness to 1.2, while B alone decreases it to 0.8. The combination of A and B has a synergistic effect (fitness = 1.5).

## 2. Mutations
Mutations are the driver of genetic diversity in tumor populations.

OncoSimulR allows:
- Specifying mutation rates for individual genes.
- Simulating the impact of mutations on fitness.
```R
mutator <- allFitnessEffects(
  genotFitness = fitness_table,
  mutationRates = c(A = 1e-6, B = 2e-6)
)
```
## 3. Simulation Dynamics
OncoSimulR simulates tumor growth over time by tracking:
- Clones: Subpopulations of cells with distinct genotypes.
- Fitness dynamics: How fitness landscapes affect clonal expansion.
- Mutation acquisition: The accumulation of mutations over generations.

Types of Simulations:
- McFarland model: Simulates the effect of deleterious mutations in cancer progression.
- Continuous models: Simulates clonal dynamics under fitness constraints.

## Example Workflow in OncoSimulR
Define the Fitness Landscape:
```R
fitness_table <- data.frame(
  Genotype = c("WT", "A", "B", "A, B"),
  Fitness = c(1, 1.1, 0.9, 1.3)
)
```
Use the `allFitnessEffects()` function to build the model.

Simulate Tumor Evolution:
```R
mutator <- allFitnessEffects(
  genotFitness = fitness_table,
  mutationRates = c(A = 1e-6, B = 2e-6)
)

sim <- oncoSimulIndiv(mutator, model = "McFL", finalTime = 1000)
```

Visualize Results:
```R
plotClones(sim)
plotDrivers(sim)
```

## Understanding Fitness
Fitness in the context of cancer evolution refers to the capacity of a genotype to outcompete others in the tumor microenvironment. It encapsulates:
- Proliferation rate: Faster-dividing cells have a higher fitness.
- Survival: Cells that resist apoptosis or evade immune detection are fitter.
- Adaptation: Cells that adapt to hypoxia or therapy have selective advantages.

### Why Fitness Matters in Cancer Simulations
**Tumor Heterogeneity:**
- Tumors comprise multiple clones with varying fitness levels.
- Understanding fitness differences explains why some clones dominate.

**Treatment Resistance:**
- High-fitness clones may evolve resistance to therapies.
- Predicting these clones can guide combination therapies.

**Epistasis:**
- Interactions between mutations can alter fitness.
- Modeling these interactions helps in understanding synergistic or antagonistic effects.


---
Step-by-Step Guide to Using OncoSimulR
---
### 1. Designing a Simple Model in OncoSimulR
OncoSimulR simulates tumor progression by specifying:
- **Fitness effects** for mutations.
- **Genotype-phenotype relationships** (G -> P mapping).
- **Population dynamics** using different evolutionary models.

#### a. Specifying Fitness Effects
Fitness effects determine how advantageous or disadvantageous mutations are. <br>
They are the core of OncoSimulR's simulations. <br>
It's important to make them **simple but flexible**, to be able to simulate many different situations. <br>
The two main ways to specify them are:
- Directly through fitness coefficients.
- Indirectly via epistasis and interaction matrices.

**Example 1: Simple Additive Fitness**
```R
library(OncoSimulR)
fitness_matrix <- allFitnessEffects(genotFitness = c("WT" = 1, "A" = 1.2, "B" = 1.5, "A:B" = 1.8))

### The previous is a wrong way to insert fitness, either a matrix or a df must be provided.
# Was converted into a matrix:

matrix1 = cbind(c(1, 0, 1), c(0, 1, 1), c(1.2, 1.5, 1.8))
fm1 <- allFitnessEffects(genotFitness = matrix1)
evalAllGenotypes(fm1, addwt = TRUE)
plotFitnessLandscape(evalAllGenotypes(fm1))
```
Here:
- "WT" (wild type) has a baseline fitness of 1.
- Mutations A and B independently increase fitness.
- A:B represents a synergistic effect when both mutations are present.

**Example 2: Epistasis and Constraints**
```R
fitness_matrix <- allFitnessEffects(epistasis = c("A:B" = 1.3),
                                    orderEffects = c("A > B" = 1.1),
                                    noIntGenes = c("C" = 0.9))
```
Here:
- **Epistasis** between A and B boosts their combined fitness to 1.3. Epistasis is used to indicate when a mutated gene can loose or gain advantage in function of another mutation (mutated gene). This parameter is a list of expressions, each of these has an associated fitness input.

  Other examples of `epistasis` include:
  ```R
  fe <- allFitnessEffects(epistasis = c("A:-B" = 0.1, "B:-A" = 0.4, "A : B" = 0.2,
                                        "C:-A:-B" = 0.5, "C:A" =-0.5, "C:B"=0.4))
  evalAllGenotypes(fe, order = FALSE)
  ## Genotype Fitness
  ##1       A    1.10
  ##2       B    1.40
  ##3       C    1.50
  ##4    A, B    1.20
  ##5    A, C    0.55
  ##6    B, C    1.96
  ##7 A, B, C    0.84
  ```

  
- **Order effects**: A > B implies B is only advantageous if A has occurred.
- **No interaction genes**: C reduces fitness by 10%. **Genes without interactions**. This parameter is a list of genes, each of them will be associated to their fitness input if they are mutated.

    Other examples of `noIntGenes` are:
    
  - Here we indicate the fitness effects with the function `allFitnessEffects` and the function `evalAllGenotypes` help us to evaluate the fitness of all possible genotypes.
  ```R
  fe <- allFitnessEffects(noIntGenes = c("A" = -0.03, "B" = 0.05, "C" = 0.08))

  evalAllGenotypes(fe, order = FALSE)
  ```

  - This is a simple scenario. Each gene $i$ has a fitness effect $s_i$ if mutated. We used three genes with no order effects.
  ```R
  ai1 <- evalAllGenotypes(allFitnessEffects(
      noIntGenes = c(0.05, -.2, .1), frequencyDependentFitness = FALSE), order = FALSE)
  ai1
  ##   Genotype Fitness
  ## 1        1   1.050
  ## 2        2   0.800
  ## 3        3   1.100
  ## 4     1, 2   0.840
  ## 5     1, 3   1.155
  ## 6     2, 3   0.880
  ## 7  1, 2, 3   0.924
  ## Estos resultados consisten en lo siguiente:
  all(ai1[, "Fitness"]  == c( (1 + .05), (1 - .2), (1 + .1),
                              (1 + .05) * (1 - .2),
                              (1 + .05) * (1 + .1),
                              (1 - .2) * (1 + .1),
                              (1 + .05) * (1 - .2) * (1 + .1)))
  ```

  - In the following example we can see that the results using order effects make no difference. The results are the same as previously calculated, and the order of $x$, $y$, $z$ does not affect the outcome (always 0.924). The meaning of the notation in the output table is as follows: “WT” denotes the wild-type, or non-mutated clone. The notation $x>y$ means that a mutation in $“x“$ happened before a mutation in $“y”$. A genotype $x>y - z$ means that a mutation in $“x”$ happened before a mutation in $“y”$; there is also a mutation in $“z”$, but that is a gene for which order does not matter.

  ```R
  (ai2 <- evalAllGenotypes(allFitnessEffects(
      noIntGenes = c(0.05, -.2, .1)), order = TRUE,
      addwt = TRUE))
  ##     Genotype Birth
  ## 1         WT 1.000
  ## 2          1 1.050
  ## 3          2 0.800
  ## 4          3 1.100
  ## 5      1 > 2 0.840
  ## 6      1 > 3 1.155
  ## 7      2 > 1 0.840
  ## 8      2 > 3 0.880
  ## 9      3 > 1 1.155
  ## 10     3 > 2 0.880
  ## 11 1 > 2 > 3 0.924
  ## 12 1 > 3 > 2 0.924
  ## 13 2 > 1 > 3 0.924
  ## 14 2 > 3 > 1 0.924
  ## 15 3 > 1 > 2 0.924
  ## 16 3 > 2 > 1 0.924
  
  ```

#### b. Simulating Cancer Progression
Once fitness effects are specified, simulate progression using:
- oncoSimulIndiv() for single simulations.
- oncoSimulPop() for multiple replicates.

**Example: Simple Simulation**
```R
sim <- oncoSimulIndiv(fitness_matrix, 
                      model = "Exp", 
                      mu = 1e-6, 
                      detectionDrivers = 3)
plot(sim)
```
- model = "Exp": Exponential growth.
- mu = 1e-6: Mutation rate.
- detectionDrivers = 3: Stop simulation when 3 driver mutations occur.


---
Advanced Models
---

### 2. High Intratumour Heterogeneity
To model heterogeneity:
- Increase the **mutation rate** (mu).
- Allow for **large populations and diverse genotypes**.
- Specify **interaction networks** to allow co-occurrence of many mutations.

**Example: High Heterogeneity**
```R
fitness_matrix <- allFitnessEffects(genotFitness = c("WT" = 1, 
                                                     "A" = 1.1, 
                                                     "B" = 1.2, 
                                                     "C" = 1.15, 
                                                     "A:B" = 1.3, 
                                                     "A:C" = 1.25))

sim <- oncoSimulIndiv(fitness_matrix, 
                      model = "McFL", 
                      mu = 1e-5, 
                      initSize = 1e6, 
                      finalTime = 200)
plot(sim)
```
- **model = "McFL"**: McFarland logistic model, suitable for modeling competition among subclones.
- **initSize = 1e6**: Initial population size.
- **mu = 1e-5**: Elevated mutation rate.


### 3. Low Heterogeneity with Long Time to Substitution
To achieve this:
- Reduce mutation rates.
- Introduce strong selective bottlenecks or constraints on fitness.

**Example: Low Heterogeneity**
```R
fitness_matrix <- allFitnessEffects(orderEffects = c("A > B" = 1.2, 
                                                     "B > C" = 1.1))

sim <- oncoSimulIndiv(fitness_matrix, 
                      model = "Bozic", 
                      mu = 1e-7, 
                      initSize = 100, 
                      detectionDrivers = 3)
plot(sim)

```
- **model = "Bozic"**: Linear growth, often used for modeling slow-growing tumors.
- **mu = 1e-7**: Very low mutation rate.


### 3. Modeling SSWM, SSSM, and WSSM Scenarios
#### 3.1 Strong Selection, Weak Mutation (SSWM)
- **Characteristics**: Rare mutations; each mutation fixes before the next one appears.
- **Modeling Strategy**:
  - Use **low mutation rates** (e.g., $𝜇=10^{−8}$).
  - Set **fitness effects for drivers** significantly **higher** than neutral.

**Example: SSWM**
```R
fitness_matrix <- allFitnessEffects(genotFitness = c("WT" = 1, 
                                                     "A" = 1.5, 
                                                     "B" = 2.0))
sim <- oncoSimulIndiv(fitness_matrix, 
                      model = "Exp", 
                      mu = 1e-8)
plot(sim)
```

#### 3.2 Strong Selection, Strong Mutation (SSSM)
- **Characteristics**: High mutation rates; rapid fixation of beneficial mutations.
- **Modeling Strategy**:
  - Use high mutation rates (e.g., $𝜇=10^{−5}$).
  - Allow multiple advantageous mutations to co-exist.

**Example: SSSM**
```R
fitness_matrix <- allFitnessEffects(genotFitness = c("WT" = 1, 
                                                     "A" = 1.2, 
                                                     "B" = 1.4, 
                                                     "A:B" = 2.0))
sim <- oncoSimulIndiv(fitness_matrix, 
                      model = "McFL", 
                      mu = 1e-5)
plot(sim)
```

#### 3.3 Weak Selection, Strong Mutation (WSSM)
- **Characteristics**: High mutation rates; minimal fitness differences among mutations.
- **Modeling Strategy**:
  - Use high mutation rates but keep fitness effects close to neutral.
  - Simulate high heterogeneity with neutral or nearly neutral evolution.

**Example: WSSM**
```R
fitness_matrix <- allFitnessEffects(genotFitness = c("WT" = 1, 
                                                     "A" = 1.01, 
                                                     "B" = 1.02, 
                                                     "C" = 1.03))
sim <- oncoSimulIndiv(fitness_matrix, 
                      model = "Exp", 
                      mu = 1e-4, 
                      initSize = 1e6, 
                      finalTime = 500)
plot(sim)
```

---

### Scenarios That Are Hard or Impossible to Model
1. **Very High Clonal Diversity**: OncoSimulR handles up to thousands of clones effectively, but extreme cases might require simplifying assumptions or aggregating clones.
2. **Neutral Evolution**: Direct modeling of purely neutral evolution is challenging because OncoSimulR assumes fitness-based evolution.
3. **Spatial Tumor Evolution**: OncoSimulR does not explicitly model spatial constraints. Use other tools like **Cellular Automata** for this.

### Summary Table
<img title="Summary table" alt="table" src="https://github.com/user-attachments/assets/499e5c78-369f-43ac-b78a-cccc8b3efab3" width="600">

```R

```



```R

```
