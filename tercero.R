library(plyr)



load('/home/amartinezp/Documents/bestWorst/data/dat.kk.imp.nor.RData')

row.names(dat) <- dat$Row.names
dat <- dat[ , -c(which(colnames(dat)=='Row.names'))]





##############################################
#######         t-SNE                 ########
##############################################
library(Rtsne)
library(plyr)
library(dplyr)



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





library('GGally')
dat$fVT <- factor(dat$VT,labels=c('control','VT'))

############################################################################################################################
save(list=ls(),file=file.path(out.dat,'dat.imp.nor.rtsne.RData'))
############################################################################################################################


dimensiones <- 3
con <- paste0(paste0('tsne.',dimensiones),'.',1:dimensiones)
ggpairs(subset(dat,select=c('fVT','SEX',con)),mapping=ggplot2::aes(color=fVT))



library(plotly)





      
p <- plot_ly(dat, x = ~tsne.3.1, y = ~tsne.3.2, z = ~tsne.3.3, color = ~fVT, size = ~AGE,  colors = c('#0C4B8E','#BF382A' ),
             marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(3, 10),
             text = ~paste('Subject:',id,'<br>Family:', FAM, '<br>Age:', round(AGE,0))) %>%
  layout(title = 't-SNE of GAIT2 proteins related with VT',
         scene = list(xaxis = list(title = 't-SNE 1',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat$tsne.3.1,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
               yaxis = list(title = 't-SNE 2',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat$tsne.3.2,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
               zaxis = list(title = 't-SNE 3',
                            gridcolor = 'rgb(255, 255, 255)',
                            range =range(dat$tsne.3.3,na.rm=TRUE),
                   ##         type = 'log',
                            zerolinewidth = 1,
                            ticklen = 5,
                            gridwith = 2)),
         paper_bgcolor = 'rgb(243, 243, 243)',
         plot_bgcolor = 'rgb(243, 243, 243)')



# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
# chart_link = plotly_POST(p, filename="bubble")
# chart_link



#############################################
## HCY
#############################################

SEX
smoking
AGE
bmi
PSt
HB
FXIIc
FXIc
FvWAg
FVIIIc
FVIIc
FIXc
FIBc
FERRIT
CREAT
ATIIIf
CYShplc
GLUC
URAT
q1_009
Throm
VT
AT
Asthma
AllerRhi
Adermatitis
Hypertension
hypersensitivity
autoinmune
diabetesMel

## parece ser que está todo muy determinado por el sexo y la edad. Recalcular todo con los residuos.

p.hcy <- plot_ly(dat, x = ~tsne.3.1, y = ~tsne.3.2, z = ~tsne.3.3, color = ~FAM, size = ~as.numeric(VT), ## colors = c('#0C4B8E','#BF382A' ),
             marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(2, 4),
             text = ~paste('Subject:',id,'<br>Family:', FAM, '<br>Age:', round(AGE,0))) %>%
  layout(title = 't-SNE of GAIT2 proteins related with VT',
         scene = list(xaxis = list(title = 't-SNE 1',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat$tsne.3.1,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
               yaxis = list(title = 't-SNE 2',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat$tsne.3.2,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
               zaxis = list(title = 't-SNE 3',
                            gridcolor = 'rgb(255, 255, 255)',
                            range = range(dat$tsne.3.3,na.rm=TRUE),
                   ##         type = 'log',
                            zerolinewidth = 1,
                            ticklen = 5,
                            gridwith = 2)),
         paper_bgcolor = 'rgb(243, 243, 243)',
         plot_bgcolor = 'rgb(243, 243, 243)')##  + coord_polar()
p.hcy
################################


























