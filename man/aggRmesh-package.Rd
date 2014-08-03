\name{aggRmesh-package}
\alias{aggRmesh-package}
\alias{aggRmesh}
\docType{package}
\title{
Tools for Accessing NCIBI Web Services in R:
aggRmesh
}
\description{
Insert description in later...
}
\details{
\tabular{ll}{
Package: \tab aggRmesh\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2014-08-02\cr
License: \tab Artistic-2.0 | file LICENSE\cr
}
Insert overview and important functions later.
}
\author{
Shawn Balcome

Maintainer: Shawn Balcome <balc0022@umn.edu>

}
\references{
http://metab2mesh.ncibi.org/

http://gene2mesh.ncibi.org/
}

\keyword{ XML }
\keyword{ plyr }
\keyword{ RankAggreg }
\seealso{

\code{\link[XML:XML-package]{XML}}

\code{\link[plyr:plyr-package]{plyr}}

\code{\link[RankAggreg:RankAggreg-package]{RankAggreg}}

}
\examples{
library(aggRmesh)
library(dplyr)
View(gene2mesh(1234))
View(metab2mesh("phenol"))
View(mesh2gene("Photochemical Processes"))
View(mesh2metab("Photochemical Processes"))
3452:3456 \%.\% aggrmesh("gene2mesh") \%.\% aggrmesh("mesh2metab")
g12met <- gene2mesh(12)$MeSH.Descriptor.Name[1:5] \%.\% aggrmesh("mesh2metab")
g12mesh <- gene2mesh(12)
g12met \%in\% g12mesh$MeSH.Descriptor.Name

}
