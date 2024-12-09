“A recipe book for simulations with OncoSimulR” (section 5) requires judiciously reading a large paper and
understanding what are interesting scenarios to simulate. And, then, becoming familiar with OncoSimulR and
running a bunch of simulations.

### For projects that involve OncoSimulR: What version of the code

Make sure you use the current master branch from [github](https://github.com/rdiaz02/OncoSimul)

Fork the github repo (see GitHub suggestions).

Before installing it, though, you might want to install the version available from BioConductor, so that all
dependencies are satisfied. (As of today, BioC has the most recent version of the code).

Note that I might occasionally add some code to that branch. It is important for you to keep your copy of the
code updated!

### Git and github suggestions
You must use version control for this project. git is, as of today, probably the best option.

You should use a repository, possibly a public one, in places like github, bitbucket, gitlab, etc. For some of the
projects it will be github, since that is where I keep the OncoSimulR, EvAM-Tools, and other repos.
There are many git tutorials. All I know about git and github can fit in three short sentences. That is probably
all you need for this work.

The simplest (in the long term, but also in the medium term) is to
1. (Create a github account if you don’t have one. One for each one of you is the simplest)
2. Fork the repository
3. Clone from your fork
4. Create a new branch in your local machine
5. Give access permissions to all your team members to the remote repository
6. Work as you see appropriate, probably submitting to the remote repo
7. Remember to check for updates to the original repo (i.e., to grab the new code I might add during the next
few weeks)

The above are just suggestions. Do as you see fit. However, if you want me to possibly incorporate your work
it is a lot simpler if you do a pull request from github.

### What you need to present and send at the end
1. You will give a presentation the day of the final exam (in January). You will need to send me that presentation
at the end of that day.
2. You will also need to send me the code and any additional documentation. You will do this via Moodle in
“Programming exercise: file upload, grades and feedback”.
3. With the previous additional documentation, add, if appropriate, a link to your github repo. That is specially
important if you make a pull request.
4. Deadlines: the presentation. (Oh, you should not count on my answering questions, or answering them
promptly, during Christmas vacation.)


## A recipe book for simulations with OncoSimulR
The package [OncoSimulR](https://github.com/rdiaz02/OncoSimul) is a package for forward
population genetic simulation in asexual populations, with special focus on cancer progression. It allows specifying
many different models but it is not clear that some scenarios that might be biologically relevant can be simulated
with these models.

The objective of this work is to list a series of biologically interesting scenarios and explain how to simulate
them. For example: “If you want to simulate large intra-tumor heterogeneity with small population sizes, you have
to set mutation rates to values between x and y; this leads to z levels of intra-tumor heterogeneity for population
sizes between v and w”.

### 1 Steps
1. Understand the functionality available in OncoSimulR to simulate interventions.
2. Clone the github repository of OncoSimulR.
3. Read “the picture guide”: Diaz-Uriarte and Johnston, 2024, focusing on open problems and scenarios to
simulate. For example “SSWM”, “WSSM” (strong selection, weak mutation, and weak selection, strong
mutation), high or low intratumor heterogeneity, tunneling or lack thereof, etc, etc.
Yes, this is a loooooooong paper. Read it judiciously: you are looking for “interesting scenarios to simulate”,
but you do not care about cancer progression models per se (of course, you can read that part with
attention, but it is NOT required for this work).
4. Find settings of parameters that produce the scenarios you want. Of course, you do not want one simulation,
nor two or three. You ideally run, say, 100 or 1000 replicates of each scenario and you’d be able to say things
like “In 90% of our replicates there is this much intra-tumor heterogeneity”.
5. Oh, of course, you might need to define carefully what the things you simulate or try to see are. For example,
what is intratumor heterogeneity? How do we define and compute it?
The papers by Diaz-Colunga and Diaz-Uriarte, 2021, and Diaz-Uriarte and Vasallo, 2019, define some of
these things. You might want to look at them (including their supplementary material), but the key is the
stuff they define (e.g., intra-tumor heterogeneity); there is no need to understand or read the paper in full.
And this is just a suggestion, not a requirement.
6. And, in fact, you will need to sample from the simulations. OncoSimulR allows you to sample in different
ways. Use the one that matters for your scenario (e.g., single cell or whole-tumor, or bulk sequencing).
7. You might want to avoid the frequency-dependence stuff here, unless you have very specific scenarios you
want to model, such as “frequency-dependence and low/high intra-tumor heterogeneity with small mutation
rates and small population sizes”. Saying “OncoSimulR can be used to simulate frequency-dependence”
. . . is useless, since everybody (everybody who knows what OncoSimulR is) knows that very well already.
8. Some scenarios already have know parameters in the documentation of OncoSimulR itself. Mentioning them
is OK, but you are supposed to go beyond what is already available in the documentation.

### 2 References
- Diaz-Uriarte, R., & Johnston, I. G. (2024). A picture guide to cancer progression and monotonic accumulation
models: Evolutionary assumptions, plausible interpretations, and alternative uses (arXiv:2312.06824).
arXiv. https://doi.org/10.48550/arXiv.2312.06824.
- OncoSimulR: https://github.com/rdiaz02/OncoSimul
- Diaz-Colunga, J., & Diaz-Uriarte, R. (2021). Conditional prediction of consecutive tumor evolution using cancer
progression models: What genotype comes next? Plos Computational Biology, 17(12), e1009055. https:
//doi.org/10.1371/journal.pcbi.1009055
- Diaz-Uriarte, R., & Vasallo, C. (2019). Every which way? on predicting tumor evolution using cancer progression
models. Plos Computational Biology, 15(8), e1007246. https://doi.org/10.1371/journal.
pcbi.1007246
