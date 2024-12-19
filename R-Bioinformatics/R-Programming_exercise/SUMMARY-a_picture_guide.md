# Cancer progression models or monotonic accumulation models
Monotonic accumulation models try to infer the dependencies that give rise to the patterns we observe in the data. 

The key idea is that many phenomena involve the irreversible accumulation (or loss) of certain features or events, and that different events are not independent but can affect the acquisition (or loss) of other events.

Understanding the sequence of events can help identify diagnostic targets or stratify patients for differential treatments.

Types:
- **Linear accumulation** (deterministeic) models: asume that one event is always directly required for the accumulation of another event.
- **Richer deterministic** models: allow more complex dependencies (e.g. an event can depend on the occurrence of one among several possible previous events).
- **Stochastic dependencies** models: assume that events have inhibiting or enhancing effects on the probability of acquisition of other events.

We are interested in how some features or events that characterise a process accumulate (or are lost) irreversibly. Examples: 
- how mutations in driver genes accumulate during cancer progression 
- or how symptoms (fever, vomiting, anemia, . . . ) accumulate during severe malaria
- these models can be used to help identify therapeutic targets and improve evolutionary-based adaptive treatment approaches

![CMPsteps](images/CPMsteps.png)

### Steps: 

1. (a) Features of relevance are measured on some subjects, i.e.**presence or absence** of the events of interest (e.g., mutations in genes or presence of malaria symptoms) 

2. (b)**Data** are **arranged** as a binary matrix of samples by features.
    - For cancer data, each row in (b) is a mutational profile: what mutations or genetic alterations were present in a given subject.
        > Here we only focus on data where all samples are assumed independent and each sample provides a single observation: crosssectional data. This is the standard scenario for the application of cancer progression models.

3. (c) The researcher uses a method to **infer the dependencies** in the order of accumulation of the events (or mutations) that best explains the observed data (data in (b)). There are a variety of methods, that we schematise into two groups in (c) in both figures, letters denote events or gene alterations (the column names of the matrix in
(b)):
    - Some methods (left), model **stochastic dependencies** for the transitions between the combinations of events. The parameters[^1] of this model are: interaction and spontaneous rates or transition probabilities; and it assumes that events have inhibiting or enhancing effects on the probability of acquisition of other events.
    
    - other methods (right), model **deterministic relationships** encoded as graphs. The parameters[^1] of this model are: trees/graphs, type of dependencies, and rates/conditional probabilities; and it assumes that some events are always, necessarily required for the accumulation of other events.
    
[^1]: These parameters allow that model to provide the closest match between predicted and observed frequencies of mutational profiles (the data in (b)). As an example, in brown, some of the edges annotated with possible parameters inferred.


4. (d) Once models are fitted, they can be used to obtain additional predictions or improved statistical analyses. Some uses
of cancer progression models:
    - Left: predicting the next genotype and predicting the paths of progression of the disease (conditional on the current observed state); edge weights give predicted probabilities. 
    - Centre: distribution of ordering of some feature (e.g., a mutation in a gene) between patients with different prognosis, facilitating stratification.
    - Right: patients are stratified based on evolutionary trajectory, and the survival of the different groups is compared.


## Methods overview

![methods](images/metodos.png)
*Table 1: Cancer progression and monotonic accumulation models: main features. Methods ordered approximately by increasing complexity of dependencies that can be reflected.*

