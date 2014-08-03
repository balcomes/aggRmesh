.mesh2metab <- function(object, ...){
  
  #http://metab2mesh.ncibi.org/fetch?compound=methylmalonic+acid
  #http://metab2mesh.ncibi.org/fetch?compound=methylmalonic+acid&publimit=100
  #http://metab2mesh.ncibi.org/fetch?mesh=diabetes+mellitus
  
  base <- "http://metab2mesh.ncibi.org/fetch?"
  type <- "mesh"
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
  coln <- c("Compound.CompoundID",
            "Compound.Name",
            "MeSH.Descriptor.Name",
            "MeSH.Descriptor.Identifier",
            "Fover",
            "ChiSquare",
            "FisherExact.text",
            "Q-Value")
  e <- lapply(e,function(x){unlist(x)[coln]})
  
  result <- do.call(rbind.data.frame, e)
  names(result) <- coln
  result <- result[-(dim(result)[1]),]
  result <- result[!duplicated(result[,2:7]),]
  rownames(result) <- NULL
  i <- sapply(result, is.factor)
  result[i] <- lapply(result[i], as.character)
  return(result)
}

################################################################################

setGeneric("mesh2metab", function(object, ...)
  standardGeneric("mesh2metab")
)

setMethod("mesh2metab", 
          signature(object = c("ANY")),
          function(object, ...){
            .mesh2metab(object=object, ...)
          })
