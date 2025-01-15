# NUMmodel
Implementation used for "Computational library for the Nutrient-Unicellular-Multicellular
plankton modeling framework".

The core library is written in Fortran2008 and is interfaced from matlab.

## Requirements
The library requires a recent version of matlab (2021 or later). On windows it requires the Matlab MEX module to be installed (Home -> Add-ons -> Get Add-ons -> MATLAB Support for MinGW-w64 C/C++ Compiler); on mac it requires Xcode to be installed. To run global simulation it further requires that the mapping toolbox is installed. Compiled versions of the library is available for windows (64 bit), linux and osx. Compiling the library requires a Fortran compiler, e.g., gfortran. Use the makefile in the Fortran directory. Edit the compiler and flags in the makefile to suit your operating system and compile by writing: make.

The global and water column setups used for the article require the use of transport matrices which must be downloaded from http://kelvin.earth.ox.ac.uk/spk/Research/TMM/TransportMatrixConfigs (choose MITgcm_2.8deg for the global setup and MITgcm_ECCO for the water-column), and then placed in the directory TMs.

More general info on the NUM model can be found in the README file at the original NUMmodel github: https://github.com/Kenhasteandersen/NUMmodel

## Files
The folder includes the core library, and the original matlab and R scripts for simulations. It also includes the files used for this publications.
The simulations generated in this study are not included here, but they can be reproduced running the scripts described below.

- `matlab/runGlobalSimulation.m`. The script used to run a global simulation `simNUMmodel.mat`.

### Figures
All figures created for this article can be plotted by running the script `matlab\Papapostolou_et_al_2024_CODE\Paper_1_Figures`
The obseravtional data compared to the model are downloaded from:
- Net primary production from http://orca.science.oregonstate.edu/npp_products.php
- Particulate Organic Carbon (POC) from Tanioka et al., 2022 https://doi.org/10.5281/zenodo.6967484 `GOPOPCORNfigures.m`
- Picophytoplankton biomass from Martínez-Vicente et al., 2017 https://doi.org/10.5281/zenodo.1067229 `PicophytoFiguresAtlantic.m`
- Nano- and micro-plankton biomass from Rodríguez-Ramos et al., 2015 `AMTnanomicroFigures.m`
- Copepod biomass from Moriarty et al., 2013 https://doi.pangaea.de/10.1594/PANGAEA.785501 `plotMesoZP_NUMxMoriarty_top150int.m`
- Nutrient concentrations from https://www.ncei.noaa.gov/access/world-ocean-atlas-2023/ `plotGlobalNutrients_3D_woa_x_NUM.m`

Further information on the data processing can be found in the respective highlighted scripts. You can contact to me if you need the processed datasets.
