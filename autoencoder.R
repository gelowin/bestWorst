
https://shiring.github.io/machine_learning/2017/05/01/fraud

https://shiring.github.io/machine_learning/2017/05/02/fraud_2

https://www.r-bloggers.com/a-little-h2o-deeplearning-experiment-on-the-mnist-data-set/


## deep autoencoders with h2o

   h2o.init(nthreads = -1) 
anomaly_model <- h2o.deeplearning(   x = names(train),   training_frame = train,   activation = "Tanh",   autoencoder = TRUE,   hidden = c(50,20,50),   sparse = TRUE,   l1 = 1e-4,   epochs = 100)
h2o.shutdown()
## localhost:54321
## http://www.rblog.uni-freiburg.de/2017/02/07/deep-learning-in-r/



    ## el autoencoder hace que en vez de tener grupos de individuos que desarrollan una enfermedad
## lo que tendremos son características de estos individuos que nos hacen desarrollar la enfermedad.
## por ejemplo nos extraerán características como, si hace ejercicio, si tiene componentes genéticas de riesgo, si ha tenido inmobilización.

## se diferencia de un PCA en que en el PCA las características son siempre globales, en el autoencoder, la mayoría son locales.
## se diferencia de un clustering en que el clustering hace grupos de individuos, en el autoencoder, hace grupos de características.

## el PCA es un caso particular del autoencoder.
## Train the autoencoder on unlabeled set of 5000 image patches of 
     ## size Nx.patch by Ny.patch, randomly cropped from 10 nature photos:
     ## Load a training matrix with rows corresponding to training examples, 
     ## and columns corresponding to input channels (e.g., pixels in images):
     data('training_matrix_N=5e3_Ninput=100')  ## the matrix contains 5e3 image 
                                               ## patches of 10 by 10 pixels
     
     ## Set up the autoencoder architecture:
     nl=3                          ## number of layers (default is 3: input, hidden, output)
     unit.type = "logistic"        ## specify the network unit type, i.e., the unit's 
                                   ## activation function ("logistic" or "tanh")
     Nx.patch=10                   ## width of training image patches, in pixels
     Ny.patch=10                   ## height of training image patches, in pixels
     N.input = Nx.patch*Ny.patch   ## number of units (neurons) in the input layer (one unit per pixel)
     N.hidden = 10*10                ## number of units in the hidden layer
     lambda = 0.0002               ## weight decay parameter     
     beta = 6                      ## weight of sparsity penalty term 
     rho = 0.01                    ## desired sparsity parameter
     epsilon <- 0.001              ## a small parameter for initialization of weights 
                                   ## as small gaussian random numbers sampled from N(0,epsilon^2)
     max.iterations = 2000         ## number of iterations in optimizer
     
     ## Train the autoencoder on training.matrix using BFGS optimization method 
     ## (see help('optim') for details):
     ## WARNING: the training can take a long time (~1 hour) for this dataset!
     
     ## Not run:
     
     autoencoder.object <- autoencode(X.train=training.matrix,nl=nl,N.hidden=N.hidden,
               unit.type=unit.type,lambda=lambda,beta=beta,rho=rho,epsilon=epsilon,
               optim.method="BFGS",max.iterations=max.iterations,
               rescale.flag=TRUE,rescaling.offset=0.001)
     ## End(Not run)
     
     ## N.B.: Training this autoencoder takes a long time, so in this example we do not run the above 
     ## autoencode function, but instead load the corresponding pre-trained autoencoder.object.
     
     
     ## Report mean squared error for training and test sets:
     cat("autoencode(): mean squared error for training set: ",
     round(autoencoder.object$mean.error.training.set,3),"\n")
     
     ## Extract weights W and biases b from autoencoder.object:
     W <- autoencoder.object$W
     b <- autoencoder.object$b
     ## Visualize hidden units' learned features:
visualize.hidden.units(autoencoder.object,Nx.patch,Ny.patch)


     ## Compare the output and input images (the autoencoder learns to approximate 
     ## inputs in outputs using features learned by the hidden layer):
     ## Evaluate the output matrix corresponding to the training matrix 
     ## (rows are examples, columns are input channels, i.e., pixels)
     X.output <- predict(autoencoder.object, X.input=training.matrix, hidden.output=FALSE)$X.output 
     
     ## Compare outputs and inputs for 3 image patches (patches 7,26,16 from 
     ## the training set) - outputs should be similar to inputs:
     op <- par(no.readonly = TRUE)  ## save the whole list of settable par's.
     par(mfrow=c(3,2),mar=c(2,2,2,2))
     for (n in c(7,26,16)){
     ## input image:
       image(matrix(training.matrix[n,],nrow=Ny.patch,ncol=Nx.patch),axes=FALSE,main="Input image",
       col=gray((0:32)/32))
     ## output image:
       image(matrix(X.output[n,],nrow=Ny.patch,ncol=Nx.patch),axes=FALSE,main="Output image",
       col=gray((0:32)/32))
     }
     par(op)  ## restore plotting par's




