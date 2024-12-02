## Some rudimentary code to play with the central limit theorem



library(parallel)
## n_pop: sample size
## n_mean: the number of replicates
## yeah, the names suck.
clt1 <- function(n_pop, n_mean,  FUN, ...) {
    cores <- detectCores()
    means <- unlist(mclapply(seq.int(n_mean),
                             function(u) mean(FUN(n_pop, ...)),
                             mc.cores = cores))
    ## FIXME: eh? and I do not reset op?
    op <- par(mfrow = c(2, 1))
    ## FIXME: do not hard-code breaks
    hist(means, breaks = 50)
    abline(v = mean(means))
    qqnorm(means, pch = ".")
    qqline(means)
}


clt1(2, 10000, rexp, 0.1)

clt1(10, 10000, rexp, 0.1)

clt1(20, 10000, rexp, 0.1)

clt1(50, 10000, rexp, 0.1)

clt1(100, 10000, rexp, 0.1)

clt1(200, 10000, rexp, 0.1)


## Uniform
clt1(4, 10000, runif, 0, 1)
clt1(20, 10000, runif, 0, 1)
clt1(200, 10000, runif, 0, 1)

## Poisson
clt1(20, 10000, rpois, 3)
clt1(50, 30000, rpois, 3)
clt1(200, 10000, rpois, 3)

clt1(20, 10000, rpois, 5)
clt1(50, 10000, rpois, 5)
clt1(200, 10000, rpois, 5)


## cauchy always behaves poorly
clt1(5, 10000, rcauchy, location = 5)
clt1(20, 10000, rcauchy, location = 5)
clt1(100, 10000, rcauchy, location = 5)
clt1(1000, 10000, rcauchy, location = 5)
clt1(2000, 10000, rcauchy, location = 5)
clt1(10000, 10000, rcauchy, location = 5)

## A very heavy tailed t (if df 2, variance not finite)
hist(rt(1e5, 3))
clt1(50, 10000, rt, 3)
clt1(200, 10000, rt, 3)



## What about a t distribution?
library(limma)

tdt1 <- function(n_pop, n_mean,
                 truemean = NULL,
                 FUN, ...) {
  cores <- detectCores()

  X <- mclapply(seq.int(n_mean),
                function(u) FUN(n_pop, ...),
                mc.cores = cores)

  Xmat <- do.call(rbind, X)
  ## or rbindlist (data.table) or dplyr::bind_rows, etc
  means <- rowMeans(Xmat)

  if (is.null(truemean))
    truemean <- mean(means)
  vars <- apply(Xmat, 1, var)
  se <- sqrt(vars/n_pop)
  tstats <- (means - truemean)/se

  op <- par(mfrow = c(2, 1))
  hist(tstats, freq = FALSE)
  curve(dt(x, n_pop - 1, 0), -4, 4, add = TRUE)
  limma::qqt(tstats, df = n_pop - 1, pch = ".")
  abline(0, 1)
}

tdt1(2, 10000, 10, rexp, 0.1)

tdt1(20, 10000, 10, rexp, 0.1)

tdt1(50, 10000, 10, rexp, 0.1)

tdt1(100, 10000, 10, rexp, 0.1)

tdt1(200, 10000, 10, rexp, 0.1)

tdt1(500, 10000, 10, rexp, 0.1)

tdt1(5000, 10000, 10, rexp, 0.1)

## passing the "truemean" here ... hummm.. but whatever
tdt1(1000, 10000, 5, rcauchy, 5)
tdt1(5000, 10000, 5, rcauchy, 5)


tdt1(50, 10000, 0, rt, 3)
tdt1(100, 10000, 0, rt, 3)
tdt1(50, 10000, 0, rt, 10)

tdt1(20, 100000, 0.5, runif, 0, 1)
tdt1(50, 100000, 0.5, runif, 0, 1)

tdt1(50, 10000, 4, rpois, 4)
tdt1(50, 10000, 10, rpois, 10)
tdt1(10, 10000, 10, rpois, 10)

## We could try to use an envelope around the qqline. Like car does.


## we could plot the density
## The next is an ugly kludge, since we can plot the
## dwhaterver from rwhatever
## But would require work to find domain, etc
## dfun <- gsub("^r", "d", deparse(substitute(FUN)))
## eval the dfun, then plot using curve

## But this is sooooo ugly
## npd <- 1e6
## hist(FUN(npd, ...), freq = FALSE, xlab = "Original distr.",
##      breaks = 500)

## dfun <- gsub("^r", "d", deparse(substitute(FUN)))
## eval the dfun, then plot using curve

## get range from the min and max of the random numbers



## this will not work
clt2 <- function(n_mean, n_pop, FUN, ...) {
  means <- replicate(n_mean, mean(FUN(n_pop, ...)))
  op <- par(mfrow = c(1, 2))
  hist(means)
  abline(v = mean(means))
  qqnorm(means)
}

clt2(100, 10, rexp, lambda = 0.1)
## see help of replicate:
## If ‘expr’ is a function call, be aware of assumptions about where
## it is evaluated, and in particular what ‘...’ might refer to.  You
## can pass additional named arguments to a function call as
## additional named arguments to ‘replicate’: see ‘Examples’.


## But this does
clt3 <- function(n_mean, n_pop,  FUN, ...) {
  f1 <- function() FUN(n_pop, ...)
  means <- replicate(n_mean, mean(f1()))
  op <- par(mfrow = c(1, 2))
  hist(means)
  abline(v = mean(means))
  qqnorm(means)
}

clt3(100, 10, FUN = rexp, 0.1)
