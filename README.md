# NUMmodel
Scripts to reproduce the figures in "Computational library for the Nutrient-Unicellular-Multicellular
plankton modeling framework".

## Requirements
Requires a working copy of the NUMmodel version 1.0: https://github.com/Kenhasteandersen/NUMmodel. Follow the installation instructions in the wiki page.

The global and water column setups used for the article require the use of transport matrices which must be downloaded from http://kelvin.earth.ox.ac.uk/spk/Research/TMM/TransportMatrixConfigs (choose MITgcm_2.8deg for the global setup and MITgcm_ECCO for the water-column), and then placed in the directory TMs.

More general info on the NUM model can be found in the README file at the original NUMmodel github: https://github.com/Kenhasteandersen/NUMmodel

### Figures
All figures created for this article can be plotted by running the script `matlab\Papapostolou_et_al_2024_CODE\Paper_1_Figures`. Running this script requires that the NUMmodel/matlab directory is available in the path.

The observational data compared to the model are downloaded from:
- Net primary production from http://orca.science.oregonstate.edu/npp_products.php
- Particulate Organic Carbon (POC) from Tanioka et al., 2022 https://doi.org/10.5281/zenodo.6967484 `GOPOPCORNfigures.m`
- Picophytoplankton biomass from Martínez-Vicente et al., 2017 https://doi.org/10.5281/zenodo.1067229 `PicophytoFiguresAtlantic.m`
- Nano- and micro-plankton biomass from Rodríguez-Ramos et al., 2015 `AMTnanomicroFigures.m`
- Copepod biomass from Moriarty et al., 2013 https://doi.pangaea.de/10.1594/PANGAEA.785501 `plotMesoZP_NUMxMoriarty_top150int.m`
- Nutrient concentrations from https://www.ncei.noaa.gov/access/world-ocean-atlas-2023/ `plotGlobalNutrients_3D_woa_x_NUM.m`

Further information on the data processing can be found in the respective highlighted scripts. You can contact to me if you need the processed datasets.
