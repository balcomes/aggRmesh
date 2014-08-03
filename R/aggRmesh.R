
.aggrmesh <- function(object, method, n, ...){
  
  METHODS <- c("metab2mesh","gene2mesh","mesh2metab","mesh2gene")
  mcheck <- pmatch(method, METHODS)
  if (is.na(mcheck)){
    stop("Invalid method!")
  }
  if ( mcheck == -1){ 
    stop("Ambiguous method!")
  }
  
  if(method=="metab2mesh"){
    cat(paste("\nUsing metab2mesh.\n"))
  }
  if(method=="gene2mesh"){
    cat(paste("\nUsing gene2mesh.\n"))
  }
  if(method=="mesh2metab"){
    cat(paste("\nUsing mesh2metab.\n"))
  }
  if(method=="mesh2gene"){
    cat(paste("\nUsing mesh2gene.\n"))
  }
    
  if(method=="metab2mesh"){
    result <- sapply(object,
                     function(x){
                       x = metab2mesh(x)$MeSH.Descriptor.Name
                     })
  }

  if(method=="gene2mesh"){
    result <- sapply(object,
                     function(x){
                       x = gene2mesh(x)$MeSH.Descriptor.Name
                     })
  }
  if(method=="mesh2metab"){
    result <- sapply(object,
                     function(x){
                       x = mesh2metab(x)$Compound.Name
                     })
  }
  
  if(method=="mesh2gene"){
    result <- sapply(object,
                     function(x){
                       x = mesh2gene(x)$Gene.Identifier
                     })
  }
  
  result <- result[!sapply(result, is.null)]
  cat(names(result))
  
  m <- min(sapply(result,length))
  if(m<n){
    n <- m
    warning("Short entry, using n = min instead")
  }
  
  return(RankAggreg(do.call(rbind,lapply(result,function(x){x[1:n]})),n))
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