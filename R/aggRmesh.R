
.aggrmesh <- function(object, method = "metab", n = 10, ...){
  
  METHODS <- c("metab","gene")
  method <- pmatch(method, METHODS)
  if (is.na(method)){
    stop("Invalid method!")
  }
  if (method == -1){ 
    stop("Ambiguous method!")
  }
  
  if(method=="metab"){
    result <- sapply(object,function(x){metab2mesh(x)$MeSH.Descriptor.Name})
  }

  if(method=="gene"){
    result <- sapply(object,function(x){gene2mesh(x)$MeSH.Descriptor.Name})
  }
  
  m <- min(sapply(result,length))
  if(m<n){
    n <- m
    print("Short entry, using n = min instead")
  }
  
  return(RankAggreg(do.call(rbind,lapply(result,function(x){x[1:n]})),n))
}


################################################################################

setGeneric("aggrmesh", function(object, ...)
  standardGeneric("aggrmesh")
)

setMethod("aggrmesh", 
          signature(object = c("ANY")),
          function(object, ...){
            .aggrmesh(object=object, ...)
          })