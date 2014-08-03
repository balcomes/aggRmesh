aggRmesh
========

Tools for Accessing NCIBI Web Services in R: aggRmesh

To install, install the devtools package if necessary (install.packages("devtools")) and run:

devtools::install_github("aggRmesh", "balcomes")

Example usage:

GeneIDs 1234,1235,1236:

CCR5 chemokine (C-C motif) receptor 5 (gene/pseudogene) [ Homo sapiens (human) ]\n
CCR6 chemokine (C-C motif) receptor 6 [ Homo sapiens (human) ]\n
CCR7 chemokine (C-C motif) receptor 7 [ Homo sapiens (human) ]\n

Command:

metabs <- aggrmesh(aggrmesh(1234:1236,method="gene2mesh")$top.list,method="mesh2metab")$top.list


Resultz:
Interleukin-8\n       
IL2\n             
10023667\n        
Prostglandin E2\n
CG 4305\n
Tgfbeta\n          
sphingosine\n
SPH\n
L-threo-Sphingosine\n
Calcium-47\n 
