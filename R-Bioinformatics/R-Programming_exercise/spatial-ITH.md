### Creating a Scenario of Spatial ITH

OncoSimulR does not have direct support for spatial dynamics, as it models population growth and evolution in a well-mixed environment (i.e., no explicit spatial structure). However, you can **approximate spatial intra-tumor heterogeneity (ITH)** using the following strategies:

---

#### **1. Simulating Subpopulations with Independent Dynamics**
You can divide the tumor into multiple regions, each modeled independently. For example:
- Define different subpopulations (regions) with varying initial sizes, mutation rates, or fitness landscapes.
- Simulate each subpopulation separately using `oncoSimulIndiv`.
- Combine the results to analyze spatial heterogeneity.

**Example Code:**
```R
# Define fitness landscapes for two regions
region1 <- data.frame(Genotype = c("WT", "A", "B"),
                      Fitness = c("1",
                                  "1 + 1.5*(f_1)",
                                  "1 + 2*(f_1)"))
fe_region1 <- allFitnessEffects(genotFitness = region1,
                                frequencyDependentFitness = TRUE,
                                frequencyType = "rel")

region2 <- data.frame(Genotype = c("WT", "A", "B"),
                      Fitness = c("1",
                                  "1 + 1.8*(f_1)",
                                  "1 + 1.2*(f_1)"))
fe_region2 <- allFitnessEffects(genotFitness = region2,
                                frequencyDependentFitness = TRUE,
                                frequencyType = "rel")

# Simulate each region
set.seed(3)
out_region1 <- oncoSimulIndiv(fe_region1, model = "McFL", finalTime = 300, mu = 1e-3, initSize = 5e3)
out_region2 <- oncoSimulIndiv(fe_region2, model = "McFL", finalTime = 300, mu = 1e-3, initSize = 5e3)

# Combine and compare results
plot(out_region1, show = "genotypes", addtot = TRUE, main = "Region 1")
plot(out_region2, show = "genotypes", addtot = TRUE, main = "Region 2")
```

---

#### **2. Introducing Migration Between Regions**
To model **interaction between spatial regions** (e.g., migration):
- Run separate simulations for each region.
- At specific intervals, exchange a fraction of cells between regions.
- Update the population sizes and fitness effects accordingly.

You can implement this manually by:
- Extracting population data using `oncoSimulIndiv()` outputs (e.g., `out$pops.by.time`).
- Redistributing clones between regions periodically.

---

#### **3. Use Alternative Tools for Spatial Modeling**
If spatial dynamics are critical to your analysis:
- Consider tools specifically designed for spatial simulations, such as **GillespieSSA**, **Cellular Potts Models (CPMs)** (e.g., in CompuCell3D), or **agent-based models** like Morpheus.
- Integrate these tools with OncoSimulR by using fitness landscapes generated in OncoSimulR.

---

### Limitations of OncoSimulR for Modeling ITH

1. **Lack of Explicit Spatial Dynamics:**
   - OncoSimulR assumes a well-mixed population, so it does not simulate spatial heterogeneity or localized interactions directly.

2. **Homogeneous Environment:**
   - The fitness effects and mutation rates are uniform across the population, which might not reflect spatially distinct microenvironments.

3. **No Explicit Microenvironment Interactions:**
   - The tool does not model interactions between clones and their local environments (e.g., hypoxia, nutrient gradients).

4. **Simplistic Mutation Model:**
   - OncoSimulR uses a simplified mutation process that may not capture the complexity of real tumor evolution, especially in spatially heterogeneous contexts.

5. **No Explicit Cell Types:**
   - The model treats populations as genotypes without differentiating between cell types or phenotypes.

6. **Resource Competition is Implicit:**
   - While the McFL model incorporates competition, it does so implicitly, without modeling explicit interactions for limited resources.

---

### Overcoming These Limitations

1. **Combine Tools:**
   - Use OncoSimulR to simulate evolutionary dynamics and integrate its outputs with spatially explicit models.

2. **Run Subpopulation Simulations:**
   - Use the subpopulation strategy described above to approximate spatial heterogeneity.

3. **Custom Scripts:**
   - Develop custom scripts to introduce spatial structure or simulate resource gradients.

4. **Agent-Based Models (ABMs):**
   - Combine OncoSimulR results with agent-based models for finer control over spatial interactions and microenvironment dynamics.

---

### Conclusion

OncoSimulR is highly flexible for modeling evolutionary dynamics and clonal competition, making it well-suited for **well-mixed scenarios of ITH**. However, its lack of explicit spatial modeling limits its applicability for detailed spatial heterogeneity studies. For spatially complex scenarios, integrating OncoSimulR with specialized spatial simulation tools is recommended.
