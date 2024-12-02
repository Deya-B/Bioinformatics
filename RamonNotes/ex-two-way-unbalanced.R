## Inspired by Morgan and Winship,
## first example in chapter 6


## Additive OK, but unbalance, so order matters
## and differences of within level weighted means
## do not match the effects of each term

df <- data.frame(y = c(rep(2, 42), rep(4, 8),
                       rep(6, 25), rep(8, 25)),
                 F1 = c(rep("a", 42), rep("A", 8),
                       rep("a", 25), rep("A", 25)),
                 F2 = c(rep("b", 42), rep("b", 8),
                       rep("B", 25), rep("B", 25))
                 )

table(df$F2, df$F1)
with(df, tapply(y, list(F2, F1), mean))

lmmw <- lm(y ~ F1 + F2, data = df)
lmmw2 <- lm(y ~ F2 + F1, data = df)

predict(lmmw)
summary(lmmw)

anova(lmmw)
anova(lmmw2)

## if average (weighted) the differences
## between A and a is not 2 and B and b 4
with(df, tapply(y, list(F1), mean))
with(df, tapply(y, list(F2), mean))
