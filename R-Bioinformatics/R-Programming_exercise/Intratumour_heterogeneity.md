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

