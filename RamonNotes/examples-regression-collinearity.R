library(car)

## Ex0. Simple case: nothing pathological

set.seed(1)
x1 <- rep(1:10, 10)
x2 <- rep(1:10, rep(10, 10))
y <- x1 + x2 + rnorm(100, 0, sd = 0.4)
d0 <- data.frame(y, x1, x2)
rm(x1, x2, y)

summary(lm0 <- lm(y ~ x1 + x2, data = d0))
scatter3d(y ~ x1 + x2,  data = d0)
summary(lm0.x1 <- lm(y ~ x1, data = d0))
summary(lm0.x2 <- lm(y ~ x2, data = d0))



## Ex1. Positive correlation


set.seed(1)
x1 <- runif(100, 1, 10)
x2 <- x1 + rnorm(100, 0, sd = 0.01)
y <- x1 + x2 + rnorm(100, 0, sd = 0.3)
dp <- data.frame(y, x1, x2)
rm(x1, x2, y)

summary(lm1 <- lm(y ~ x1 + x2, data = dp))
scatter3d(y ~ x1 + x2,  data = dp)
scatter3d(y ~ x2 + x1,  data = dp)
summary(lm1.x1 <- lm(y ~ x1, data = dp))
summary(lm1.x2 <- lm(y ~ x2, data = dp))



## Ex.3 Negative or positive?
## Based on
## https://stats.stackexchange.com/questions/78828/is-there-a-difference-between-controlling-for-and-ignoring-other-variables-i/78830#78830

set.seed(1)
x1 <- runif(99, min = -2, max = 2)
y <- -x1 + rnorm(99, 0, sd = 0.5)
x1 <- x1 + rep(c(3, 6, 9), rep(33, 3))
y <- y + rep(c(3, 6, 9), rep(33, 3))
x2 <- rep(c(1, 2, 3), rep(33, 3))
dn <- data.frame(y, x1, x2)
rm(x1, x2, y)

summary(lm2 <- lm(y ~ x1 + x2, data = dn))
scatter3d(y ~ x1 + x2,  data = dn)
scatter3d(y ~ x2 + x1,  data = dn)
summary(lm2.x1 <- lm(y ~ x1, data = dn))
summary(lm2.x2 <- lm(y ~ x2, data = dn))

