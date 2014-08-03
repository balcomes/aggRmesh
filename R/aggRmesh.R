
.aggrmesh <- function(object, method, n, ...){
  
  if(length(object) < 2){
    stop("Need to submit 2 or more queries.")
  }
  
  METHODS <- c("metab2mesh","gene2mesh","mesh2metab","mesh2gene")
  mcheck <- pmatch(method, METHODS)
  if (is.na(mcheck)){
    stop("Invalid method!")
  }
  if ( mcheck == -1){ 
    stop("Ambiguous method!")
  }
      
  if(method=="metab2mesh"){
    message(paste("\nUsing metab2mesh.\n"))
    result <- sapply(object,
                     function(x){
                       x = metab2mesh(x)$MeSH.Descriptor.Name
                     })
  }

  if(method=="gene2mesh"){
    message(paste("\nUsing gene2mesh.\n"))
    result <- sapply(object,
                     function(x){
                       x = gene2mesh(x)$MeSH.Descriptor.Name
                     })
  }
  if(method=="mesh2metab"){
    message(paste("\nUsing mesh2metab.\n"))
    result <- sapply(object,
                     function(x){
                       x = mesh2metab(x)$Compound.Name
                     })
  }
  
  if(method=="mesh2gene"){
    message(paste("\nUsing mesh2gene.\n"))
    result <- sapply(object,
                     function(x){
                       x = mesh2gene(x)$Gene.Identifier
                     })
  }
  
  result <- result[!sapply(result, is.null)]
  
  if(length(result)<2){
    stop("Not enough valid resultsets for RankAggreg to work with.")
  }
  
  n.obs <- sapply(result, length)
  seq.max <- seq_len(max(n.obs))
  mat <- t(sapply(result, "[", i = seq.max))
  mat[is.na(mat)] <- rep(runif(length(mat[is.na(mat)])))

  ra <- RankAggreg(mat,n)
  return(ra$top.list)
}


################################################################################

setGeneric("aggrmesh", function(object, method="metab2mesh", n=10, ...)
  standardGeneric("aggrmesh")
)

setMethod("aggrmesh", 
          signature(object = c("ANY"),
                    method = c("ANY"),
                    n = c("ANY")),
          function(object, method, n, ...){
            .aggrmesh(object=object, method=method, n=n, ...)
          })