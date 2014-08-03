
.aggrmesh <- function(object, method, n, ...){
  
  METHODS <- c("metab","gene")
  mcheck <- pmatch(method, METHODS)
  if (is.na(mcheck)){
    stop("Invalid method!")
  }
  if ( mcheck == -1){ 
    stop("Ambiguous method!")
  }
  
  if(method=="metab"){
    cat(paste("\nUsing metab2mesh.\n"))
  }
  if(method=="gene"){
    cat(paste("\nUsing gene2mesh.\n"))
  }
  cat(paste("Top",n,"terms.\n"))
  
  if(method=="metab"){
    result <- sapply(object,function(x){metab2mesh(x)$MeSH.Descriptor.Name})
  }

  if(method=="gene"){
    result <- sapply(object,function(x){x = gene2mesh(x)$MeSH.Descriptor.Name})
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

setGeneric("aggrmesh", function(object, method = "metab", n = 10, ...)
  standardGeneric("aggrmesh")
)

setMethod("aggrmesh", 
          signature(object = c("ANY"),
                    method = c("ANY"),
                    n = c("ANY")),
          function(object, method, n, ...){
            .aggrmesh(object=object, method=method, n=n, ...)
          })