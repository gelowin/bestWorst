
load('/home/amartinezp/Documents/bestWorst/data/dat.kk.imp.nor.RData')


##############################################
#######         t-SNE                 ########
##############################################
library(Rtsne)
library(plyr)




rtsneDims <- function(X){
    a <- Rtsne(as.matrix(kk.imp.norm[,universo.fen]),dims = X)
    colnames(a$Y) <- paste0('tsne.',X,'.',1:X)
    row.names(a$Y) <- row.names(kk.imp.norm)
    return(a)
}

bunchRtsne <- llply(.fun = rtsneDims,2:4)


a <- as.data.frame(bunchRtsne[[2]]$Y)
con <- colnames(a)
a$id <- row.names(a)

bb <- join(dat,a,by='id')

library('GGally')


ggpairs(subset(bb,select=c('VT','SEX',con)),mapping=ggplot2::aes(color=VT))



library(plotly)



bb$VT <- factor(bb$VT,labels=c('control','VT'))


      
p <- plot_ly(bb, x = ~tsne.3.1, y = ~tsne.3.2, z = ~tsne.3.3, color = ~VT, size = ~AGE,  colors = c('#0C4B8E','#BF382A' ),
             marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(3, 10),
             text = ~paste('Subject:',id,'<br>Family:', FAM, '<br>Age:', round(AGE,0))) %>%
  layout(title = 't-SNE of GAIT2 proteins related with VT',
         scene = list(xaxis = list(title = 't-SNE 1',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(-19,19),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
               yaxis = list(title = 't-SNE 2',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(-22,18),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
               zaxis = list(title = 't-SNE 3',
                            gridcolor = 'rgb(255, 255, 255)',
                            range = c(-36,27),
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

p <- plot_ly(bb, x = ~tsne.3.1, y = ~tsne.3.2, z = ~tsne.3.3, color = ~FERRIT, size = ~bmi,  colors = c('#0C4B8E','#BF382A' ),
             marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(3, 10),
             text = ~paste('Subject:',id,'<br>Family:', FAM, '<br>Age:', round(AGE,0))) %>%
  layout(title = 't-SNE of GAIT2 proteins related with VT',
         scene = list(xaxis = list(title = 't-SNE 1',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(-19,19),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
               yaxis = list(title = 't-SNE 2',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(-22,18),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
               zaxis = list(title = 't-SNE 3',
                            gridcolor = 'rgb(255, 255, 255)',
                            range = c(-36,27),
                   ##         type = 'log',
                            zerolinewidth = 1,
                            ticklen = 5,
                            gridwith = 2)),
         paper_bgcolor = 'rgb(243, 243, 243)',
         plot_bgcolor = 'rgb(243, 243, 243)')
################################













bb$FAM <- as.factor(bb$FAM)
      
p.fam <- plot_ly(bb, x = ~tsne.3.1, y = ~tsne.3.2, z = ~tsne.3.3, color = ~FAM, size = ~as.numeric(VT), ## colors = c('#0C4B8E','#BF382A' ),
             marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(3, 10),
             text = ~paste('Subject:',id,'<br>Family:', FAM, '<br>Age:', round(AGE,0))) %>%
  layout(title = 't-SNE of GAIT2 proteins related with VT',
         scene = list(xaxis = list(title = 't-SNE 1',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(-19,19),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
               yaxis = list(title = 't-SNE 2',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(-22,18),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
               zaxis = list(title = 't-SNE 3',
                            gridcolor = 'rgb(255, 255, 255)',
                            range = c(-36,27),
                   ##         type = 'log',
                            zerolinewidth = 1,
                            ticklen = 5,
                            gridwith = 2)),
         paper_bgcolor = 'rgb(243, 243, 243)',
         plot_bgcolor = 'rgb(243, 243, 243)')


p.fam














      


library(scatterplot3d)
scatterplot3d(, pch = 19, color = "green4", main="3D Scatterplot")


with(bb, {
   s3d <- scatterplot3d(tsne.3.1,tsne.3.2,tsne.3.3,        # x y and z axis
                 color=as.numeric(VT), pch=19,        # filled blue circles
                 ##type="h",                    # vertical lines to the x-y plane
                 main="3-D Scatterplot Example 3",
                 xlab="t-sne1",
                 ylab="t-sne2",
                 zlab="t-sne3")
    s3d.coords <- s3d$xyz.convert(tsne.3.1,tsne.3.2,tsne.3.3) # convert 3D coords to 2D projection
    text(s3d.coords$x, s3d.coords$y,             # x and y coordinates
         labels=row.names(bb),               # text to plot
         cex=.5, pos=4)           # shrink text 50% and place to right of points)
})




thdp <- scatterplot3d(bb$tsne.3.1,bb$tsne.3.2,bb$tsne.3.3,
                      color=as.numeric(bb$VT), pch=19,        # filled blue circles
                      ##type="h",                    # vertical lines to the x-y plane
main="3-D Scatterplot Example 3",
xlab="t-sne1",
ylab="t-sne2",
zlab="t-sne3")

  

fitm <- lm(HCY ~ tsne.3.1 + tsne.3.2 + tsne.3.3,data=bb)
thdp$plane3d(fitm)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
                            surface=FALSE, ellipsoid = TRUE)


