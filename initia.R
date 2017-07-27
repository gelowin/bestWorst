
## cargo datos
source('/home/amartinezp/lib/load.fenoGAIT2.R')
load.fenoGAIT2()

## cargo librerias
library(ggplot2)
library(plyr)
library(cluster)
library(reshape2)
library(broom)

out.plot <- '/home/amartinezp/Documents/bestWorst/plots'
dir.create(out.plot,showWarnings=FALSE)
out.dat <- '/home/amartinezp/Documents/bestWorst/data'
dir.create(out.dat,showWarnings=FALSE)


## universo.fen <- unique(c(
##     f1$getTraits('fn.proteinPURE'),
##     f1$getTraits('fn.bloodCount'),
 ##    f1$getTraits('fn.homocysteine'),
##     f1$getTraits('fn.fibrinolysis'),
    ##     f1$getTraits('fn.thromboelastogram'),
##     f1$getTraits('fn.generalBiochemistry'),
 ##    f1$getTraits('fn.factors'),
##     f1$getTraits('fn.plateletsParameters')) 
##                        )

universo.fen <- unique(c(f1$getTraits('fn.proteinPURE'),f1$getTraits('fn.homocysteine'),f1$getTraits('fn.generalBiochemistry')))
universo.fen <- setdiff(universo.fen,c("PSfree","lnFXIc","lnFvWAg","lnFVIIIc","lnFVIIc"))

##     VT~FXIc+FXIIc+FvWAg+STFR+RUSSELL+PSfunc+Pcam+MAPS+MAB2+lnFXIc+lnFvWAg+lnFVIIIc+lnFVIIc+HB+HAPTO+GGT+GAPS+GAB2+FXIIc+FXIc+FvWAg+FVIIIc+FVIIc+FosAl+FLAP+FIXc+FIBc+FERRIT+CREAT+ATIIIf+AST+ALT+ALBUM+ADAMTS13


  universo.dis <- setdiff(
   c( f1$getTraits('puncturedDay'),f1$getTraits('normalDiseases')),c('AOOvt','linearPredictorVTcoxme'))

universo.extr <- unique(c(f1$getTraits('solar'),
                          setdiff(f1$getTraits('covariates'),c('AGE2','AB0dA')),'bmi','punctured'))


universo <- unique(c(universo.extr,universo.fen,universo.dis))
f1$setTraits(universo)
dat <- f1$getData()



####################################
## test for missings:             ##
####################################


## first I evaluate if there is too much missings
library(ggplot2)
library(naniar)
library(dplyr)
vis_miss(dat)
vis_miss(dat[dat$punctured==1,])
library(VIM)
aggr(dat[dat$punctured==1,universo.fen])
## we observe some variants not with too many missings.
gg_missing_var(dat[dat$punctured==1,])
##############
## missing correlation percentaje plot
kk2 <- dat[dat$punctured==1,c(universo.fen,universo.dis)]
pMiss <- function(x){round(sum(is.na(x))/length(x)*100,2)}
pMiss.dat <- data.frame(phenos=names(kk2),proportionMissing=apply(kk2,2,pMiss))
pMiss.dat <- arrange(pMiss.dat,proportionMissing)
pMiss.dat$phenos <- factor(pMiss.dat$phenos,levels=pMiss.dat$phenos)
pMiss.plot <- ggplot(data=pMiss.dat,aes(x=phenos,y=proportionMissing))  + geom_bar(stat='identity') + coord_flip() + geom_text(data=pMiss.dat,aes(x=phenos,y=-0.2,label=paste0(proportionMissing,"%"))) + xlab('') + ylab('proportion of missing per variable')

ggsave(pMiss.plot, filename=file.path(out.plot,'missing.percent.pdf'),width=11,height=11)



kk2 <- t(dat[dat$punctured==1,c(universo.fen,universo.dis)])

pMiss.dat <- data.frame(phenos=colnames(kk2),proportionMissing=apply(kk2,2,pMiss))
pMiss.dat <- arrange(pMiss.dat,proportionMissing)
pMiss.dat$phenos <- factor(pMiss.dat$phenos,levels=pMiss.dat$phenos)
## only plot subject with proportion of missin > 5%
pMiss.dat <- filter(pMiss.dat,proportionMissing >5)
pMiss.plot.id <- ggplot(data=pMiss.dat,aes(x=phenos,y=proportionMissing))  + geom_bar(stat='identity') + coord_flip() + geom_text(data=pMiss.dat,aes(x=phenos,y=-1,label=paste0(proportionMissing,"%"))) + xlab('') + ylab('proportion of missing per variable')

ggsave(pMiss.plot.id, filename=file.path(out.plot,'missing.percent.id.pdf'),width=11,height=11)
########################################3
## plot missiness per family
pMiss <- function(x){round(sum(is.na(x))/length(x)*100,1)}

kkl <- ddply(dat[dat$punctured==1,], .(FAM), colwise(pMiss))
kkl <- kkl[ , !apply(kkl,2, function(X) all(X==0))]
kkl.melt <- melt(kkl,id.vars='FAM') 

for(i in unique(kkl.melt$variable))
{
    k <- ggplot(data=kkl.melt[kkl.melt$variable==i,],aes(x=FAM,y=value)) + geom_bar(stat='identity') + coord_flip() + geom_text(data=kkl.melt[kkl.melt$variable==i,],aes(x=FAM,y=-1,label=paste0(value,"%")))+xlab('') + ylab(paste0('percentaje of missing per family in ',i))
    ggsave(k, filename=file.path(out.plot,paste0('missing.perFAM.',i,'.pdf')),width=12,height=12)
}





########################################################
## missing correlation image plot per VT
########################################################
## Create data frame indicating missingness by 1
## como VT no tiene missing para ver la diferencia entre missing entre casos y controles pongo missings a los casos
dat2 <- dat[dat$punctured==1,]

## esta linea hace que veamos diferencias si hubiese diferente patron por tener trombosis o no
dat2$VT[dat2$VT == 1] <- NA
## esta linea hace que veamos diferencias si hubiese diferente patron por SEXO
dat2$SEX[dat2$SEX == 'F'] <- NA
x <- as.data.frame(abs(is.na(dat2)))
## Select columns with some (but not all) missing values
y <- x[,sapply(x, sd) > 0]

## Create a correlation matrix: Variables missing together have high correlation
k <- cor(y)

reorder_cormat <- function(cormat){
# Use correlation between variables as distance
dd <- as.dist((1-cormat)/2)
hc <- hclust(dd)
cormat <-cormat[hc$order, hc$order]
}
## Get upper triangle of the correlation matrix
get_upper_tri <- function(cormat){
    cormat[lower.tri(cormat)]<- NA
    return(cormat)
}

k <- reorder_cormat(k)

    ## diag(k) <- NA
## meltedK <- melt(get_upper_tri(k))
meltedK <- melt(k)
meltedK <- mutate(meltedK, alpha=abs(value))

## image with de correlation of missing values

mv.cor.plot <- ggplot(meltedK, aes(x=Var1, y=Var2, fill=value)) + geom_raster() + scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 0, limit = c(-1,1), name="missing values\nCorrelation") + xlab('') + ylab('') + coord_fixed() + theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
ggsave(mv.cor.plot, filename=file.path(out.plot,'missingCorreletion.VT.sex.pdf'),width=11,height=11)
########################################################
## finish missing correlation image plot
########################################################


save(universo,universo.dis,universo.extr,universo.fen,out.plot,out.dat,dat,file=file.path(out.dat,'01seleccion.RData'))



