library(plyr)



load('/home/amartinezp/Documents/bestWorst/data/dat.kk.imp.nor.RData')

## After imputation, I'm going to calculate the residuals, of the traits for all covariates that interact with each trait.


## data preparation
traits <- names(kk.imp.norm)
dat <- dat[,-c(which(names(dat) %in% traits))]
kk.imp.norm$id <- row.names(kk.imp.norm)

dat <- join(dat,kk.imp.norm,by='id')
row.names(dat) <- dat$id

## data residualization
library(solarius)
## cargo datos
source('/home/amartinezp/lib/load.fenoGAIT2.R')
load.fenoGAIT2()

traits <- setdiff(traits,c('CVI','VT','id'))


i <- 1


for(i in 2:length(traits)){
    covs <- f1$infoTrait(traits[i])$covariates
    covs <- intersect(covs,names(dat))
    if(is.na(covs[1]))
        next
    
    
    formula <- as.formula(paste(traits[i],'~',paste(covs,collapse='+')))
    
    
    mod.k <- solarPolygenic(formula=formula,data=dat,covtest=TRUE,screen = TRUE)
    mod.k.resi <- mod.k$resf[,-2]
    colnames(mod.k.resi)[2] <- traits[i]
    dat <- dat[,-which(colnames(dat) == traits[i])]
    dat <- join(dat,mod.k.resi,by='id')
}


save(dat,traits,universo.dis,universo.extr,universo.fen,universo,chungos,chungosMenos,out.plot,out.dat,file=file.path(out.dat,'dat.imp.nor.res.RData'))

































