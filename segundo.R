load('/home/amartinezp/Documents/bestWorst/data/01seleccion.RData')

library(R6)
source('/home/amartinezp/lib/load.fenoGAIT2.R')
load.fenoGAIT2()


dat <- merge(dat,df[,'AGE2',drop=FALSE],by='row.names',all.x=TRUE,all.y=FALSE)
row.names(dat) <- dat$Row.names
dat <- dat[,-1]


library(plyr)
library(mvoutlier)
#################################################3
## https://www.analyticsvidhya.com/blog/2016/03/tutorial-powerful-packages-imputing-missing-values/
## https://datascienceplus.com/missing-value-treatment/


## FIRST OF ALL, I RESIDUALIZE THE VARIABLES IN UNIVERSO FOR AGE AND SEX, BECAUSE THEY HAVE A LOT OF EFFECT IN THE FINAL STEPS

covs <- llply(universo.fen, function(X) f1$infoTrait(X)$covariates)
names(covs) <- universo.fen

covs[is.na(covs)] <- 1
formulas <- llply(universo.fen, function(X) paste(X,'~', paste(covs[[X]],collapse='+')))
names(formulas) <- universo.fen



library(solarius)
modelos <- llply(formulas, function(X) solarPolygenic(formula=as.formula(X),data=dat))

kk <- ldply(modelos,function(X) X$resf[,3,drop=FALSE])
kk <- ldply(modelos,function(X) X$resf)
library(reshape)
ll <- cast(kk[,c(1,2,4)],formula= id~ .id )
row.names(ll) <- ll$id
ll <- ll[,-which(colnames(ll)=='id')]
colnames(ll) <- paste0('r',colnames(ll))

###############################
##  TEST for imputation      ##
###############################
## before imputation one question:
## Can we believe in the imputations?
library(missMDA)
# estimate the number of dimensions to impute
nbdim <- estim_ncpPCA(ll)
ll.df <- as.data.frame(ll)
kk.comp <- MIPCA(ll.df, ncp = max(nbdim$ncp,4), nboot = 1000)
kk.imp <- imputePCA(ll.df, ncp = max(nbdim$ncp,4))
kk.pca <- PCA(kk.imp$completeObs)

plot(kk.comp)
?pool
## Diagnostics
kk.over<-Overimpute(kk.comp)

## little art
library(kandinsky)
kandinsky(kk)


## MIMCA can be used for categorical data
## res <- MIMCA(vnf, ncp=4,nboot=10)



## first impute because pcout not handle missing values
######################
##  imputation      ##
######################
## 1.- MICE
library(mice)

dis.miss <- c('CVI','VT')
dat <- merge(dat,ll,by='row.names',all.x=TRUE,all.y=FALSE)
row.names(dat) <- dat$id
dat <- dat[,-which(colnames(dat)=='Row.names')]


noResidual <- names(covs)[unlist(lapply(covs,function(X) X[1]==1))]
runiverso.fen <- c(paste0('r',setdiff(universo.fen,noResidual)),noResidual)

kk <- dat[dat$punctured==1,c(runiverso.fen,dis.miss)]
x.mice <- mice(kk,m=10)
kk.mice <- complete(x.mice)
#########
## 2.- Hmisc
library(Hmisc)
imputar <- function(X) {Hmisc::impute(X,fun='random')}
kk.Hmisc <- colwise(imputar)(kk)
row.names(kk.Hmisc) <- row.names(kk)
## i <-39
## i <-38
## table(kk.mice[,i],kk.Hmisc[,i])

## soy conservador y hago la media de ambas imputaciones
kk.imp <- (kk.mice[,runiverso.fen] + kk.Hmisc[,runiverso.fen])/2
kk.imp <- colwise(as.numeric)(kk.imp)
kk.imp$CVI <- factor(kk.Hmisc$CVI)
kk.imp$VT <- factor(kk.Hmisc$VT)
row.names(kk.imp) <- row.names(kk)
source('/home/amartinezp/lib/normalizar.R')
kk.imp.norm <- colwise(normalizar)(kk.imp)
row.names(kk.imp.norm) <- row.names(kk)
colnames(kk.imp.norm) <- paste0('i', colnames(kk))
iruniverso.fen <- paste0('i',runiverso.fen)

dat <- merge(dat,kk.imp.norm,by='row.names',all.x=TRUE,all.y=FALSE)



####################################################
####################################################
## calculo los outliers multivariados
x.out <-  pcout(kk.imp.norm[,iruniverso.fen],makeplot=FALSE)
## sum(x.out$wfinal01==0)
sum(x.out$wfinal < 0.05)
## potential location outlier
sum(x.out$wloc < 0.05)
## potential scatter outlier
sum(x.out$wscat < 0.05)


library(MVN)
x.out2 <- mvOutlier(kk.imp.norm[,iruniverso.fen])
mvOutlier(kk.imp.norm[,iruniverso.fen],method='adj.quan',qqplot=TRUE)


## posibles outliers sin residuos 67201,64205
## posibles outliers en los residuos 33301,49403

chungos <- c('67201','64205')
chungos <- c('33301','49403')
chungosMenos <- c('67201','64205')
chungosMenosMenos <- c('53208','62302','67412')
## habria que ver que le pasa a estos individuos
summary(kk.imp.norm[,iruniverso.fen])
kk.imp.norm[chungos,iruniverso.fen]

tr1 <- 'irSTFR';tr2 <- 'irRUSSELL'
tr1 <- 'irHCYhplc'; tr2 <- 'irCYShplc'
tr1 <- 'irSAMhplc'; tr2 <- 'irHCY'
tr1 <- 'irALBUM'; tr2 <- 'irADAMTS13'
tr1 <- 'irFIBc'; tr2 <- 'irFERRIT'
tr1 <- 'irFIXc'; tr2 <- 'irFLAP'
tr1 <- 'irFVIIc'; tr2 <- 'irFIXc'
tr1 <- 'irFVIIc'; tr2 <- 'irFVIIIc'
tr1 <- 'irFvWAg'; tr2 <- 'irFVIIIc'
tr1 <- 'irFvWAg'; tr2 <- 'irPSfunc'
tr1 <- 'irFvWAg'; tr2 <- 'irGGT'
tr1 <- 'irFvWAg'; tr2 <- 'irGAB2'
tr1 <- 'irMAB2'; tr2 <- 'irGAB2'


corr.plot(kk.imp.norm[,tr1],kk.imp.norm[,tr2],xlab=tr1,ylab=tr2)
text(kk.imp.norm[chungos,c(tr1,tr2)],labels=chungos,col='red')
text(kk.imp.norm[chungosMenos,c(tr1,tr2)],labels=chungosMenos,col='green')

dd.plot(kk.imp.norm[,c(tr1,tr2)])
out.multiples <- dd.plot(kk.imp.norm[,iruniverso.fen])
out.multiples$outliers[out.multiples$outliers]
out.multiples$md.rob[out.multiples$md.rob>100]

############################################################################################################################################################
## conclusion: OUTLIERS MULTIVARIADOS
## Hay dos outliers muy jodidos c('67201','64205')
## Hay dos outliers chungos c('53208','62302','67412')
##
## No parecen ser datos erroneos excepto posiblemente para GAB2,MAB2
## NORMALIZO los traits DESPUES de imputar (PRIMERO IMPUTAR)
## La IMPUTACIÓN, la realizo con "mice" y "Hmisc" y luego hago la media entre ambos.
############################################################################################################################################################

dis.miss <- paste0('i',dis.miss)
save(dat,runiverso.fen,iruniverso.fen,universo.dis,universo.extr,universo.fen,universo,chungos,chungosMenos,out.plot,out.dat,dis.miss,file=file.path(out.dat,'dat.kk.imp.nor.RData'))

















