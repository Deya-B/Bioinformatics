## Small outlier (not standardized outlier) and large influence


dev.off()
par(mfrow = c(2, 3))
x4 <- c(1:10, 500)
y4 <- c(1:10, 0) + rnorm(11, sd = 0.1)
lm4 <- lm(y4 ~ x4)
plot(lm4, which = 1:5)
plot(y4 ~ x4)
abline(lm4)

## Last point, small residuals
residuals(lm4)

## standardized: the denorminator
## includes the hat value.

## What we obtain via rstandard is what the Wikipedia calls "studentized residuals"
## What we obtain via rstudent is what the Wikipedia calls
## externally studentized

## See also

## Fox and Weisberg, section 8.1

## https://online.stat.psu.edu/stat462/node/247/
## for examples and details (but not using R)

## https://stats.stackexchange.com/a/99723

## https://en.wikipedia.org/wiki/Studentized_residual
## (though the expression for the externally studentized might be confusing)

rstandard(lm4)
rstudent(lm4)



########### Manually

sigma2 <- (1/(11 - 2)) * sum(residuals(lm4)^2)

## Which is the same as
## Sum Sq Residuals
anova(lm4)

## Square of "Residual standard error"
summary(lm4)


resids_standardized <- residuals(lm4)/sqrt(sigma2 * (1 - hatvalues(lm4)))


## compare
resids_standardized
rstandard(lm4)



## The studentized
## The Wikipedia page might be confusing
## The \epsilon are from the model without the specified observation
lm4_11 <- lm(y4[-11] ~ x4[-11])
sigma2_studentized_11 <-  (1/8) * sum(residuals(lm4_11)^2)

resids_student_11 <- residuals(lm4)[11]/sqrt(sigma2_studentized_11 * (1 - hatvalues(lm4)[11]))


rstudent(lm4)
resids_student_11




## Just leave that observation out
rstandard(lm4, type = "predictive")
y4[11] - predict(lm4_11, newdata = data.frame(x4 = 500))



## Studentized, using a different expression
##  (see stackexchange, and notice that 1-h_ii is in denominator)

d11 <- y4[11] - predict(lm4_11, newdata = data.frame(x4 = 500))

d11/sqrt( sigma2_studentized_11/(1 - hatvalues(lm4)[11]) )
