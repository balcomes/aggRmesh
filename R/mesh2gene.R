.mesh2gene <- function(object){
  
  #http://gene2mesh.ncibi.org/fetch?geneid=1436
  #http://gene2mesh.ncibi.org/fetch?genesymbol=csf1r
  #http://gene2mesh.ncibi.org/fetch?genesymbol=csf1r&taxid=9606
  #http://gene2mesh.ncibi.org/fetch?mesh=diabetes
  #http://gene2mesh.ncibi.org/fetch?mesh=diabetes&taxid=9606
  
  base <- "http://gene2mesh.ncibi.org/fetch?"
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
  e <- e$Gene2MeSH$Response$ResultSet
  e <- lapply(e,function(x){unlist(x)[c("Gene.Identifier",
                                        "Gene.Symbol",
                                        "Gene.Description",
                                        "Gene.Taxonomy.Identifier",
                                        "MeSH.Descriptor.Name",
                                        "MeSH.Descriptor.Identifier",
                                        "MeSH.Qualifier.Name",
                                        "Fover",
                                        "ChiSquare",
                                        "FisherExact.text")]})
  
  result <- ldply(e[-length(e)])[,-1]
  result <- result[!duplicated(result[,2:7]),]
  rownames(result) <- NULL
  return(result)
}

################################################################################

setGeneric("mesh2gene", function(object, ...)
  standardGeneric("mesh2gene")
)

setMethod("mesh2gene", 
          signature(object = c("ANY")),
          function(object, ...){
            .mesh2gene(object=object, ...)
          })