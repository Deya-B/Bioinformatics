To simulate other **intratumor heterogeneity (ITH)** scenarios using the **OncoSimulR** package, you can customize several parameters and elements of the simulation model, such as fitness functions, mutation rates, initial population sizes, and environmental constraints. Here's a detailed breakdown based on your example and the **OncoSimulR** documentation:

---

## 1. **Understand the Key Steps in Your Example**

The example you provided simulates a tumor with **frequency-dependent fitness effects**, where the fitness of genotypes depends on the relative frequencies of other genotypes. Here's the breakdown:

### Step 1: Define a Custom Fitness Function
```R
avc <- function (a, v, c) {
  data.frame(
    Genotype = c("WT", "GLY", "VOP", "DEF"),
    Fitness = c(
      "1",
      paste0("1 + ", a, " * (f_GLY + 1)"),
      paste0("1 + ", a, " * f_GLY + ", v, " * (f_VOP + 1) - ", c),
      paste0("1 + ", a, " * f_GLY + ", v, " * f_VOP")
    )
  )
}
```
This defines a **frequency-dependent fitness function** for four genotypes (`WT`, `GLY`, `VOP`, `DEF`):
- `a`, `v`, and `c` are parameters controlling fitness effects based on genotype frequency.
- `f_GLY` and `f_VOP` represent the relative frequencies of the `GLY` and `VOP` genotypes, respectively.

---

### Step 2: Use `allFitnessEffects`
```R
afavc <- allFitnessEffects(
  genotFitness = avc(7.5, 2, 1),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel"
)
```
This converts the fitness function into a format usable by **OncoSimulR**:
- `frequencyDependentFitness = TRUE`: Indicates that fitness is frequency-dependent.
- `frequencyType = "rel"`: Specifies relative frequency as the measure (other options include "abs" for absolute frequency).

---

### Step 3: Simulate Tumor Evolution
```R
simulation <- oncoSimulIndiv(
  afavc,
  model = "McFL",
  onlyCancer = FALSE,
  finalTime = 25,
  mu = 1e-4,
  initSize = 4000
)
```
- `model = "McFL"`: Specifies the McFarland model of tumor evolution.
- `onlyCancer = FALSE`: Includes all genotypes, not just "cancerous" ones.
- `finalTime = 25`: Simulation stops after 25 units of time.
- `mu = 1e-4`: Mutation rate.
- `initSize = 4000`: Initial population size.

---

### Step 4: Plot the Results
```R
plot(simulation, show = "genotypes", type = "line",
     ylab = "Number of individuals", main = "Heterogeneous tumours")
```
This plots the population dynamics of different genotypes over time.

---

## 2. **How to Simulate Other ITH Scenarios**

To simulate **other types of ITH**, you can modify the following aspects:

### **Scenario 1: Alter Fitness Dependencies**
Change how genotypes interact by defining new fitness relationships:
```R
new_fitness <- function(a, b) {
  data.frame(
    Genotype = c("WT", "A", "B", "AB"),
    Fitness = c(
      "1",
      paste0("1 + ", a, " * (f_A + 1)"),
      paste0("1 + ", b, " * (f_B + 1)"),
      paste0("1 + ", a, " * f_A + ", b, " * f_B")
    )
  )
}

new_af <- allFitnessEffects(
  genotFitness = new_fitness(5, 3),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel"
)
```
This models a system where two genotypes (`A` and `B`) have independent fitness effects, and their interaction (`AB`) adds combined fitness advantages.

---

### **Scenario 2: Introduce Spatial Heterogeneity**
Spatial heterogeneity can be simulated indirectly by running separate simulations with different parameters (e.g., fitness functions, mutation rates) for different regions of a tumor.

```R
region1 <- allFitnessEffects(genotFitness = avc(7, 2, 1))
region2 <- allFitnessEffects(genotFitness = avc(5, 3, 2))

simulation1 <- oncoSimulIndiv(region1, finalTime = 50, initSize = 3000)
simulation2 <- oncoSimulIndiv(region2, finalTime = 50, initSize = 3000)

# Combine and visualize the results to show spatial heterogeneity.
```

---

### **Scenario 3: Vary Mutation Rates**
ITH can also arise from different mutation rates. For example:
```R
simulation_high_mut <- oncoSimulIndiv(afavc, mu = 1e-3, finalTime = 50)
simulation_low_mut <- oncoSimulIndiv(afavc, mu = 1e-5, finalTime = 50)
```
This shows how high mutation rates increase genetic diversity, while low rates lead to more homogeneous populations.

---

### **Scenario 4: Simulate Therapy-Induced ITH**
To simulate therapy's effects:
1. Run a baseline simulation without therapy.
2. Introduce therapy by modifying the fitness of resistant genotypes.
```R
therapy_fitness <- function(a, b, res) {
  data.frame(
    Genotype = c("WT", "SENS", "RES"),
    Fitness = c(
      "1",
      paste0("1 + ", a, " * f_SENS"),
      paste0("1 + ", b, " * f_RES - ", res)
    )
  )
}

therapy_af <- allFitnessEffects(
  genotFitness = therapy_fitness(5, 3, 2),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel"
)

simulation_therapy <- oncoSimulIndiv(therapy_af, finalTime = 100, mu = 1e-4)
```
This models the evolution of therapy-sensitive (`SENS`) and therapy-resistant (`RES`) clones.

---

### **Scenario 5: Simulate Neutral Evolution**
If you want to simulate neutral evolution (no fitness advantage/disadvantage for genotypes):
```R
neutral_fitness <- data.frame(
  Genotype = c("WT", "A", "B", "C"),
  Fitness = rep("1", 4)  # All genotypes have equal fitness
)

neutral_af <- allFitnessEffects(
  genotFitness = neutral_fitness,
  frequencyDependentFitness = FALSE
)

neutral_simulation <- oncoSimulIndiv(neutral_af, finalTime = 50, mu = 1e-4)
```
This will result in genetic drift without selection.

---

## 3. **Key Parameters to Explore**
- **Fitness Relationships**: Define how genotypes interact with each other.
- **Mutation Rates (`mu`)**: Control how fast genetic diversity arises.
- **Initial Population Size (`initSize`)**: Larger populations allow for clonal interference.
- **Selective Pressures (`Fitness`)**: Adjust fitness values to model different environmental or therapeutic conditions.
- **Model Type (`model`)**: Use different models like `"McFL"`, `"Exp"`, or `"Bozic"` to explore various tumor growth dynamics.

---

## 4. **Tips for Using the Documentation**
The **OncoSimulR** documentation is rich with examples:
- Visit [OncoSimulR documentation](https://rdiaz02.github.io/OncoSimul/OncoSimulR.html).
- Look for sections on:
  - **Fitness landscapes**
  - **Frequency-dependent fitness**
  - **Phylogenetic trees**
  - **Therapy and mutation rate simulations**
- Use provided examples as templates for creating your own scenarios.

By experimenting with the above modifications, you can simulate a wide variety of ITH scenarios to explore tumor evolution under different conditions.

---
---
---


To address your request, I'll extract key information from the provided sources to focus on **intra-tumor heterogeneity (ITH)** modeling and interpretation. Below are responses based on the themes you outlined:

---

### **1. Important Parameters for Modeling ITH**

From the provided literature and general ITH modeling approaches:

#### **Biological Parameters**:
- **Mutation Rate (μ)**: Determines the rate of genetic changes in the tumor population (e.g., somatic mutations).
- **Fitness Effects of Mutations**: Includes **driver mutations** (increase fitness) and **passenger mutations** (neutral or slightly deleterious).
- **Clonal Selection Pressures**: The relative advantage/disadvantage of clones in the microenvironment.
- **Epistasis**: Interaction effects between multiple mutations.
- **Initial Tumor Size**: The starting population size affects diversity dynamics.
- **Clonal Expansion Rates**: Growth rates of different genotypes.
- **Immune Escape Parameters**: Ability of clones to evade immune surveillance.

#### **Environmental Parameters**:
- **Spatial Structure**: Tumor cells are influenced by tissue architecture, leading to spatially heterogeneous subclones.
- **Resource Availability**: Nutrients, oxygen levels, and other local constraints.
- **Treatment Pressures**: Chemotherapy/radiotherapy affects clonal composition.

#### **Simulation-Specific Parameters**:
- **Final Time**: The time horizon for simulations.
- **Sampling Frequency**: When and how samples are taken (e.g., periodic or final-state snapshots).
- **Population Size Thresholds**: Minimum detectable subclone sizes.
- **Mutation Effects Distribution**: Assumptions about how mutations affect fitness (e.g., exponential, normal).

---

### **2. Measuring Heterogeneity/Interpretation of Results**

#### **Key Metrics for Heterogeneity**:
- **Shannon Index (Diversity)**: Measures entropy in the clone population.
  \[
  H = -\sum_{i=1}^n p_i \ln(p_i)
  \]
  where \( p_i \) is the relative frequency of the \( i \)-th clone.
  
- **Simpson's Index**: Probability that two individuals randomly chosen belong to the same genotype.
- **Clonal Evenness**: Proportion of total clones with similar abundances.
- **Largest Clone Proportion**: Frequency of the dominant clone.

#### **Interpreting Results**:
- **High Shannon Index**: Indicates high genetic diversity (complex ITH).
- **Dominance by One Clone**: Suggests reduced heterogeneity, often indicative of selective sweeps.
- **Presence of Subclonal Populations**: Suggests ongoing clonal evolution and adaptation.

---

### **3. How Sampling Should Be Performed, and Why?**

#### **Key Considerations for Sampling**:
- **Temporal Sampling**: Frequent sampling captures clonal dynamics over time.
- **Spatial Sampling**: Multiple regions of the tumor should be sampled due to spatial heterogeneity.
- **Depth of Sequencing**: Deep sequencing ensures detection of rare subclones.

#### **Why Sampling Matters**:
- **Temporal Sampling**: Provides insights into evolutionary trajectories and fitness shifts.
- **Spatial Sampling**: Captures spatially segregated subclones that might evade treatment or seed metastases.
- **Depth**: Avoids bias caused by stochastic extinction of small populations during sequencing.

---

### **4. Limitations of ITH Modeling**

#### **Biological Assumptions**:
- Simplified models may ignore crucial biological factors like immune responses, microenvironmental feedback, or epigenetic changes.

#### **Parameter Estimation**:
- Real-world parameter values (e.g., mutation rates, fitness effects) are often inferred from limited datasets, introducing uncertainty.

#### **Computational Complexity**:
- Simulating large populations with complex interactions can become computationally prohibitive.

#### **Detectable Subclones**:
- Small clones may evade detection due to sequencing depth limits.

---

### **5. ITH vs. Monotypic and Non-Monotypic Populations**

#### **Monotypic Population**:
- All cells in the tumor are genetically identical (low or no ITH).
- Reflects a single dominant selective sweep or minimal evolutionary pressures.
- Less adaptive potential in changing environments (e.g., treatment).

#### **Non-Monotypic Population**:
- Tumor comprises multiple genetically distinct clones.
- High adaptability due to the coexistence of diverse subclonal populations.
- Represents typical ITH, where evolution drives tumor progression and therapy resistance.

---

### **Conclusion**

To model ITH effectively, it's crucial to integrate biological, environmental, and simulation-specific parameters, such as mutation rates, fitness landscapes, and spatial structure. Measuring heterogeneity using indices like Shannon or Simpson helps quantify ITH. Sampling strategies should be designed to capture the temporal and spatial complexity of tumors. Lastly, understanding ITH in the context of monotypic vs. non-monotypic populations helps explain evolutionary dynamics and therapeutic challenges.

Would you like more specific implementation guidance based on these principles?
