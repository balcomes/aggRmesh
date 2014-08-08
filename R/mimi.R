.mimi <- function(object, id, type, ...){
  
  #http://mimi.ncibi.org/MimiWeb/fetch.jsp?search=pwp1
  #http://mimi.ncibi.org/MimiWeb/fetch.jsp?geneid=1436
  #http://mimi.ncibi.org/MimiWeb/fetch.jsp?geneid=1436&type=interactions 
  #http://mimi.ncibi.org/MimiWeb/fetch.jsp?geneid=1436&type=reactions 
  #http://mimi.ncibi.org/MimiWeb/fetch.jsp?geneid=7389&type=compounds
  #http://mimi.ncibi.org/MimiWeb/fetch.jsp?geneid=4005&type=nlp
  #http://mimi.ncibi.org/MimiWeb/fetch.jsp?cid=C00061
  #http://mimi.ncibi.org/MimiWeb/fetch.jsp?rid=R00548
  
  ID <- c("default", "search","geneid","cid","rid")
  icheck <- pmatch(id, ID)
  if (is.na(icheck)){
    stop("Invalid ID!")
  }
  if ( icheck == -1){ 
    stop("Ambiguous ID!")
  }
  
  TYPE <- c("default","interactions", "reactions", "compounds", "nlp")
  tcheck <- pmatch(type, TYPE)
  if (is.na(tcheck)){
    stop("Invalid type!")
  }
  if ( tcheck == -1){ 
    stop("Ambiguous type!")
  }
  
  base <- "http://mimi.ncibi.org/MimiWeb/fetch.jsp?"
  name <- sub(" ", "+", object)
  
  if(id=="default"){
    id <- "search"
  }
  if(type=="default"){
    type <- ""
  }
  if(type!="default"){
    insert <- "&type="
  }
  else{
    insert <- ""
    type <- ""
  }
  
  insert <- "&type="
  
  u <- paste(base,
             id,
             "=",
             name,
             insert,
             type,
             sep="")
  
  e <- xmlParse(u)
  e <- xmlToList(e)
  e <- e$MiMI$Response$Result
  result <- lapply(e,function(x){unlist(x)})

  return(result)
}

################################################################################

setGeneric("mimi", function(object,
                            id="default",
                            type="default", ...)
  standardGeneric("mimi")
)

setMethod("mimi", 
          signature(object = c("ANY"),
                    id = c("ANY"),
                    type = c("ANY")),
          function(object, id, type, ...){
            .mimi(object=object, id=id, type=type, ...)
          })
