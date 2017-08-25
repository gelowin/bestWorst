##### PCA on a genotype-environment data set
set.seed(1234)
library("missMDA")
data("geno", package = "missMDA")
summary(geno)
head(round(geno, 2))

ncomp <- estim_ncpPCA(geno)
ncomp$ncp
res.imp <- imputePCA(geno, ncp = 2)
res.pca <- PCA(res.imp$completeObs)

ncomp <- estim_ncpPCA(geno, ncp.min = 0, ncp.max = 6)
ncomp$ncp

ncomp$ncp <- estim_ncpPCA(geno, ncp.min = 0, ncp.max = 6, method.cv = c("Kfold"), 
  nbsim = 100, pNA = 0.05)
ncomp$ncp

res.imp <- imputePCA(geno, ncp = 2, scale = TRUE, method = "Regularized", row.w = NULL, 
  coeff.ridge = 1, threshold = 1e-06, seed = NULL, nb.init = 1, maxiter = 1000)

head(round(res.imp$completeObs, 2))

res.pca <- PCA(res.imp$completeObs)

resMIPCA <- MIPCA(geno, ncp = 2, nboot = 200)
plot(resMIPCA)
plot(resMIPCA, choice = "all", axes = c(1, 2), new.plot = TRUE, main = NULL, level.conf = 0.95)

##### Multiple correspondence analysis
data("vnf", package = "missMDA")
ncomp <- estim_ncpMCA(vnf)
tab.disj.impute <- imputeMCA(vnf, ncp = 4)$tab.disj
res.mca <- MCA(vnf, tab.disj = tab.disj.impute)

##### Factorial analysis for mixed data
data("snorena", package = "missMDA")
res.impute <- imputeFAMD(snorena, ncp = 3)
res.famd <- FAMD(snorena, tab.comp = res.impute$tab.disj)

##### Multiple Factor Analysis
data("gene", package = "missMDA")
res.impute <- imputeMFA(gene[, -1], group = c(76, 356), type = rep("s", 2), ncp = 2)
res.mfa <- MFA(cbind.data.frame(gene[, 1], res.impute$completeObs), group = c(1, 
  76, 356), type = c("n", rep("s", 2)), name.group = c("WHO", "CGH", "expr"), num.group.sup = 1)

plot(res.mfa, habillage = 1, lab.ind = FALSE)
plot(res.mfa, choi = "var", lab.var = FALSE, habillage = "group")

plot(res.mfa, choi = "group", habillage = "group")

plot(res.mfa, invisible = "ind", partial = "all", habillage = "group")
plot(res.mfa, lab.ind = FALSE, partial = "GBM29", habillage = "group")

###### Visualization of the missing pattern
## mis.ind <- matrix("o", nrow = nrow(MyData), ncol = ncol(MyData))
## mis.ind[is.na(MyData)] <- "m"
## dimnames(mis.ind) <- dimnames(MyData)
## library("FactoMineR")
## resMCA <- MCA(mis.ind, graph = FALSE)
## plot(resMCA, invis = "ind", title = "MCA graph of the categories") 
#
