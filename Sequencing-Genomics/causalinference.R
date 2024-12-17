
## ************     MOLECULAR EPIDEMIOLOGY:      ************ ##
  ##  ******    introduction to CAUSAL INFERENCE   ****** ##


# ACCESSING BIOMEDICAL DB from R:

# Apart from the DB we use in this exercise, we checked this other DB
# https://portal.gdc.cancer.gov/analysis_page?app=CohortBuilder&tab=available_data
# which has a tool for cohort builder, however, accessing to them through 
# bioinformatical tools, such as R, makes it much faster and avails the use 
# of the information in our computers in an easier and better way.


#-----------------------------------------------------------------------------#
#         tcga 
#-----------------------------------------------------------------------------#     
install.packages("TCGAretriever")
install.packages("reshape2")
install.packages("ggplot2")

library(TCGAretriever)
library(reshape2)
library(ggplot2)

# Obtain a list of cancer studies from cBio
# Todos los estudios de la base de datos [con la función get_cancer_studies()]
# https://www.cbioportal.org/
all_studies <- get_cancer_studies()

# Find published TCGA datasets
keep <- grepl("tcga_pub$", all_studies[,'studyId'])
tcga_studies <- all_studies[keep, ]

# Show results
utils::head(tcga_studies[, c(11, 1, 4)])
# or
View(tcga_studies)

# Define the cancer study id: brca_tcga_pub
my_csid <- "brca_tcga_pub"

# Obtain genetic profiles con la funcion get_genetic_profiles
# podemos ver mas descripcion
brca_pro <- get_genetic_profiles(csid = my_csid)
utils::head(brca_pro[, c(7, 1)]) # esto devuelve un data frame
View(brca_pro)

# Obtain cases 
brca_cas <- get_case_lists(csid = my_csid)
utils::head(brca_cas[, c(4, 1)])
View(brca_cas)

# Define a set of genes of interest
# q es de query, vemos que genes vamos a identificar y sacar información:
q_csid <- 'brca_tcga_pub'
q_genes <- c("TP53", "HMGA1", "E2F1", "EZH2")
q_cases <- "brca_tcga_pub_complete"
rna_prf <- "brca_tcga_pub_mrna"
mut_prf <- "brca_tcga_pub_mutations"
# con esto hemos sacado la informacion molecular, pero sola no sirve de mucho
# tenemos que saber cuales son los casos y cuales los controles, y tmb es
# importante la supervivencia. Así que sacamos la información clinica.

# Download Clinical Data
brca_cli <- get_clinical_data(csid = q_csid, case_list_id = q_cases)
View(brca_cli)
# podemos ver que tenemos todos los datos necesarios para hacer un análisis
# de supervivencia
# brca_cli$ > podemos ver las distintas variables

# Download RNA
brca_RNA <- get_molecular_data(case_list_id = q_cases, 
                               gprofile_id = rna_prf, 
                               glist = q_genes)
View(brca_RNA)
# o
brca_RNA[,1:5]

# Set SYMBOLs as rownames
# Note that you may prefer to use the tibble package for this
rownames(brca_RNA) <- brca_RNA$hugoGeneSymbol
brca_RNA <- brca_RNA[, -c(1, 2, 3)]

# Round numeric vals to 3 decimals
for (i in 1:ncol(brca_RNA)) {
  brca_RNA[, i] <- round(brca_RNA[, i], digits = 3)
}

# Download mutations
# Bajamos las mutaciones porque sabemos que algunos de estos genes, puede 
# tener su expresion condicionada por el hecho de que tengamos tmb tp53
brca_MUT <- get_mutation_data(case_list_id = q_cases, 
                              gprofile_id = mut_prf, 
                              glist = q_genes)

# Identify Samples carrying a TP53 missense mutation
# Nos quedamos solo los participantes que tienen mutacion en tp53
tp53_mis_keep <- brca_MUT$hugoGeneSymbol == 'TP53' &
  brca_MUT$mutationType == 'Missense_Mutation' &
  !is.na(brca_MUT$sampleId)
# nos quedamos con ls que tienen solo 1 mutacion missense
tp53_mut_samples <- unique(brca_MUT$sampleId[tp53_mis_keep])

# Show results
keep_cols <- c('sampleId', 'hugoGeneSymbol', 'mutationType',  'proteinChange')
utils:::head(brca_MUT[, keep_cols])
View(brca_MUT[, keep_cols])
############################################################
# Visualize the correlation between EZH2 and E2F1
############################################################
# Poner en un df la información:
df <- data.frame(sample_id = colnames(brca_RNA), 
                 EZH2 = as.numeric(brca_RNA['EZH2', ]), 
                 E2F1 = as.numeric(brca_RNA['E2F1', ]), 
                 stringsAsFactors = FALSE)

ggplot(df, aes(x = EZH2, y = E2F1)) +
  geom_point(color = 'gray60', size = 0.75) +
  theme_bw() +
  geom_smooth(method = 'lm', color = 'red2', 
              size=0.3, fill = 'gray85') +
  ggtitle('E2F1-EZH2 correlation in BRCA') + 
  theme(plot.title = element_text(hjust = 0.5))

# verlo en numeros
summary(lm(df$EZH2~df$E2F1))

# Bin samples according to EZH2 expression
EZH2_bins <- make_groups(num_vector = df$EZH2, groups = 5) 
utils::head(EZH2_bins, 12)

# attach bin to df
df$EZH2_bin <- EZH2_bins$rank

# build Boxplot
ggplot(df, aes(x = as.factor(EZH2_bin), y = E2F1)) +
  geom_boxplot(outlier.shape = NA, fill = '#fed976') +
  geom_jitter(width = 0.1, size = 1) +
  theme_bw() +
  xlab('EZH2 Bins') +
  ggtitle('E2F1 Expression vs. Binned EZH2 Expression') +
  theme(plot.title = element_text(face = 'bold', hjust = 0.5))


# Coerce to data.frame with numeric features 
mol_df <- data.frame(sample_id = colnames(brca_RNA), 
                     HMGA1 = as.numeric(brca_RNA['HMGA1', ]),
                     TP53 = as.numeric(brca_RNA['TP53', ]),
                     stringsAsFactors = FALSE)
# vamos a dividir los participantes entre wild type y mutante (que no la tienen
# y que si)
mol_df$TP53.status = factor(ifelse(mol_df$sample_id %in% tp53_mut_samples, 
                                   '01.wild_type', '02.mutated'))
###########################################################################
# Visualize the correlation between EZH2 and E2F1
###########################################################################

ggplot(mol_df, aes(x = TP53, y = HMGA1)) +
  geom_point(color = 'gray60', size = 0.75) +
  facet_grid(cols = vars(TP53.status)) +
  theme_bw() +
  geom_smooth(mapping = aes(color = TP53.status), 
              method = 'lm', size=0.3, fill = 'gray85') +
  ggtitle('HMGA1-TP53 correlation in BRCA') + 
  theme(plot.title = element_text(hjust = 0.5))

## KEEP IN MIND:
# Correlation does not imply causation.
#-----------------------------------------------------------------------------# 
# END OF tcga exercise
#-----------------------------------------------------------------------------#



## Causal Inference:

# It is a mathematical framework that proposes the necessary notation, 
# axioms and mathematical tools to make the leap from association to causality

#-----------------------------------------------------------------------------#
#          Simulation
#-----------------------------------------------------------------------------#
# example alcohol consumption and time-to-death

############ HYPOTHETICAL SCENARIO #############################

ATE<-numeric()
# los datos y las medias las cogemos basados en estudios
for (i in 1:10000){
  no.alcohol.true<-rpois(100,7) # estamos cogiendo 100 de media 7
  alcohol.true<-rpois(100,5) # estamos cogiendo 100 de media 5
  # ATE average treatment effect
  ATE[i]<-mean(no.alcohol.true-alcohol.true)
}

hist(ATE)
summary(ATE)

# la diferencia entre los que toman y los que no es de 2, lo que indica
# algo parecido a la tabla que tenemos en la diapositiva.
# SI las variables de alcohol e infarto son independientes, no encesito
# tener el scenario, sino que teneindo la media de ambas variables
# podría trabajar con los datos.
# Hay variantes geneticas asociadas con el consumo de alcohol
# Si estas no son las mismas que las de problemas cardiacos
# podemos inferenciar con las dos variables.

# ie si la asignacion es completamente aleatoria de la variable que queremos
# medir, podemos restar un valor medio a otro y obtenemos lo mismo que la
# diferencia de las medias entre ambos grupos


############ RANDOM ASSIGNMENT OF INDIVIDUALS ##################
# Hacemos lo mismo pero asignando a esas personas aleatoriamente a un grupo
# y a otro:
ace.random<-numeric()

for (i in 1:10000){
  assignment<-rbinom(200,1,0.5)
  n1<-sum(assignment==1)
  n0<-sum(assignment==0) # numeros 1s y 0s completamente aleatorios
  no.alcohol<-rpois(n0,7) # para los de no alcohol, tenemos una distrib de media 7
  alcohol<-rpois(n1,5) # para estos es de media 5
  ace.random[i]<-mean(no.alcohol)-mean(alcohol)
}

hist(ace.random)
summary(ace.random)

# esto esta demostrado, pero aparte podemos ver en este ejemplo
# que ocurre de esta manera

############ NON-RANDOM ASSIGNMENT OF INDIVIDUALS ##################

#smokers tend to drink and live shorter than non-smokers

ace.nonrandom<-numeric()

for (i in 1:10000){
  alc.ass<-c(rep(0,100),rep(1,100))
  smk.ass<-rbinom(200,1,0.3)
  tt<-table(alc.ass,smk.ass)
  no.alcohol.no.smk<-rpois(tt[1,1],15)
  no.alcohol.smk<-rpois(tt[1,2],10)
  alcohol.no.smk<-rpois(tt[2,1],10)
  alcohol.smk<-rpois(tt[2,2],5)
  ace.nonrandom[i]<-mean(c(no.alcohol.no.smk,no.alcohol.smk))-mean(c(alcohol.no.smk,alcohol.smk))
}

hist(ace.nonrandom)
summary(ace.nonrandom)

#-----------------------------------------------------------------------------# 
# END OF Simulation exercise
#-----------------------------------------------------------------------------#



## Mendelian Randomization (MR)

## Assumptions behind MR:
# Assumption 1: The genetic variant is associated with the causal trait.
# Assumption 2: The genetic variant is not associated with any confounder of the 
#   effector-outcome association.
# Assumption 3: The genetic variant is only associated with the outcome through  
#   the causal trait.

#-----------------------------------------------------------------------------#
#          Mendelian Randomization (MR)
#-----------------------------------------------------------------------------#

#install.packages("MendelianRandomization")
library(MendelianRandomization)

# “Genetic variants influencing circulating lipid levels and risk of coronary artery
# disease”
# doi: 10.1161/atvbaha.109.201020
# Previamente había que mirar que se cumplan todas las asumpciones y
# necesitamos estos 4 datos (más info en diapos):
MRInputObject <- mr_input(bx = ldlc,
                          bxse = ldlcse,
                          by = chdlodds, # beta de la enfermedad coronaria
                          byse = chdloddsse)

IVWObject <- mr_ivw(MRInputObject,
                    model = "default",
                    robust = FALSE,
                    penalized = FALSE,
                    correl = FALSE,
                    weights = "simple",
                    psi = 0,
                    distribution = "normal",
                    alpha = 0.05)

IVWObject <- mr_ivw(mr_input(bx = ldlc, bxse = ldlcse,
                             by = chdlodds, byse = chdloddsse))
# Ver resultados
IVWObject
# Tambien podemos ver cada variable por separado poniendo su nombre

# “Using published
# data in Mendelian randomization: a blueprint for efficient identification of causal risk factors”, doi:
#   10.1007/s10654-015-0011-z.
# Otro ejemplo: si el tener cierto nivel de calcio tiene relacion con ser diabetico
MRInputObject.cor <- mr_input(bx = calcium,
                              bxse = calciumse,
                              by = fastgluc,
                              byse = fastglucse,
                              corr = calc.rho)

IVWObject.correl <- mr_ivw(MRInputObject.cor,
                           model = "default",
                           correl = TRUE,
                           distribution = "normal",
                           alpha = 0.05)
IVWObject.correl <- mr_ivw(mr_input(bx = calcium, bxse = calciumse,
                                    by = fastgluc, byse = fastglucse, corr = calc.rho))
IVWObject.correl



###############################################################################
#### EJERCICIO PARA CASA #####
###############################################################################

#install.packages("gwasrapidd")
library(gwasrapidd)

######## alcohol consumption
### Buscar todos los estudios en los que el trait de interes es alcohol drinking
my_studies_alc <- get_studies(efo_trait = 'alcohol drinking')
gwasrapidd::n(my_studies_alc)
my_studies_alc@publications$title
# coger los primeros 10 estudios y los snps con la info asociada a ellos:
my_associations_alc <- get_associations(study_id = my_studies_alc@studies$study_id[1:10])
# ver cuantos son:
gwasrapidd::n(my_associations_alc)

# Filtrar de los 49, los que esten asociados con un pvalor <1e-6
dplyr::filter(my_associations_alc@associations, pvalue < 1e-6) %>% # Filter by p-value
  tidyr::drop_na(pvalue) %>%
  dplyr::select(association_id,beta_number,standard_error)%>% # Nos interesa el id, el beta y el sterror
  tidyr::drop_na(standard_error) -> association_ids_alc         # Los estudios que recortan esa informacion no nos interesan

# ****************** RELLENAR NOSOTROS ******************
# my_associations_alc_2 <- my_associations_alc[association_ids_alc]
# my_associations2@risk_alleles[c('variant_id', 'risk_allele', 'risk_frequency')]


######## AMI
# Ver q no estan asociados con miocardial infarction
my_studies_AMI<-get_studies(efo_trait = 'myocardial infarction')
gwasrapidd::n(my_studies_AMI)
my_studies_AMI@publications$title
my_associations_AMI <- get_associations(study_id = my_studies_AMI@studies$study_id)
gwasrapidd::n(my_associations_AMI)

dplyr::filter(my_associations_AMI@associations, pvalue < 1e-6) %>% # Filter by p-value
  tidyr::drop_na(pvalue) %>%
  dplyr::select(association_id,beta_number,standard_error)%>%
  tidyr::drop_na(standard_error) -> association_ids_AMI


# ****************** RELLENAR NOSOTROS ******************
# Hacer esto para las variables confusoras
# COMO EN LA SIMUCIÓN DEL EJERCICIO ANTERIOR
# Juntar toda la informacion, crear un Mendelian Randomization y hacer
# inferencia causal en los datos.
