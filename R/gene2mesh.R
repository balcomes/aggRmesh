.gene2mesh <- function(object, type, ...){
  
  #http://gene2mesh.ncibi.org/fetch?geneid=1436
  #http://gene2mesh.ncibi.org/fetch?genesymbol=csf1r
  #http://gene2mesh.ncibi.org/fetch?genesymbol=csf1r&taxid=9606
  #http://gene2mesh.ncibi.org/fetch?mesh=diabetes
  #http://gene2mesh.ncibi.org/fetch?mesh=diabetes&taxid=9606
  
  TYPE <- c("geneid", "genesymbol", "taxid")
  check <- pmatch(type, TYPE)
  if (is.na(check)){
    stop("Invalid ID!")
  }
  if ( check == -1){ 
    stop("Ambiguous ID!")
  }
  
  base <- "http://gene2mesh.ncibi.org/fetch?"
  #type <- "geneid"
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
  e <- e$Gene2MeSH$Response$ResultSet
  coln <- c("Gene.Identifier",
            "Gene.Symbol",
            "Gene.Description",
            "Gene.Taxonomy.Identifier",
            "MeSH.Descriptor.Name",
            "MeSH.Descriptor.Identifier",
            "MeSH.Qualifier.Name",
            "Fover",
            "ChiSquare",
            "FisherExact.text")
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

setGeneric("gene2mesh", function(object, type = "geneid", ...)
  standardGeneric("gene2mesh")
)

setMethod("gene2mesh", 
          signature(object = c("ANY"),
                    type = c("ANY")),
          function(object, ...){
            .gene2mesh(object=object, type=type, ...)
          })