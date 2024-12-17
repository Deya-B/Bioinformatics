## Getting started
### Setting Up GitHub
1. Create a GitHub Account (if you don’t have one).
2. Fork the OncoSimulR Repository:
  - Go to the OncoSimulR GitHub page.
  - Click the "Fork" button to create a copy in your GitHub account.
3. Clone Your Fork Locally.
4. Set Up Remote for Updates. Add the original repository as the upstream remote.

### Installing Dependencies
Install OncoSimulR from Bioconductor:
Installing from Bioconductor ensures all dependencies are met:
```R
# R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("OncoSimulR")
```
## Steps that follow
### Familiarizing with OncoSimulR
Understand the Basics:
- Read the documentation.
- Review examples and vignettes: browseVignettes("OncoSimulR").
- Review Relevant Literature:
    - Check papers cited in the project file, focusing on intra-tumor heterogeneity, mutation rates, and sampling strategies.

### Running Simulations
Start small:
- Try simple simulations using example models provided in the vignettes.
- Modify parameters incrementally.
Consider scenarios outlined in the project specs (e.g., heterogeneity, SSWM).

### Project Reporting
Final Deliverables:
- Code repository on GitHub.
- Detailed presentation summarizing results.
- Simulated scenarios and parameter explanations (as described in Section 5 of the project file).
Documentation:
- Include clear descriptions of simulations and their interpretations in the repository (e.g., via a README.md).
