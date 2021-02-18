# Bisector

Code for the paper [_A bisector line field approach to interpolation of orientation fields_](https://arxiv.org/abs/1907.11449) by Nicolas Boizot and Ludovic Sacchelli.

## How to reproduce the experiments of the paper

- The orientation field reconstruction can be achieved by running 
```
matlab OFreconstruction.m
```
Check the options at the top of the script to switch between the prepared target datasets (stored in GoodProcessed folder).

Interpolation results will be stored in the InterpFingPrints folder (with an attached time stamp).


- To obtain representation of the results in the specific format of the article, run
```
matlab GraphScript.m
```
Datasets correspond to fig. 1, 6 and 7, are presented in the script.
For representation of a different dataset, follow the pattern provided in the example to give the 	proper DataFileNAME.

- Scripts with the *SCARCE.m nomenclature have the same function as their counterparts, but correspond to the experiments in the scarce dataset situation (see sect. 5.1, and fig. 8).

- Results from table 1 regarding the RMSD distribution can be obtained with
```
matlab SCARCE_LOOP_RMSD_CALC.m
```