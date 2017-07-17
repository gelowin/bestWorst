load('/home/amartinezp/Documents/bestWorst/data/dat.impRes.rtsne.RData')

row.names(dat.impRes.rtsne) <- dat.impRes.rtsne$id

#####################################################################################################################################################################################################################################################################
## unsupervised clustering

my.data <- na.omit(dat.impRes.rtsne[,grep(names(dat.impRes.rtsne),pattern='tsne.3')])



##http://www.sthda.com/english/wiki/factoextra-r-package-easy-multivariate-data-analyses-and-elegant-visualization
library(factoextra)
library("FactoMineR")
## Three popular methods for determining the optimal number of clusters
    Elbow method
        Concept
        Algorithm
        R codes
    Average silhouette method
        Concept
        Algorithm
        R codes
    Conclusions about elbow and silhouette methods
    Gap statistic method
        Concept
        Algorithm
        R codes
####################################################################################################################################
##
## Determine the optimal number of clusters
library(pvclust)
fit <- pvclust(t(my.data), method.hclust='ward.D2',method.dist='euclidean')
fit <- pvclust(my.data, method.hclust='ward.D2',method.dist='euclidean')
## ‘"average"’, ‘"ward.D"’, ‘"ward.D2"’, ‘"single"’,
##          ‘"complete"’, ‘"mcquitty"’, ‘"median"’ or ‘"centroid"’.
plot(fit)
pvrect(fit,alpha=.95)
##
library(mclust)
fit2 <- Mclust(my.data)
plot(fit2)
3

summary(fit2)
library(forcats)

Ftsne6 <- as_factor(paste0('Ftsne3.',as.character(fit2$classification)))
fct_count(Ftsne6)
## Generate the dummies variables from the factor.
###############################
model.matrix(~Ftsne6)
## o bien
library(dummies)
dummies <- cbind(df, dummy(Ftsne6, sep='.'))
library(mlr)
dummies <- createDummyFeatures(Ftsne6)

#...........................................

a <- fviz_nbclust(my.data, kmeans, method = "gap_stat")
nclusters <- 3



library(NbClust)


## calculate 30 indices for determine optimal number of cluster
nb <- NbClust(my.data, distance = "euclidean", min.nc = 2,
              max.nc = 10, method = "ward.D2", index ="all")

fviz_nbclust(nb) + theme_minimal()

####################################################################################################################################


##
##Partitioning clustering
## compute kmeans
tsne.res <- kmeans(scale(my.data), nclusters, nstart = 25)
## visualize
fviz_cluster(tsne.res,data=my.data, ggtheme = theme_minimal(),main = "Partitioning Clustering tsne")
## pintar ahora pacientes con diferentes enfermedades.
##Partitioning clustering
## compute kmeans
nclusters <- 9
tsne.res <- kmeans(scale(my.data), nclusters, nstart = 25)
## visualize
fviz_cluster(tsne.res,data=my.data, ggtheme = theme_minimal(),main = "Partitioning Clustering tsne")
## pintar ahora pacientes con diferentes enfermedades.
##..............................................................................................................................................
## conclusion
## numero de grupos == 5
## numero de grupos == 10
##..............................................................................................................................................



##
## Hierarchical clustering
## Compute hierarchical clustering and cut into "nclusters" clusters
nclusters <- 5
res <- hcut(my.data, k = nclusters, stand = TRUE)
fviz_dend(res, rect = TRUE, cex = 0.5)


## cluster tendency
get_clust_tendency(my.data, n = 50,
                   gradient = list(low = "steelblue",  high = "white"))


library(clustertend)
Methods for assessing clustering tendency

    Hopkins statistic
        Algorithm
        R function for computing Hopkins statistic: clustertend::hopkins()
    VAT: Visual Assessment of cluster Tendency: seriation::dissplot()
        VAT Algorithm
        R functions for VAT

A single function for Hopkins statistic and VAT: factoextra::get_clust_tendency()

library(clustertend)

library("fpc")
library("dbscan")
db <- fpc::dbscan(my.data, eps = 0.15, MinPts = 5)
plot(db, my.data, main = "DBSCAN", frame = FALSE)
fviz_cluster(db, df, stand = FALSE, frame = FALSE, geom = "point")
print(db)
## 5 Method for determining the optimal eps value
dbscan::kNNdistplot(my.data, k =  5)
abline(h = 0.15, lty = 2)

##          k_colors = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"))

## comparing 2 cluster solutions
## library(fpc)
## cluster.stats(d, fit1$cluster, fit2$cluster) 

##ejercicio
##https://www.datacamp.com/courses/introduction-to-machine-learning-with-r
#####################################################################################################################################################################################################################################################################

library(ggplot2)
ggpairs(dat.plot[,c('q1_003','SEX',colnames(kk6))],mapping=ggplot2::aes(color=q1_003) )
ggplot(dat.plot,aes(ts3,ts5,color=q1_003)) + geom_point()
ggplot(dat.plot,aes(ts1,ts5,color=q1_003)) + geom_point()




ggpairs(dat.plot[,c('q1_004','SEX',colnames(kk6))],mapping=ggplot2::aes(color=q1_004) )

ggpairs(dat.plot[,c('q1_005','SEX',colnames(kk6))],mapping=ggplot2::aes(color=q1_005) )
ggplot(dat.plot,aes(ts1,ts5,color=q1_005)) + geom_point()


ggpairs(dat.plot[,c('q1_007','SEX',colnames(kk6))],mapping=ggplot2::aes(color=q1_007) )
##ggplot(dat.plot,aes(ts5,ts6,color=q1_007)) + geom_point()




ggpairs(dat.plot[,c('q1_009','SEX',colnames(kk6))],mapping=ggplot2::aes(color=q1_009) )

ggpairs(dat.plot[,c('AT','SEX',colnames(kk6))],mapping=ggplot2::aes(color=AT) )
ggplot(dat.plot,aes(ts3,ts5,color=AT)) + geom_point()

ggpairs(dat.plot[,c('VT','SEX',colnames(kk6))],mapping=ggplot2::aes(color=VT) )
ggplot(dat.plot,aes(ts3,ts5,color=VT)) + geom_point()


ggpairs(dat.plot[,c('Throm','SEX',colnames(kk6))],mapping=ggplot2::aes(color=Throm) )
ggplot(dat.plot,aes(ts3,ts5,color=Throm)) + geom_point()


ggpairs(dat.plot[,c('Asthma','SEX',colnames(kk6))],mapping=ggplot2::aes(color=Asthma) )


ggpairs(dat.plot[,c('AllerRhi','SEX',colnames(kk6))],mapping=ggplot2::aes(color=AllerRhi) )


ggpairs(dat.plot[,c('Psori','SEX',colnames(kk6))],mapping=ggplot2::aes(color=Psori) )
## ts1,ts3 realcion con el sexo y Psori

ggpairs(dat.plot[,c('Adermatitis','SEX',colnames(kk6))],mapping=ggplot2::aes(color=Adermatitis) )
ggplot(dat.plot,aes(ts1,ts5,color=Adermatitis)) + geom_point()
ggplot(dat.plot,aes(ts1,ts4,color=Adermatitis)) + geom_point()
ggplot(dat.plot,aes(ts4,ts5,color=Adermatitis)) + geom_point()


ggpairs(dat.plot[,c('RheArt','SEX',colnames(kk6))],mapping=ggplot2::aes(color=RheArt) )


ggpairs(dat.plot[,c('Hypertension','SEX',colnames(kk6))],mapping=ggplot2::aes(color=Hypertension) )
ggplot(dat.plot,aes(ts3,ts5,color=Hypertension)) + geom_point()


ggpairs(dat.plot[,c('Malignancy','SEX',colnames(kk6))],mapping=ggplot2::aes(color=Malignancy) )


ggpairs(dat.plot[,c('AIThyroid','SEX',colnames(kk6))],mapping=ggplot2::aes(color=AIThyroid) )


ggpairs(dat.plot[,c('hypersensitivity','SEX',colnames(kk6))],mapping=ggplot2::aes(color=hypersensitivity) )


ggpairs(dat.plot[,c('autoinmune','SEX',colnames(kk6))],mapping=ggplot2::aes(color=autoinmune) )


ggpairs(dat.plot[,c('diabetesMel','SEX',colnames(kk6))],mapping=ggplot2::aes(color=diabetesMel) )
ggplot(dat.plot,aes(ts3,ts5,color=diabetesMel)) + geom_point()


ggpairs(dat.plot[,c('CVI','SEX',colnames(kk6))],mapping=ggplot2::aes(color=CVI) )


ggpairs(dat.plot[,c('coronaryHeart','SEX',colnames(kk6))],mapping=ggplot2::aes(color=coronaryHeart) )
ggplot(dat.plot,aes(ts3,ts5,color=coronaryHeart)) + geom_point()


ggpairs(dat.plot[,c('q0_116','SEX',colnames(kk6))],mapping=ggplot2::aes(color=q0_116) )

ggpairs(dat.plot[,c('q0_118','SEX',colnames(kk6))],mapping=ggplot2::aes(color=q0_118) )



ggpairs(dat.plot[,c('FAM','VT','SEX',colnames(kk6))],mapping=ggplot2::aes(color=FAM) )

boxplot(dat.plot[,colnames(kk6.2)[3]]~factor(dat.plot$FAM)) 
## el componente 3 parece algo relacionado con la familia

#########################################################


library(ggplot2)
ggpairs(dat.plot[,c('q1_003','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=q1_003) )
ggplot(dat.plot,aes(ts2.3,ts2.5,color=q1_003)) + geom_point()
ggplot(dat.plot,aes(ts1,ts2.5,color=q1_003)) + geom_point()




ggpairs(dat.plot[,c('q1_004','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=q1_004) )

ggpairs(dat.plot[,c('q1_005','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=q1_005) )
ggplot(dat.plot,aes(ts2.1,ts2.5,color=q1_005)) + geom_point()


ggpairs(dat.plot[,c('q1_007','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=q1_007) )
##ggplot(dat.plot,aes(ts2.5,ts6,color=q1_007)) + geom_point()




ggpairs(dat.plot[,c('q1_009','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=q1_009) )

ggpairs(dat.plot[,c('AT','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=AT) )
ggplot(dat.plot,aes(ts2.3,ts2.5,color=AT)) + geom_point()

ggpairs(dat.plot[,c('VT','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=VT) )
ggplot(dat.plot,aes(ts2.3,ts2.5,color=VT)) + geom_point()


ggpairs(dat.plot[,c('Throm','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=Throm) )
ggplot(dat.plot,aes(ts2.3,ts2.5,color=Throm)) + geom_point()


ggpairs(dat.plot[,c('Asthma','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=Asthma) )


ggpairs(dat.plot[,c('AllerRhi','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=AllerRhi) )


ggpairs(dat.plot[,c('Psori','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=Psori) )
## ts1,ts2.3 realcion con el sexo y Psori

ggpairs(dat.plot[,c('Adermatitis','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=Adermatitis) )
ggplot(dat.plot,aes(ts2.1,ts2.5,color=Adermatitis)) + geom_point()
ggplot(dat.plot,aes(ts2.3,ts2.4,color=Adermatitis)) + geom_point()
ggplot(dat.plot,aes(ts2.4,ts2.5,color=Adermatitis)) + geom_point()


ggpairs(dat.plot[,c('RheArt','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=RheArt) )


ggpairs(dat.plot[,c('Hypertension','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=Hypertension) )
ggplot(dat.plot,aes(ts2.3,ts2.5,color=Hypertension)) + geom_point()


ggpairs(dat.plot[,c('Malignancy','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=Malignancy) )


ggpairs(dat.plot[,c('AIThyroid','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=AIThyroid) )


ggpairs(dat.plot[,c('hypersensitivity','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=hypersensitivity) )


ggpairs(dat.plot[,c('autoinmune','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=autoinmune) )


ggpairs(dat.plot[,c('diabetesMel','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=diabetesMel) )
ggplot(dat.plot,aes(ts2.3,ts2.5,color=diabetesMel)) + geom_point()


ggpairs(dat.plot[,c('CVI','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=CVI) )


ggpairs(dat.plot[,c('coronaryHeart','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=coronaryHeart) )
ggplot(dat.plot,aes(ts2.3,ts2.5,color=coronaryHeart)) + geom_point()


ggpairs(dat.plot[,c('q0_116','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=q0_116) )

ggpairs(dat.plot[,c('q0_118','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=q0_118) )



ggpairs(dat.plot[,c('FAM','VT','SEX',colnames(kk6.2))],mapping=ggplot2::aes(color=FAM) )

boxplot(dat.plot[,colnames(kk6.2)[6]]~factor(dat.plot$FAM))


save(universo,universo.dis,universo.extr,universo.fen,dat,dat.plot,out.dat,out.plot,file=file.path(out.dat,'03tsne.RData'))

## jugar también con las iteracciones a ver si puedo separar mas los clusters

## repetir el t-SNE en 3 dimensiones
## mirar los mapas también colapsando enfermedades.

##############################################
#######        hypervolume            ########
##############################################
## Ahora he de construir la lista de hipervolumenes con las enfermedades.
## luego podré mirar que unicidades tienen los hipervolumenes y que intersecciones.
## explorar si a los hipervolumenes se le pueden poner pesos diferentes según su importancia.


hv_finches_list = new("HypervolumeList")







> doHypervolumeFinchDemo=TRUE
> demo(finch)

if (exists('doHypervolumeFinchDemo')==TRUE)
+ {
+   data(morphSnodgrassHeller)
+   finch_isabela <- morphSnodgrassHeller[morphSnodgrassHeller$IslandID=="Isa_Alb",]
+ 
+   # select trait axes
+   trait_axes <- c("BodyL","WingL","TailL","BeakW")
+   traitdata <- finch_isabela[,c("TaxonOrig",trait_axes)]
+   # keep complete cases only
+   traitdata <- na.omit(traitdata)
+   
+   species_list = as.character(unique(traitdata$TaxonOrig))
+   num_species = length(species_list)  
+ 
+   # compute hypervolumes for each species  
+   hv_finches_list = new("HypervolumeList")
+   hv_finches_list@HVList = vector(mode="list",length=num_species)
+   for (i in 1:num_species)
+   {
+     # keep the trait data 
+     data_this_species = traitdata[traitdata$TaxonOrig==species_list[i],trait_axes]
+     # log-transform to rescale
+     data_this_species_log <- log10(data_this_species)
+     
+     # make a hypervolume using auto-bandwidth
+       hv_finches_list@HVList[[i]] <- hypervolume(data_this_species_log, 
+                                           bandwidth=estimate_bandwidth(data_this_species_log),
+                                           name=as.character(species_list[i]), warn=FALSE)
+   }
+   
+   # compute all pairwise overlaps
+   overlap = matrix(NA, nrow=num_species, ncol=num_species)
+   dimnames(overlap)=list(species_list, species_list)
+   for (i in 1:num_species)
+   {
+     for (j in i:num_species)
+     {
+       if (i!=j)
+       {
+         # compute set operations on each pair
+         this_set = hypervolume_set(hv_finches_list@HVList[[i]], hv_finches_list@HVList[[j]], check_memory=FALSE)
+         # calculate a Sorensen overlap index (2 x shared volume / sum of |hv1| + |hv2|)
+         overlap[i,j] = hypervolume_sorensen_overlap(this_set)
+       }
+     }   
+   }


+   # show all hypervolumes
+   plot(hv_finches_list)
+   
+   # show pairwise overlaps - note that actually very few species overlap in four dimensions
+   op <- par(mar=c(10,10,1,1))
+   image(x=1:nrow(overlap), y=1:nrow(overlap), z=overlap,axes=F,xlab='',ylab='',col=rainbow(5))
+   box()
+   axis(side=1, at=1:(length(dimnames(overlap)[[1]])),dimnames(overlap)[[1]],las=2,cex.axis=0.75)
+   axis(side=2, at=1:(length(dimnames(overlap)[[2]])),dimnames(overlap)[[2]],las=1,cex.axis=0.75)
+   par(op)
+   
+   # reset to original state
+   rm(doHypervolumeFinchDemo)
+ } else
+ {
+   message('Demo does not run by default to meet CRAN runtime requirements.')
+   message('This demo requires approximately 3 minutes to run.')  
+   message('To run the demo, type')
+   message('\tdoHypervolumeFinchDemo=TRUE')
+   message('\tdemo(finch)')
+   message('at the R command line prompt.')
+ }

library(MASS)
library(clusterfly)
library(meifly)

kk_dat <- qda(VT ~ tsne.3.1 + tsne.3.2 + tsne.3.3 ,dat.impRes.rtsne)

nTsne <- grep(names(dat.impRes.rtsne),pattern='tsne.')


o <- clusterfly(dat.impRes.rtsne[,nTsne], extra = dat.impRes.rtsne[,c('VT','Psori','Hypertension')])




cfly_show(o, 'VT')










fn.pathways = list(
    cc.intrinsic.contact = c('FXIIc',
        'FXIc',
        'FIXc',
        'FVIIIc',
        'APTT',
                             ),
    cc.extrinsic.TF = c('FVIIc',
        'PT',
                        ),
    cc.comun = c("ATIIIf", "FIBc"       ),
    cc.fibrinolisis = c()
    
)




  fn.times =c('APCR',
                                     'APTT',
                                     'PT',
                                     'RTMTH',
                                     'THRGEN',
                                     'TMTHG',
                                     'TT'),
                   fn.factors = c('FIBc',
                                     'FIXc',
                                     'FVIIc',
                                     'FVIIIc',
                                     'FXIc',
                                     'FXIIc',
                                     'TGTlagtime',
                                     'TGTETP',
                                     'TGTPeak',
                                     'ADAMTS13',
                                     'FvWAg'),
                   fn.inhibitors = c('ATIIIf',
                                     'Pcam',
                                     'PSfree',
                                     'PSfunc',
                                     'PSt'),
                   fn.antiphospholipidAntibodies = c('GAB2',
                                     'GACA',
                                     'GAFS',
                                     'GAPS',
                                     'MAB2',
                                     'MACA',
                                     'MAFS',
                                     'MAPS',
                                     'RUSSELL'),
                              fn.fibrinolysis = c('Lclisis',
                                     'LclisisTM',
                                     'AUC',
                                     'CR_C',
                                     'CR_L',
                                     'DDimer',
                                     'Lag_C',
                                     'Lag_L',
                                     'LR',
                                     'Lys50_Lag',
                                     'Lys50_MA',
                                     'Lys50_t0',
                                     'Lys_T',
                                     'MaxAbs_C',
                                  'MaxAbs_L'),

































