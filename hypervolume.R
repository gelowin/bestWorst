load('/home/amartinezp/Documents/bestWorst/data/dat.kk.imp.nor.RData')

A more interesting example using the function hypervolume from the package ... hypervolume
(Blonder et al., 2014). We show here several results which differed in there factor that delimit the group
to calculate different hypervolume (argument byfactor).
First, let’s try the hypervolume function one finch data.



library(hypervolume)
hv<-hypervolume(traits.finch.mice, reps = 100,
bandwidth = 0.2, verbose = F, warnings = F)
plot(hv)




Now, we can do the same analysis for each species.




hv.list<-new("HypervolumeList")
hv.list2<-list()
for(i in 1: length(table(sp.finch))) {
hv.list2[[i]]<-hypervolume(traits.finch.mice[sp.finch == levels(sp.finch)[i], ],
reps = 1000,bandwidth = 0.2, verbose = F, warnings = F)
}
hv.list@HVList<-hv.list2
require(adegenet)


colorhv<-transp(funky(nlevels(sp.finch)), alpha = 0.8)
plot(hv.list, colors = colorhv, darkfactor = 0.8)


plot(hv.list,colors=colorhv,darkfactor=0.8,showdata=F,npmax_random=200,cex.random=1)




summary(hv.list)
The standard example of the hypervolume package also use finch data but at the species level.
doHypervolumeFinchDemo=TRUE
demo('finch', package = 'hypervolume')
ComIndexMulti takes the same arguments as ComIndex and an argument by factor to apply the
index on different factors.
#all individual are put in the same group: calculate the hypervolume without by.factor
hv.1<-ComIndexMulti(traits.finch.mice,
index = c("as.numeric(try(hypervolume(na.omit(x), reps = 100,bandwidth = 0.2, verbose = F, warnings = F)@Volume))"),
by.factor = rep(1,length(n_sp_plot)), nullmodels = "regional.ind",
ind.plot = ind.plot.finch, nperm = 99, sp = sp.finch)


hv.2<-ComIndexMulti(traits.finch.mice,
index = c("as.numeric(try(hypervolume(na.omit(x), reps = 100,
bandwidth = 0.2, verbose = F, warnings = F)@Volume))"),
by.factor = n_sp_plot, nullmodels = "regional.ind",
ind.plot = ind.plot.finch, nperm = 99, sp = sp.finch, print = FALSE)
ptm <- proc.time()
hv.3<-ComIndexMulti(traits.finch.mice,
index = c("as.numeric(try(hypervolume(na.omit(x), reps = 100,
bandwidth = 0.2, verbose = F, warnings = F)@Volume))"),
by.factor = ind.plot.finch, nullmodels ="regional.ind",
ind.plot = ind.plot.finch, nperm = 99, sp = sp.finch, print = FALSE)
proc.time_ComIndexMulti <- proc.time() - ptm
hv.4<-ComIndexMulti(traits.finch.mice,
index = c("as.numeric(try(hypervolume(na.omit(x), reps = 100,
bandwidth = 0.2, verbose = F, warnings = F)@Volume))"),
by.factor = sp.finch, nullmodels = "regional.ind",
ind.plot = ind.plot.finch, nperm = 99, sp = sp.finch, print = FALSE)
list.ind.multi<-as.listofindex(list(hv.2, hv.3, hv.4))
ses.list.multi<-ses.listofindex(list.ind.multi)
plot(list.ind.multi)


#Try a zoom on the area near zero
plot(list.ind.multi, xlim = c(-200,20))


Compare hypervolume to Villeger’s metrics convex hull.
require("geometry")

FA<-as.character("FA")
funct<-c("round(convhulln(x,FA)$vol,6)")
##Null model local is trivial for this function
##because randomization is within community only
Fdis.finch<-ComIndexMulti(traits.finch.mice,
index = funct,
by.factor = ind.plot.finch, nullmodels = "local",
ind.plot = ind.plot.finch, nperm = 99, sp = sp.finch)


list.ind.multi2<-as.listofindex(list(hv.3, Fdis.finch))
ses.list.multi2<-ses.listofindex(list.ind.multi2)
plot(list.ind.multi2)










