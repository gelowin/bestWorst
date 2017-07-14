load('/home/amartinezp/Documents/bestWorst/data/01seleccion.RData')


library(plyr)
library(mvoutlier)
#################################################3
## https://www.analyticsvidhya.com/blog/2016/03/tutorial-powerful-packages-imputing-missing-values/
## https://datascienceplus.com/missing-value-treatment/

## first impute because pcout not handle missing values
######################
##  imputation      ##
######################
## 1.- MICE
library(mice)
dis.miss <- c('CVI','VT')
kk <- dat[dat$punctured==1,c(universo.fen,dis.miss)]
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
kk.imp <- (kk.mice[,universo.fen] + kk.Hmisc[,universo.fen])/2
kk.imp <- colwise(as.numeric)(kk.imp)
kk.imp$CVI <- factor(kk.Hmisc$CVI)
kk.imp$VT <- factor(kk.Hmisc$VT)
row.names(kk.imp) <- row.names(kk)
source('/home/amartinezp/lib/normalizar.R')
kk.imp.norm <- colwise(normalizar)(kk.imp)
row.names(kk.imp.norm) <- row.names(kk)

####################################################
####################################################
## calculo los outliers multivariados
x.out <-  pcout(kk.imp[,universo.fen],makeplot=FALSE)
## sum(x.out$wfinal01==0)
sum(x.out$wfinal < 0.05)
## potential location outlier
sum(x.out$wloc < 0.05)
## potential scatter outlier
sum(x.out$wscat < 0.05)


library(MVN)
x.out2 <- mvOutlier(kk.imp[,universo.fen])
mvOutlier(kk.imp[,universo.fen],method='adj.quan',qqplot=TRUE)
## posibles outliers 67201,64205
chungos <- c('67201','64205')
chungosMenos <- c('53208','62302','67412')
## habria que ver que le pasa a estos individuos
summary(kk.imp[,universo.fen])
kk.imp[chungos,universo.fen]

tr1 <- 'STFR';tr2 <- 'RUSSELL'
tr1 <- 'HCYhplc'; tr2 <- 'CYShplc'
tr1 <- 'SAMhplc'; tr2 <- 'HCY'
tr1 <- 'ALBUM'; tr2 <- 'ADAMTS13'
tr1 <- 'FIBc'; tr2 <- 'FERRIT'
tr1 <- 'FIXc'; tr2 <- 'FLAP'
tr1 <- 'FVIIc'; tr2 <- 'FIXc'
tr1 <- 'FVIIc'; tr2 <- 'FVIIIc'
tr1 <- 'FvWAg'; tr2 <- 'FVIIIc'
tr1 <- 'FvWAg'; tr2 <- 'PSfunc'
tr1 <- 'FvWAg'; tr2 <- 'GGT'
tr1 <- 'FvWAg'; tr2 <- 'GAB2'
tr1 <- 'MAB2'; tr2 <- 'GAB2'


corr.plot(kk.imp[,tr1],kk.imp[,tr2],xlab=tr1,ylab=tr2)
text(kk.imp[chungos,c(tr1,tr2)],labels=chungos,col='red')
text(kk.imp[chungosMenos,c(tr1,tr2)],labels=chungosMenos,col='green')

dd.plot(kk.imp[,c(tr1,tr2)])
out.multiples <- dd.plot(kk.imp[,universo.fen])
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


save(dat,kk.imp,kk.imp.norm,universo.dis,universo.extr,universo.fen,universo,chungos,chungosMenos,out.plot,out.dat,file=file.path(out.dat,'dat.kk.imp.nor.RData'))

















