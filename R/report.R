.report <- function(x){
  tempf <- tempfile("stitch", fileext = c(".Rnw"))
  write(x,file=tempf,append=TRUE)
  loc <- stitch(tempf,
                system.file("misc", "knitr-template.Rnw", package = "knitr"))
  goo <- substr(strsplit(tempf,"stitch")[[1]][2],0,12)
  message(paste0(getwd(),"/stitch",goo,".pdf"))
  if(Sys.info()['sysname']=="Windows"){
    system(paste0("cmd /c start ",getwd(),"/stitch",goo,".pdf"))
  }
  if(Sys.info()['sysname']=="Darwin"){
    system(paste0("open ",getwd(),"/stitch",goo,"pdf"))
  }
}

################################################################################

setGeneric("report", function(x)
  standardGeneric("report")
)

setMethod("report", 
          signature(x = c("character")),
          function(x){
            .report(x)
          })
