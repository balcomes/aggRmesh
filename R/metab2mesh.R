.metab2mesh <- function(object){
  #library(XML)
  #library(plyr)
  
  #http://metab2mesh.ncibi.org/fetch?compound=methylmalonic+acid
  #http://metab2mesh.ncibi.org/fetch?compound=methylmalonic+acid&publimit=100
  #http://metab2mesh.ncibi.org/fetch?mesh=diabetes+mellitus
  
  base <- "http://metab2mesh.ncibi.org/fetch?"
  type <- "compound"
  name <- sub(" ", "+", object)
  
  u <- paste(base,
             type,
             "=",
             name,
             #"&publimit=",
             #doclimit,
             sep="")
  
  e <- xmlParse(u)
  e <- xmlToList(e)
  e <- e$Metab2MeSH$Response$ResultSet
  e <- lapply(e,function(x){unlist(x)[c("Compound.CompoundID",
                                        "Compound.Name",
                                        "MeSH.Descriptor.Name",
                                        "MeSH.Descriptor.Identifier",
                                        "Fover",
                                        "ChiSquare",
                                        "FisherExact.text",
                                        "Q-Value")]})
  result <- ldply(e[-length(e)])[,-1]
  result <- result[!duplicated(result[,2:4]),]
  rownames(result) <- NULL
  return(result)
}

################################################################################

setGeneric("metab2mesh", function(object, ...)
  standardGeneric("metab2mesh")
)

setMethod("metab2mesh", 
          signature(object = c("ANY")),
          function(object, ...){
            .metab2mesh(object=object, ...)
          })
