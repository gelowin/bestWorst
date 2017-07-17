
load('/home/amartinezp/Documents/bestWorst/data/dat.imp.nor.res.RData')


##############################################
#######         t-SNE                 ########
##############################################
library(Rtsne)
library(plyr)




rtsneDims <- function(X){
    a <- Rtsne(as.matrix(dat[dat$punctured==1,universo.fen]),dims = X,pca=FALSE,pca_center=FALSE, theta=0.0)
    colnames(a$Y) <- paste0('tsne.',X,'.',1:X)
    row.names(a$Y) <- dat[dat$punctured==1,'id']
    return(a)
}

bunchRtsne <- llply(.fun = rtsneDims,2:4)


a.li <-cbind(as.data.frame(bunchRtsne[[1]]$Y),
            as.data.frame(bunchRtsne[[2]]$Y),
            as.data.frame(bunchRtsne[[3]]$Y))

a.li$id <- row.names(a.li)
dat.impRes.rtsne <- join(dat,a.li,by='id')
rm(a.li)


###############################
save(dat.impRes.rtsne,universo.dis,universo.extr,universo.fen,universo,chungos,chungosMenos,out.plot,out.dat,file=file.path(out.dat,'dat.impRes.rtsne.RData'))








library('GGally')

dat.impRes.rtsne$VT <- factor(dat.impRes.rtsne$VT,labels=c('control','VT'))

dimensiones <- 3
con <- paste0(paste0('tsne.',dimensiones),'.',1:dimensiones)
ggpairs(subset(dat.impRes.rtsne,select=c('VT','SEX',con)),mapping=ggplot2::aes(color=VT))



library(plotly)


      
p <- plot_ly(dat.impRes.rtsne, x = ~tsne.3.1, y = ~tsne.3.2, z = ~tsne.3.3, color = ~VT, size = ~AGE,  colors = c('#0C4B8E','#BF382A' ),
             marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(3, 10),
             text = ~paste('Subject:',id,'<br>Family:', FAM, '<br>Age:', round(AGE,0))) %>%
  layout(title = 't-SNE of GAIT2 proteins related with VT',
         scene = list(xaxis = list(title = 't-SNE 1',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat.impRes.rtsne$tsne.3.1,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
               yaxis = list(title = 't-SNE 2',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat.impRes.rtsne$tsne.3.2,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
               zaxis = list(title = 't-SNE 3',
                            gridcolor = 'rgb(255, 255, 255)',
                            range =range(dat.impRes.rtsne$tsne.3.3,na.rm=TRUE),
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

p <- plot_ly(dat.impRes.rtsne, x = ~tsne.3.1, y = ~tsne.3.2, z = ~tsne.3.3, color = ~autoinmune, size = ~as.numeric(VT),  colors = c('#0C4B8E','#BF382A' ),
             marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(3, 10),
             text = ~paste('Subject:',id,'<br>Family:', FAM, '<br>Age:', round(AGE,0))) %>%
  layout(title = 't-SNE of GAIT2 proteins related with VT',
         scene = list(xaxis = list(title = 't-SNE 1',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat.impRes.rtsne$tsne.3.1,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
               yaxis = list(title = 't-SNE 2',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat.impRes.rtsne$tsne.3.2,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
               zaxis = list(title = 't-SNE 3',
                            gridcolor = 'rgb(255, 255, 255)',
                            range = range(dat.impRes.rtsne$tsne.3.3,na.rm=TRUE),
                   ##         type = 'log',
                            zerolinewidth = 1,
                            ticklen = 5,
                            gridwith = 2)),
         paper_bgcolor = 'rgb(243, 243, 243)',
         plot_bgcolor = 'rgb(243, 243, 243)')
p
################################
























dat.impRes.rtsne$FAM <- as.factor(dat.impRes.rtsne$FAM)
      
p.fam <- plot_ly(dat.impRes.rtsne, x = ~tsne.3.1, y = ~tsne.3.2, z = ~tsne.3.3, color = ~FAM, size = ~as.numeric(VT), ## colors = c('#0C4B8E','#BF382A' ),
             marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(3, 10),
             text = ~paste('Subject:',id,'<br>Family:', FAM, '<br>Age:', round(AGE,0))) %>%
  layout(title = 't-SNE of GAIT2 proteins related with VT',
         scene = list(xaxis = list(title = 't-SNE 1',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat.impRes.rtsne$tsne.3.1,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
               yaxis = list(title = 't-SNE 2',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = range(dat.impRes.rtsne$tsne.3.2,na.rm=TRUE),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
               zaxis = list(title = 't-SNE 3',
                            gridcolor = 'rgb(255, 255, 255)',
                            range = range(dat.impRes.rtsne$tsne.3.3,na.rm=TRUE),
                   ##         type = 'log',
                            zerolinewidth = 1,
                            ticklen = 5,
                            gridwith = 2)),
         paper_bgcolor = 'rgb(243, 243, 243)',
         plot_bgcolor = 'rgb(243, 243, 243)')


p.fam


##############################################################################
## miramos a ver que pasa en 2 dimensiones
##############################################################################



i <- 2
con <- names(bb3)[grep(names(bb3),pattern=paste0('tsne.',i))]
ggpairs(subset(bb3,select=c('VT','SEX',con)),mapping=ggplot2::aes(color=VT, shape=SEX))

i <- 3
con <- names(bb3)[grep(names(bb3),pattern=paste0('tsne.',i))]
ggpairs(subset(bb3,select=c('VT','SEX',con)),mapping=ggplot2::aes(color=VT, shape=SEX))

 
i <- 4
con <- names(bb3)[grep(names(bb3),pattern=paste0('tsne.',i))]
ggpairs(subset(bb3,select=c('VT','SEX',con)),mapping=ggplot2::aes(color=VT, shape=SEX))

 















############################################################################################################################################################




      


library(scatterplot3d)
scatterplot3d(, pch = 19, color = "green4", main="3D Scatterplot")


with(dat.impRes.rtsne, {
   s3d <- scatterplot3d(tsne.3.1,tsne.3.2,tsne.3.3,        # x y and z axis
                 color=as.numeric(VT), pch=19,        # filled blue circles
                 ##type="h",                    # vertical lines to the x-y plane
                 main="3-D Scatterplot Example 3",
                 xlab="t-sne1",
                 ylab="t-sne2",
                 zlab="t-sne3")
    s3d.coords <- s3d$xyz.convert(tsne.3.1,tsne.3.2,tsne.3.3) # convert 3D coords to 2D projection
    text(s3d.coords$x, s3d.coords$y,             # x and y coordinates
         labels=row.names(dat.impRes.rtsne),               # text to plot
         cex=.5, pos=4)           # shrink text 50% and place to right of points)
})




thdp <- scatterplot3d(dat.impRes.rtsne$tsne.3.1,dat.impRes.rtsne$tsne.3.2,dat.impRes.rtsne$tsne.3.3,
                      color=as.numeric(dat.impRes.rtsne$VT), pch=19,        # filled blue circles
                      ##type="h",                    # vertical lines to the x-y plane
main="3-D Scatterplot Example 3",
xlab="t-sne1",
ylab="t-sne2",
zlab="t-sne3")

  

fitm <- lm(HCY ~ tsne.3.1 + tsne.3.2 + tsne.3.3,data=dat.impRes.rtsne)
thdp$plane3d(fitm)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
                            surface=FALSE, ellipsoid = TRUE)


