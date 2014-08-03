aggRmesh
========

Tools for Accessing NCIBI Web Services in R: aggRmesh

To install, install the devtools package if necessary (install.packages("devtools")) and run:

devtools::install_github("aggRmesh", "balcomes")


Example usage:


GeneIDs 1234,1235,1236:

CCR5 chemokine (C-C motif) receptor 5 (gene/pseudogene) [ Homo sapiens (human) ]

CCR6 chemokine (C-C motif) receptor 6 [ Homo sapiens (human) ]

CCR7 chemokine (C-C motif) receptor 7 [ Homo sapiens (human) ]

Command:


metabs <- aggrmesh(aggrmesh(1234:1236,method="gene2mesh")$top.list,method="mesh2metab")$top.list

Results:


Interleukin-8

IL2         

10023667        

Prostglandin E2

CG 4305

Tgfbeta     

sphingosine

SPH

L-threo-Sphingosine

Calcium-47

