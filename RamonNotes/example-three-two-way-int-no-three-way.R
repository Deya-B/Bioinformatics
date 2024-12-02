## Example of how it is possible that in a 3-way ANOVA we have
## all three two-way interactions but not the three-way interaction.




library(car) ## We will use the "Anova" function from car

## Suppose a three way ANOVA with factors F1 (levels A and a),
## F2 (levels B and b) and F3 (levels D and d).

## Create a data frame for the mean value at each of the combinations.
## Y is the mean of the response for all possible 8 cell means.
## (Why these values? No particular reason, but see bottom for how
## to generate these kind of data)

## Actually, you might want to start from the bottom, "How to create these kinds
## of patterns", to see how these type of data can be easily generated.



df1 <- data.frame(F1 = c(rep("A", 4), rep("a", 4)),
                  F2 = rep(c(rep("B", 2), rep("b", 2)), 2),
                  F3 = rep(c("D", "d"), 4),
                  Y = c(2, 5, 1, 2, 3, 5, 0, 0))

df1

## Those means fulfill that there are two-way interactions, but no three-way
## interaction. Let's show it


##
#######  Interaction F1:F2 does not change with level of F3
## Notice how the bottom right cell deviates by -2 from the value
## expected under an additive model (using a,b as intercept)
## The value of the bottom right cell = top left + change along first row
## + change along first column + interaction.
## 5 = 0 + 2 + 5 - 2
## 2 = 0 + 3 + 1 - 2
xtabs(Y ~ F1 + F2 + F3, data = df1)


## If there is no F1:F2 change with F3, that means no F1:F2:F3 interaction.
## The next two are just saying the same thing.


#######  Interaction F1:F3 does not change with level of F2
## Interaction F1:F3 is -1, constant over levels of F2
xtabs(Y ~ F1 + F3 + F2, data = df1)


#######  Interaction F2:F3 does not change with level of F1
## Interaction F2:F3 is -2, constant over levels of F1
xtabs(Y ~ F2 + F3 + F1, data = df1)



## Let us generate some simulated data, and do an ANOVA
## I use a huge sample size to make sure not detecting the three-interaction
## is not because of lack of power (notice the huge F statistics for the two-way
## interactions)

reps <- 10000
dfrep <- do.call(rbind, replicate(reps, df1, simplify = FALSE))
## We must add some noise; I'll keep it tiny, so patterns are easier to see.
dfrep$Y <- dfrep$Y + rnorm(nrow(dfrep), mean =  0, sd = .001)

## Fit the model and check the Anova table
m1 <- lm(Y ~ F1 * F2 * F3, data = dfrep)
Anova(m1)
## Remember that if you do this many times, sometimes you'll see
## a signficant p-value for the interaction.


## By the way, notice the estimated coefficients for interactions:
## they are the same as given above.
summary(m1)
## F1A:F2b is -2: the interaction F1:F2 given above
## F1A:F3D is -1; the interaction F1:F3 given above
## F2B:F3D is -2; the interaction F2:F3 given above

## Double check means of the simulated data
aggregate(Y ~ F1 + F2 + F3, FUN = function(x) round(mean(x), 2), data = dfrep)



#############   How to create these kinds of patterns #########

## It is actually easy. This is one way.

## Draw two 2x2 tables, one for "d" and another for "D". For example, for D we have:
##       b   B
##  a  Yab   YaB
##  A  YAb   YAB


## We have two such tables, one for "d" and one for "D". (You can think of the
## cells as being, then, Yabd, YaBd, ... for the "d" table and
## YabD, YaBD, ..., for the "D" table).

## The values in the cells are the cell means.
## Let us give them numbers. Start with that table for D.
## Ensure it shows interaction F1:F2. For example fill with numbers
## 0, 1, 2, 3, starting from top left and moving counter-clockwise
## (this pattern ensures an interaction)
## so we have Yab = 0; YaB = 1, ...
## These numbers are the mean values YabD = 0, YAbD = 1, ...
## With those numbers, YAB deviates from additivity by -2 and this will be
## the magnitude of the interaction F1:F2.
## YAB = 0 + 1 + 3 - 2

## Now, for the table at d, change the difference YaB - Yab
## and the difference YAb - Yab.
## Because these differences are different compared to what
## they were in the "D" table, this creates interactions F1:F3 and F2:F3
## For no particular reason I decided to set Yabd = 0; then YAbd = 2
## (so now the increase moving right is 2, not 1 as with D) and then
## YaBd = 5 (so now the increase moving down is 5, not 3).

## BUT, and this is crucial, ensure the lower right cell,
## YAB deviates from additivity by the same amount as in the table of D.
## So the YABd mean should be 5 (0 + 2 + 5 -2)

## Of course the actual values of the magnitude of the interactions F1:F2,
## F1:F3, F2:F3 are irrelevant. Any other values would have worked.

## We have created all three two-way interactions but not a
## three-way interaction.
