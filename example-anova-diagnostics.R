## Diagnostics suggest missing interaction
set.seed(1)
sex <- factor(rep(c("Male", "Female"), c(20, 20)))
drug <- factor(rep(rep(c("A", "B"), c(10, 10)), 2))
y <- rep(c(8, 16, 10, 12), rep(10, 4))
y <- y + rnorm(length(y), sd = 1.5)
y.data1 <- data.frame(y, sex, drug)
rm(y, sex, drug)
with(y.data1, tapply(y, list(sex, drug), mean))

## Fit the model
myAdditive2 <- lm(y ~ sex + drug, data = y.data1)
myInteract2 <- lm(y ~ sex * drug, data = y.data1)
summary(myAdditive2)
summary(myInteract2)

dev.off()
par(mfrow = c(2, 3))
plot(myAdditive2, which = c(1:5)) ## look at first plot

dev.off()
par(mfrow = c(2, 3))
plot(myInteract2, which = c(1:5))



############

## Large cook's in anova



set.seed(1)
sex <- factor(rep(c("Male", "Female"), c(20, 20)))
drug <- factor(rep(rep(c("A", "B"), c(10, 10)), 2))
y <- rep(c(8, 12, 11, 15), rep(10, 4))
y <- y + rnorm(length(y), sd = 1.5)
y.data2 <- data.frame(y, sex, drug)
rm(y, sex, drug)
## create a large outlier

y.data2[1, 1] <- 30
with(y.data2, tapply(y, list(sex, drug), mean))

## Now, create unbalance
y.data3 <- y.data2[-c(35, 40), ]
with(y.data3, tapply(y, list(sex, drug), mean))


## ## Fit the model
myAdditive2b <- lm(y ~ sex + drug, data = y.data2)
## myInteract <- lm(y ~ sex * drug, data = y.data2)
## summary(myAdditive)
## summary(myInteract)

## ## diagnostics, all of them except 6th
## we actually have a large Cook's distance
dev.off()
par(mfrow = c(2, 3))
plot(myAdditive2b, which = 1:5)

## model with and without first obs
summary(lm(y ~ sex + drug, data = y.data2))
summary(lm(y ~ sex + drug, data = y.data2[-1, ]))


## diagnostics if we remove the offending value
dev.off()
par(mfrow = c(2, 3))
plot(lm(y ~ sex + drug, data = y.data2[-1, ]), which = 1:5)



## the model with two observations missing
dev.off()
par(mfrow = c(2, 3))
myAdditive3 <- lm(y ~ sex + drug, data = y.data3)
plot(myAdditive3, which = 1:5) ## see Cook's




########################################
###                    #################
### For class, summary
###                    #################
########################################


## Diagnostics can suggest missing interaction

dev.off()
par(mfrow = c(2, 3))
plot(myAdditive2, which = c(1:5)) ## look at first plot

dev.off()
par(mfrow = c(2, 3))
plot(myInteract2, which = c(1:5))



## Where is Cook's distance and a large outlier/large Cook.
## But the problem here is not a missing interaction
dev.off()
par(mfrow = c(2, 3))
plot(myAdditive2b, which = 1:5)


## Same model, offending observation removed We are shown the Cook's plot
## by default (and no longer any concerns in first plot)
dev.off()
par(mfrow = c(2, 3))
plot(lm(y ~ sex + drug, data = y.data2[-1, ]), which = 1:5)



## For the sake of it, if we had lack of balance to being with, we are
## always shown Cook's
dev.off()
par(mfrow = c(2, 3))
plot(myAdditive3, which = 1:5) ## see Cook's




###########################################################################





## some details, from plot.lm
lm.influence(myAdditive2b, do.coef = FALSE)$hat ## constant
lm.influence(myAdditive3, do.coef = FALSE)$hat ##nope
diff(range(hii))


