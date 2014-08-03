aggRmesh
========

Tools for Accessing NCIBI Web Services in R: aggRmesh

To install, install the devtools package if necessary (install.packages("devtools")) and run:

devtools::install_github("aggRmesh", "balcomes")


Example Usage
========

library(aggRmesh)

library(dplyr)

3452:3456 %.% aggrmesh("gene2mesh") %.% aggrmesh("mesh2metab")
