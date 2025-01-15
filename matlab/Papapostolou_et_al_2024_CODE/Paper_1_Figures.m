% Plots all figures in the manuscript and the appendix
% Paper 1 figures
current_path = 'C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\Papapostolou_et_al_2024_CODE';
cd(current_path)  % directory of the folder containing the plotting functions
% load matrix of the global simulationcd
load('simNUMmodel.mat')

% Change directory to '.../NUMmodel/matlab' to execute the code 
path_to_NUMmodel = 'C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab';
cd(path_to_NUMmodel)

p = setupNUMmodel(bParallel=true);
p = parametersGlobal(p);
sim=simF;
sim.p=p;
% Replace with the path of Transport Matrices (TMs) after downloading
% the library
sim.p.pathGrid="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\TMs\MITgcm_2.8deg\grid.mat";

%%
cd(current_path) % switch to the folder conatining the figure scripts
% plotSensitivityStagesGroups % Figure 5
[simWC,simC]=MyNewPLot_update(sim,1,true); % Figure 6, Figure 14
show_data=false;
nppComparison(sim,show_data)   % Figure 7
ModelVsData(sim)           % Figure 8
AMTnanomicroFigures(sim)   % Figure 9
plotMesoZP_NUMxMoriarty_top150int(sim,show_data) % Figure 10
plotSpectrumAllRatesUpdate(simC)  % Figures 15,16: Spectra in Spring Summer and Unicellular respiration
cd(current_path)
simPhyto=load("simPhyto.mat"); % load simulation matrix with phytoplankton biomass calculation
% if simPhyto is not calculated, use sim 
plotGlobalPhytoplankton(simPhyto.sim)      % Figure 11, 12 /runs calculation if there is no input
plotGlobalNutrients_3D_woa_x_NUM(sim,true) % Figure 13 & E1 (Appendix)

%% Appendix figures

sensitivityCalibrationParams(true) % sensitivity plots for the 3 calibrated params
MyNewPLot_update(sim,2,false)  % Upwelling water-column
MyNewPLot_update(sim,3,false)  % Oligotrophic water-column
PlotMicroMesoCopepods(sim) 
r = calcRadiusGroups(sim.p);
GOPOPCORNfigures(sim,r) % transect map
PicophytoFiguresAtlantic(sim,r) % shows only data transects in the Atlantic
cd(path_to_NUMmodel)
plotWatercolumnTime(sim, 60,-15) % or simWC