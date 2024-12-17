# Statistics with R
## 1. Types of data
Los datos pueden medirse en diferentes escalas. De "menos información a más información" podemos organizar las escalas de esta manera:

1. **Escala nominal o categórica**: Utilizamos una escala que simplemente diferencia las distintas clases. Por ejemplo, podemos clasificar algunos objetos por aquí, 
``ordenador, pizarra, lápiz,`` y podemos asignarles números (1 al ordenador, 2 a la pizarra, etc.), pero los números no tienen significado *per se*. 
Datos biológicos en una escala nominal: los elementos del genoma - O numera los aminoácidos del 1 (alanina) al 20 (valina).
Por supuesto, se puede contar cuántos son del tipo 1 (cuántos son alaninas), etc., pero no tendría sentido hacer promedios y decir «su composición media de AA es de 13,5».
    - **Binario**: los datos están en una escala nominal con sólo dos clases: muerto o vivo (y podemos dar un 0 o un 1 a cualquiera de ellas), ``hombre o mujer,`` etc.

2. **Escala ordinal**: Los datos pueden ordenarse en el sentido de que se puede decir que algo es mayor o menor que otra cosa.
Por ejemplo, ordenar preferencia por la comida: ``chocolate > jamón serrano > grillos tostados > hígado``.
Podrías asignar el valor 1 al chocolate (tu alimento preferido) y un 4 al hígado (el menos preferido),
pero las diferencias o proporciones entre esos números no tienen ningún significado.

3. **Escala de intervalos o de proporciones** Se pueden tomar diferencias y proporciones, y sí que tienen significado.
   Si un sujeto tiene un valor de 6 para la expresión del gen PTEN, otro un valor de 3, y otro un valor de 1, entonces
   el primero tiene seis veces más ARN de PTEN que el último, y dos veces más que el segundo.

## 2. Looking at Data plots:
We first need to import the data:
```
dp53 <- read.table("P53.txt", header = TRUE, stringsAsFactors = TRUE)
```
Notice the ```stringsAsFactors = TRUE:``` we want the strings to be turned into factors, so we ask for it.
### 2.1 Plots to do: 
Make sure you do the following plots:
* Histogram for each gene, using condition (“cond”) as the conditioning or grouping variable (“Plot by:”).
* Boxplot, using condition (“cond”) as the conditioning or grouping variable (“Plot by:”).
* Plot of means (and make sure you get nicer axes labels).
* Stripchart, and make sure you use “jitter”, not “stack”: can you tell for which one of the variables this matters a lot?
* Density plots (“Density estimates”)


### Degrees of Freedom (df):
---
- Degrees of freedom are the number of pieces of information we have to estimate a population's values.
- Degrees of freedom tell us how many parameters we've estimated, via the spent degrees of freedom.
- Degrees of freedom also tell us how many of our data points are allowed to vary, we call these free. And when they are free to vary, we can test how impressive our model is. If there are no degrees of freedom left in a model, we can't possibly test how well that model works. With many degrees of freedom left we have ample opportunity to test how good our model is.

**Why Are Degrees of Freedom Important?**
1. Statistical Inference: Degrees of freedom are used to calculate critical values from statistical distributions (e.g., t-distribution, chi-square distribution).
2. Model Complexity: Higher degrees of freedom often indicate more flexibility in the model, while lower degrees of freedom imply stricter constraints.

**General Formula for Degrees of Freedom**
The formula depends on the context and the type of statistical test or analysis being performed. A general idea is:

> df = Number of observations or parameters − Number of constraints or estimated parameters

### Extracting the degrees of freedom:
---
#### 1. One-Sample t-Test

Goal: Compare the mean of one sample to a known value. <br/>

$$df = n − 1$$

**Why?:** You lose 1 degree of freedom because you estimate the sample mean.

#### 2.1 Two-Sample t-Test (Independent Samples)

Goal: Compare means of two independent groups. <br/>
Formula (Equal Variances Assumed): 

$$df = n_1 + n_2 − 2 = 𝑁-2$$

**Why?:** You lose 1 df for each group's mean estimation (2 total).

Formula (Unequal Variances, Welch's t-test): (its a complex formula approximating df when variances differ.)

#### 2.2 Two-Sample t-Test (Paired Samples)

Goal: Compare means of paired groups. <br/>
Formula (Equal Variances Assumed): 

$$df = \frac{𝑁-2}{2}$$ 

Where 𝑁 = Total number of observations

#### 3. ANOVA

Goal: Compare means across multiple groups.

- **Between-Group Degrees of Freedom:** $$df between = 𝑘 − 1$$ <br/>
Where 𝑘 = number of groups

- **Within-Group Degrees of Freedom:** $$df within = 𝑁 − 𝑘$$ <br/>
Where 𝑁 = Total number of observations, 𝑘 = Number of groups.

#### 4. Chi-Square Test

Goal: Test the independence or goodness-of-fit of categorical data.

- **Formula (Goodness-of-Fit):** $$df = 𝑘 − 1$$ <br/>
Where 𝑘 = Number of categories.

- **Formula (Test of Independence):** $$df=(r−1)(c−1)$$ <br/>
Where 𝑟 = Rows, 𝑐 = Columns.

#### 5. Regression Analysis

Goal: Analyze relationships between variables.

- **Model Degrees of Freedom:** $$df model = 𝑘 $$ <br/>
Where 𝑘 = Number of predictors.

- **Residual Degrees of Freedom:** $$df residual =𝑛−𝑘−1$$ <br/>
Where 𝑛 = Total number of observations.
---
\***Key Points to Remember**

1. Degrees of freedom decrease with the number of parameters estimated: Each parameter estimation reduces flexibility.
2. df affects critical values: The shape of the t-, F-, and chi-square distributions depends on df.
3. Interpretation: Higher df often lead to narrower confidence intervals and more precise estimates.

By understanding how to calculate and interpret degrees of freedom, you can better design experiments, analyze data, and understand the robustness of your conclusions.


## What Does It Mean for Data to Be Highly Skewed?
When data is highly skewed, it means the distribution is not symmetrical and leans (or "skews") heavily toward one side. This asymmetry can significantly affect statistical analysis and interpretation.

### Types of Skewness
**1. Positive Skew (Right-Skewed):**
 - The tail extends to the right (toward larger values).
 - Most of the data are concentrated at lower values, but a few high values create a long right tail.
 - Example: Income distributions, where most people earn low-to-moderate incomes, but a few earn very high incomes.

**2. Negative Skew (Left-Skewed):**
 - The tail extends to the left (toward smaller values).
 - Most of the data are concentrated at higher values, but a few low values create a long left tail.
 - Example: Retirement age, where most people retire later, but a few retire very early.

### How to Identify Skewness
**1. Visually:**
 - Histogram: Skewed distributions will show longer tails on one side.
 - Density Plot: Asymmetry in the curve indicates skewness.
 - Boxplot: Skewness can be observed if the median line is not centered or the "whiskers" are of unequal lengths.

**2. Numerically:**
 - Mean vs. Median:
 - Mean > Median → Positive skew.
 - Mean < Median → Negative skew.

### Impact of Skewness on Analysis
**1. Descriptive Statistics:**
- The mean is sensitive to extreme values and may not reflect the center of the data accurately.
- The median is more robust and provides a better measure of central tendency for skewed data.

**2.Impact on Parametric Tests:**
- Many statistical tests (e.g., t-tests, ANOVA) assume that data follows a normal distribution.
- Skewness violates this assumption and can lead to misleading results.

**3.Challenges in Interpretation:**
- Extreme values ("outliers") can dominate analysis. 
- Comparing groups with skewed data becomes less reliable.

### How to Handle Highly Skewed Data
**1. Data Transformation:**
- Apply transformations like:
    - Logarithmic (log)
    - Square root (\sqrt{𝑥}) <br/>
These methods can make the distribution more symmetrical.

**2. Use Robust Statistics:**
- Use the median instead of the mean.
- Employ non-parametric tests (e.g., Mann-Whitney U, Kruskal-Wallis) that don't assume normality.

**3. Segment the Data:**
- Analyze data in subsets or percentiles instead of the entire distribution.

**4. Alternative Models:**
- Fit models that account for skewness, such as gamma or log-normal distributions.


## Inherent noise in data 
Refers to variability or randomness that naturally occurs within the data due to factors that cannot be fully controlled, predicted, or measured. It represents the part of the data that does not follow any clear pattern or trend and arises from the underlying processes generating the data.

### Sources of Inherent Noise
1. Biological or Natural Variability<br/>
Example: Differences in height among individuals, even within the same family or population.

2. Measurement Errors<br/>
Small inaccuracies in instruments, sensors, or human error during data collection.

3. External Influences<br/>
Unaccounted-for variables that affect the data but were not measured or controlled (e.g., weather, random mutations).

4. Random Fluctuations<br/>
Stochastic processes or events that are fundamentally unpredictable, like radioactive decay.

### Characteristics
- Unpredictable: Noise cannot be modeled or predicted accurately.
- Non-informative: It doesn't carry useful information for analysis.
- Universal: All datasets have some level of inherent noise.

>Example
>If you're measuring the weight of apples in a batch:
>The signal is the average weight (trend or pattern you want to find).
>The noise includes small variations due to differences in individual apple size or inaccuracies in the scale.

### Why It Matters
- Data Analysis: Noise can obscure true patterns or trends, leading to incorrect conclusions.
- Modeling: Overfitting occurs when models try to "learn" the noise instead of the underlying trend.
- Decision-Making: Understanding the noise-to-signal ratio helps in making informed decisions based on data.
