library(plyr)



load('/home/amartinezp/Documents/bestWorst/data/dat.kk.imp.nor.RData')

row.names(dat) <- dat$Row.names
dat <- dat[ , -c(which(colnames(dat)=='Row.names'))]





##############################################
#######         t-SNE                 ########
##############################################
library(Rtsne)
library(plyr)




rtsneDims <- function(X){
    a <- Rtsne(as.matrix(dat[dat$punctured==1,iruniverso.fen]),dims = X,pca=FALSE,pca_center=FALSE, theta=0.0)
    colnames(a$Y) <- paste0('tsne.',X,'.',1:X)
    row.names(a$Y) <- dat[dat$punctured==1,'id']
    return(a)
}

bunchRtsne <- llply(.fun = rtsneDims,2:4)


a.li <-cbind(as.data.frame(bunchRtsne[[1]]$Y),
            as.data.frame(bunchRtsne[[2]]$Y),
            as.data.frame(bunchRtsne[[3]]$Y))
rm(bunchRtsne)
a.li$id <- row.names(a.li)
dat <- join(dat,a.li,by='id')
rm(a.li)
row.names(dat) <- dat$id
save(list=ls(),file=file.path(out.dat,'dat.imp.nor.rtsne.RData'))





























