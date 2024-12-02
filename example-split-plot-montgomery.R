## This was prompted by some emails in R-sig-teaching
## My answer is available here:
## https://stat.ethz.ch/pipermail/r-sig-teaching/2015q1/000604.html


## From: Richard M. Heiberger <rmh@temple.edu>
## To: Steven Stoline <sstoline@gmail.com>
## Cc: R-sig-teaching <R-sig-teaching@r-project.org>
## Subject: Re: [R-sig-teaching] Analyze Nested and Split-Plot Designs with
##  R
## Flags: seen, list
## Date: Thu 08 Jan 2015 19:58:54 CET
## Maildir: /Gmail/INBOX
## List: r-sig-teaching.r-project.org
## https://stat.ethz.ch/mailman/listinfo/r-sig-teaching


## I refer to tables in what is the 8th edition. But I only have access to
## 5th, where all of this is in chapter 13, pp. 561 and ff.


## From Heiberger's email

MontEx14.1 <-
structure(list(Supplier = structure(c(1L, 1L, 1L, 1L, 1L, 1L,
1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L), .Label = c("1",
"2", "3"), class = "factor"), Batch = structure(c(1L, 1L, 1L,
2L, 2L, 2L, 3L, 3L, 3L, 4L, 4L, 4L, 1L, 1L, 1L, 2L, 2L, 2L, 3L,
3L, 3L, 4L, 4L, 4L, 1L, 1L, 1L, 2L, 2L, 2L, 3L, 3L, 3L, 4L, 4L,
4L), .Label = c("1", "2", "3", "4"), class = "factor"), Purity = c(1L,
-1L, 0L, -2L, -3L, -4L, -2L, 0L, 1L, 1L, 4L, 0L, 1L, -2L, -3L,
0L, 4L, 2L, -1L, 0L, -2L, 0L, 3L, 2L, 2L, 4L, 0L, -2L, 0L, 2L,
1L, -1L, 2L, 3L, 2L, 1L)), .Names = c("Supplier", "Batch", "Purity"
), row.names = c(NA, -36L), class = "data.frame")



MontEx14.1$Supplier <- factor(MontEx14.1$Supplier)
MontEx14.1$Batch <- factor(MontEx14.1$Batch)

MontEx14.1.aov1 <- aov(Purity ~ Supplier/Batch, data=MontEx14.1)
summary(MontEx14.1.aov1) ## Table 14.4, but note that F for Suppliers is
                         ## from ratio of Suppliers to Batches (within
                         ## suppliers). This can be seen from the Expected
                         ## Mean Square expressions (which correspond to
                         ## middle column of Tabel 14.1 ---A Fixed, B
                         ## Random). 



MontEx14.1.aov2 <- aov(Purity ~ Supplier*Batch, data=MontEx14.1)
summary(MontEx14.1.aov2) ## Table 14.5, but again F ratio for suppliers is
                         ## from ratio of Suppliers/SxB interaction Mean
                         ## Square

MontEx14.1.aov3 <- aov(Purity ~ Supplier + Error(Supplier:Batch),
data=MontEx14.1)
summary(MontEx14.1.aov3)




## Sometimes instructive to average the batches: this way, we assess
## variation among Suppliers relative to the among-Batch within Supplier:

MontAverage <- aggregate(Purity ~ Supplier + Batch,
                         data = MontEx14.1, mean)

## F is same as Table 14.4 for Supplier. One can also check that the Sums of
## Squares here are 1/3 of those in Table 14.4 for Supplier, and that the
## Residuals SS are 1/3 of the SS for Batches.

summary(aov(Purity ~ Supplier, data = MontAverage)) 

