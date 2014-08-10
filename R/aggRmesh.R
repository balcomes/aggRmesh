
.aggrmesh <- function(object, method, n, output, ...){
  
  if(length(object) < 2){
    stop("Need to submit 2 or more queries.")
  }
  
  OUTPUT <- c("default",
    "Gene.Identifier",
    "Gene.Symbol",
    "Gene.Description",
    "Gene.Taxonomy.Identifier",
    "MeSH.Descriptor.Name",
    "MeSH.Descriptor.Identifier",
    "MeSH.Qualifier.Name",
    "Fover",
    "ChiSquare",
    "FisherExact.text",
    "Compound.CompoundID",
    "Compound.Name",
    "Q-Value")
  ocheck <- pmatch(output, OUTPUT)
  if (is.na(ocheck)){
    stop("Invalid ouput!")
  }
  if ( ocheck == -1){ 
    stop("Ambiguous ouput!")
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
                       if(output == "default"){
                         x = metab2mesh(x)[,"MeSH.Descriptor.Name"]
                       }
                       else{
                         x = metab2mesh(x)[,output]
                       }
                     })
  }

  if(method=="gene2mesh"){
    message(paste("\nUsing gene2mesh.\n"))
    result <- sapply(object,
                     function(x){
                       if(output == "default"){
                         x = gene2mesh(x)[,"MeSH.Descriptor.Name"]
                       }
                       else{
                         x = gene2mesh(x)[,output]
                       }
                     })
  }
  if(method=="mesh2metab"){
    message(paste("\nUsing mesh2metab.\n"))
    result <- sapply(object,
                     function(x){
                       if(output == "default"){
                         x = mesh2metab(x)[,"Compound.Name"]
                       }
                       else{
                         x = mesh2metab(x)[,output]
                       }
                     })
  }
  
  if(method=="mesh2gene"){
    message(paste("\nUsing mesh2gene.\n"))
    result <- sapply(object,
                     function(x){
                       if(output == "default"){
                         x = mesh2gene(x)[,"Gene.Identifier"]
                       }
                       else{
                         x = mesh2gene(x)[,output]
                       }
                     })
  }
  
  result <- result[!sapply(result, is.null)]
  result <- lapply((result),function(x){x[!duplicated(x)]})
  
  if(length(result)<2){
    stop("Not enough valid resultsets for RankAggreg to work with.")
  }
  
  n.obs <- sapply(result, length)
  seq.max <- seq_len(max(n.obs))
  mat <- t(sapply(result, "[", i = seq.max))
  mat[is.na(mat)] <- rep(runif(length(mat[is.na(mat)])))

  ra <- RankAggreg(mat,n)
  ra <- ra$top.list
  ra <- ra[ra>1]
  if(length(ra)<n){
    message("Had to return less than n terms due to short resultset(s).")
  }
  ra <- ra[!duplicated(ra)]
  return(ra)
}

################################################################################

setGeneric("aggrmesh", function(object,
                                method="metab2mesh",
                                n=10,
                                output="default", ...)
  standardGeneric("aggrmesh")
)

setMethod("aggrmesh", 
          signature(object = c("ANY"),
                    method = c("ANY"),
                    n = c("ANY"),
                    output = c("ANY")),
          function(object, method, n, output, ...){
            .aggrmesh(object=object, method=method, n=n, output=output, ...)
          })