aggRmesh
========

Tools for Accessing NCIBI Web Services in R: aggRmesh

To install, install the devtools package if necessary (install.packages("devtools")) and run:

devtools::install_github("aggRmesh", "balcomes")


Example Usage
========

library(aggRmesh)

library(dplyr)

mimi(1234)

View(gene2mesh(1234))

View(metab2mesh("phenol"))

View(mesh2gene("Photochemical Processes"))

View(mesh2metab("Photochemical Processes"))

3452:3456 %.% aggrmesh("gene2mesh") %.% aggrmesh("mesh2metab")

gene2mesh(12)$MeSH.Descriptor.Name[1:5] %.% aggrmesh("mesh2metab")

mimi(3558)$InteractingGeneIDs %.% aggrmesh(method="gene2mesh") %.% aggrmesh(method="mesh2metab")

or

library(knitr)

report('gene2mesh(12)$MeSH.Descriptor.Name[1:5] %.% aggrmesh("mesh2metab")')

(Wrap command in single quotes!)
