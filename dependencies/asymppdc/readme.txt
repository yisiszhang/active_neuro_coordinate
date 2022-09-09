PDC Asymptotic Package - AsympPDC

Sao Paulo - March 10, 2011.

This is the first public release of AsympPDC package. It deals with the asymptotic statistics for PDC, gPDC and iPDC. 
AsympPDC runs under Matlab and is a practically self-contained except for requires routines from three Matlab toolboxes: Control System, Signal Processing, and Statistical. 
It is not extensively tested yet. It was partially tested under Windows, Macintosh and Linux environments with Matlab version 7.0 and higher.

Please report any incompatibility to ksameshi[at]usp.br or baccala[at]lcs.poli.usp.br.


Additionally for cosmetic purposes, the pdc_xplot routine uses several Matlab users contributed codes: subplot2.m (modified old version of supbplot to control spacing between subplots), shadedplot.m (developed by Dave Van Tol), suplabel.m (for label and title plotting in subplot figures, by Ben Barrowes), suptitle.m (contributed by Drea Thomas, for adding title above all subplots), and tilefigs.m (for tiling figures for simultaneous visualization, by Charles Plum).

Contents of the package:

a) Folder "routines" contains all Matlab code for VAR estimation, PDC and asymptotic statistics calculation, Granger causality testing, and PDC cross-plotting routines used throughout the examples.

b) Folder "Examples" contains 12 examples from  8 articles and one book. We believe these examples together with "pdc_analysis_template.m" would be instructive enough to anyone with some knowledge of Matlab and the Connectivity Analysis literature will be able to start analyzing their own data, and create batch processing code for real world data analysis.
b1) The subfolder "extras" contains data m-files for three of the examples used by pdc_analysis_template.m.

c) Folder "supporting" contains five m-files for "cosmetic" plotting purposes.

Enjoy.