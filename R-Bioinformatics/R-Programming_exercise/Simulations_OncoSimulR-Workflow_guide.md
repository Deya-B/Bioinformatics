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
