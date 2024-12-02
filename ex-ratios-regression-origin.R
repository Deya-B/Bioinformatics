summary(lm(Y ~ Z:Group - 1, data = data1))

summary(lm(Y ~ Z*Group - 1 - Group, data = data1))

summary(lm(Y ~ Z:Group - 1 - Group, data = data1))

model.matrix(lm(Y ~ Z:Group - 1, data = data1))
model.matrix(lm(Y ~ Z*Group - 1 - Group, data = data1))
model.matrix(lm(Y ~ Z:Group - 1 - Group, data = data1))

summary(lm(Y ~ Z - 1, data = dplyr::filter(data1, Group == "g1")))
summary(lm(Y ~ Z - 1, data = dplyr::filter(data1, Group == "g2")))

summary(mx1 <- lm(Y ~ Z*Group, data = data2))

summary(mx2 <- lm(Y ~ -1 + Group + Z:Group, data = data2))



## caveats about R^2, etc
cor(fitted(mx1), fitted(mx2))
cor(fitted(mx1), data2$Y)^2
