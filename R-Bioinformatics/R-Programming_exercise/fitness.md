## PLAYING AROUND WITH FITNESS

### SPECIFIYNG FITNESS:
**OncoSimulR PRINCIPLE**: make the specification of those effects as SIMPLE and as FLEXIBLE as possible.
- Two main ways of specifying fitness:
  - Directly through fitness coefficients (**lego system of fitness effects**).
  - Indirectly via epistasis and interaction matrices (**explicit mapping** of genotypes to fitness).
```r
allFitnessEffects <- function(rT = NULL,  # un DF que crea un grafo en el que cada
                              # nodo es un gen y tiene unos efectos de
                              # fitness asociados si se cumplen unas 
                              # condiciones y otros si no se cumplen
                              epistasis = NULL, # efectos en los que el gen mutado
                              # pierde o gana ventajas en funcion
                              # de si hay otro mutado
                              orderEffects = NULL,  # dar orden de efectos
                              noIntGenes = NULL,    # genes que no interactúan
                              geneToModule = NULL,
                              drvNames = NULL,
                              keepInput = TRUE)
```

### Simple Additive Fitness
Let’s suppose you have a simple two-gene scenario, so a total of four genotypes (WT [the wild type], A, B and AB):

```r
library(OncoSimulR)
m4 <- data.frame(G = c("WT", "A", "B", "A, B"), F = c(1, 2, 3, 4))
```
Here you have a data frame with genotypes and fitness where genoytpes are specified as character vectors, with mutated genes and fitness separated by commas.

Now, let’s give that to the allFitnessEffects function:
```r
fem4 <- allFitnessEffects(genotFitness = m4)
```

To plot this, you must plot the fitness landscape:
```r
plotFitnessLandscape(evalAllGenotypes(fem4))
```
```r
############################## PLAYING AROUND! #################################
m1 <- data.frame(G = c("WT", "A", "B", "A, B"), F = c(1, 1.2, 1.5, 1.8))
fem1 <- allFitnessEffects(genotFitness = m1)
plotFitnessLandscape(evalAllGenotypes(fem1))

m2 <- data.frame(G = c("WT", "A", "B", "A, B"), F = c(1, 1.2, 1.5, 0.2))
fem2 <- allFitnessEffects(genotFitness = m2)
plotFitnessLandscape(evalAllGenotypes(fem2))

m3 <- data.frame(G = c("WT", "A", "B", "A, B"), F = c(1, 1.2, 1.5, 1))
fem3 <- allFitnessEffects(genotFitness = m3)
plotFitnessLandscape(evalAllGenotypes(fem3))

m5 <- data.frame(G = c("WT", "A", "B", "A, B"), F = c(1, 0.2, 0.8, 1.5))
fem5 <- allFitnessEffects(genotFitness = m5)
plotFitnessLandscape(evalAllGenotypes(fem5))

m6 <- data.frame(G = c("WT", "A", "B", "A, B"), F = c(0.5, 1, 1, 2))
fem6 <- allFitnessEffects(genotFitness = m6)
plotFitnessLandscape(evalAllGenotypes(fem6))
    # Observe in the graph that the WT was assigned 1 and the rest transformed
    #   accordingly...
```

Continuing with the previous example (fem4)...

Check what OncoSimulR thinks the fitnesses are, with the evalAllGenotypes function (of course, here we should see the same fitnesses we entered):
```r
evalAllGenotypes(fem4, addwt = TRUE)
```

```r
############################## PLAYING AROUND! #################################
evalAllGenotypes(fem1, addwt = TRUE)
evalAllGenotypes(fem2, addwt = TRUE)
evalAllGenotypes(fem3, addwt = TRUE)
evalAllGenotypes(fem5, addwt = TRUE)
evalAllGenotypes(fem6, addwt = TRUE) # Here shows how the genotypes were modified
 ```


### SPECIFY MAPPING using a MATRIX with g+1 (g = genes) columns:  
- Each of the first g columns contains a 1 or a 0 indicating that the gene of that column is mutated or not.
- Column g+1 contains the fitness values. 
- You DON'T need to specify all the genotypes: 
   - the missing genotypes are assigned fitness = 0 
   - the WT is assigned fitness = 1
                
The matrix `m7` is constructed as follows:
```r
m7 <- cbind(c(1, 1), c(1, 0), c(2, 3))
```

The matrix `m7` is:
```
     [,A] [,B] [,F]
[1,]    1    1    2
[2,]    1    0    3
```

#### This matrix specifies:
- **Column 1**: Mutation presence for gene A (1 = mutated, 0 = not mutated).
- **Column 2**: Mutation presence for gene B.
- **Column 3**: Fitness value of the corresponding genotype.

From this:
- **Row 1**: A and B are mutated → Fitness = 2.
- **Row 2**: A is mutated, B is not → Fitness = 3.

Additionally:
- **WT (wild type)** is the baseline genotype where no mutations are present (0, 0). If not specified, its fitness is assigned as **1** by default.

#### **Why Does Row 3 (Only B Mutated) Appear?**

The `allFitnessEffects()` function automatically **completes missing genotypes** that are not explicitly defined in the input matrix. Here's what happens:

1. **Missing Genotypes Are Assigned Default Fitness:**
   - Any genotype **not explicitly provided** is assigned a fitness of **0** (except for the WT, which is assigned 1).

2. **Default Genotypes Created:**
   - The missing genotype `(A = 0, B = 1)` (i.e., **only B is mutated**) is not in the matrix `m6`. 
   - Therefore, the program creates this genotype and assigns it a **fitness of 0**.

---

#### Expanded Output of `evalAllGenotypes`:
When you evaluate the genotypes with `evalAllGenotypes(fem6, addwt = TRUE)`, you get:
```r
#   Genotype Birth
# 1       WT     1
# 2        A     3
# 3        B     0
# 4     A, B     2
```

Each row corresponds to:
1. **WT**: Wild Type (no mutations, A = 0, B = 0) → Fitness = **1** (assigned automatically).
2. **A**: Only A mutated (A = 1, B = 0) → Fitness = **3** (from matrix).
3. **B**: Only B mutated (A = 0, B = 1) → Fitness = **0** (default, not explicitly in the matrix).
4. **A, B**: Both A and B mutated (A = 1, B = 1) → Fitness = **2** (from matrix).

---

```r
############################## PLAYING AROUND! #################################
m8 <- cbind(c(1, 1), c(0, 0), c(2, 3))
fem8 <- allFitnessEffects(genotFitness = m8)
evalAllGenotypes(fem8, addwt = TRUE)
plotFitnessLandscape(evalAllGenotypes(fem8))
#   Genotype Birth
# 1       WT     1
# 2        A     2 
# 3        B     0  
# 4     A, B     0 
        
# The matrix m8 is:
#      [,A] [,B] [,F]
# [1,]    1    0    2 - A está especificada doble, coge la primera asignacion de fitness
# [2,]    1    0    3 - B no está mutado (0,0) se le asigna 0
                    # A,B no están mutados juntos en ninguna columna, asignamos 0
                    # El fitness 3 se pierde, porque no hay mutaciones suficientes 
                        # para asignarlo

m9 <- cbind(c(1, 1), c(1, 0), c(3, 2))
fem9 <- allFitnessEffects(genotFitness = m9)
evalAllGenotypes(fem9, addwt = TRUE)
plotFitnessLandscape(evalAllGenotypes(fem9))
#   Genotype Birth
# 1       WT     1
# 2        A     2 
# 3        B     0
# 4     A, B     3

# The matrix m9 is:
#      [,A] [,B] [,F]
# [1,]    1    1    3 - A,B mutados, se asigna fitness 3
# [2,]    1    0    2 - Solo A mutado, se le asigna fitness 2
                      # Falta B por especificar = automatica asignacion de 0

m10 <- cbind(c(0, 1), c(1, 0), c(2, 3))
fem10 <- allFitnessEffects(genotFitness = m10)
evalAllGenotypes(fem10, addwt = TRUE)
plotFitnessLandscape(evalAllGenotypes(fem10))
#   Genotype Birth
# 1       WT     1
# 2        A     3
# 3        B     2
# 4     A, B     0

# The matrix m9 is:
#      [,A] [,B] [,F]
# [1,]    0    1    2 - B mutado, se le asigna 2
# [2,]    1    0    3 - A mutado, se le asigna 3
                      # A,B no especificados = asignacion de 0
```





