%
% Plots all figures in the manuscript and the appendix
%
% Before running:
%  1) Download NUMmodel v1 from the NUMmodel github site: https://github.com/Kenhasteandersen/NUMmodel.git
%  2) Make sure that you have the right support installed (see
%     https://github.com/Kenhasteandersen/NUMmodel/wiki/Installation)
%  3) Add the matlab directory in the downloaded NUMmodel to the path:
%      addpath [path to NUMmodel/matlab]
%

%%
% Setup:
%
close all

%show_data = true;  % If data are available
bRunInitialization = false; % Whether to make (long) initialization run
bRunmodel = false;  % whether to run the model or used saved run
if ~exist('NUMmodel.mat')
    bRunmodel=true;
end

% Coordinates for seasonal water column:
lat = 60;
lon = -40;

%%
% Initialization run:
%
if bRunInitialization | ~exist('NUMinit.mat')
    p = setupNUMmodel(bParallel=true); % Setup the standard NUM model. The
    % parallel option is optional, but it greatly speeds up the calculation
    p = parametersGlobal(p);           % Setup a global simulation
    p.tEnd = 10*365;                   % Run for 10 years
    sim = simulateGlobal(p);
    saveGlobal(sim,'NUMinit');     % Saves a truncated simulated to be
    % used as initial conditions
end

%%
% load the global simulation and run one year with fine time resolution:
%
if bRunmodel | ~exist('NUMmodel.mat')
    load('NUMinit.mat');
    sim = siminit;
    p = setupNUMmodel(bParallel=true);
    p = parametersGlobal(p);
    p.tEnd = 365;
    %p.tSave = 5;
    sim.p = p;  % Replace the parameters to fix the path for the TMs
    sim = simulateGlobal(p,sim,bCalcAnnualAverages=true);
    save('NUMmodel.mat','sim','-v7.3');
else
    load('NUMmodel.mat')
    p = setupNUMmodel(bParallel=true);
    p = parametersGlobal(p);
    sim.p = p;  % Replace the parameters to fix the path for the TMs

end

%%
% Figure 5
plotSensitivityStagesGroups % Figure 5
exportgraphics(gcf,'sensitivityGroups.pdf')

%%
% Figure 6
ModelVsData(sim)
exportgraphics(gcf,'ModelVsData.pdf')

%%
% Figure 7:
plotGlobalMaps(sim,lat,lon);
exportgraphics(gcf,'GlobalBiomass_maps.pdf')

%%
% Figure 8:
figure(8)
nppComparison(sim)
exportgraphics(gcf,'nppComparison.pdf')

%%
% Figure 9
AMTnanomicroFigures(sim)
exportgraphics(gcf,'AMTnanomicro.pdf')

%%
% Figure 10
plotMesoZP_NUMxMoriarty_top150int(sim)
exportgraphics(gcf,'MesoZP_NUMxMoriarty_top150integr_maps.pdf')

%%
plotGlobalNutrients_3D_woa_x_NUM(sim) % Figure 11 & E1 (Appendix)
figure(11)
exportgraphics(gcf,'NutrientsNUMxWOAsurf_annual.pdf')
figure(51)
exportgraphics(gcf,[append('NutrientsNUMxWOA','_MAPS.pdf')])


%%
% Figure 12 + 13
plotGlobalPhyto(sim);      % Figure 11, 12
figure(12)
exportgraphics(gcf,'FunctionalGroups_row.pdf')
figure(13)
exportgraphics(gcf,'GroupRatios.pdf')

%%
% Figure 14:
figure(14)
[simWC,simC] = MyNewPLot_update(sim,lat,lon);
exportgraphics(gcf,'comparison.pdf')

%%
% Figure 15, 16
plotSpectrumAllRatesUpdate(simC)  % Figures 15,16: Spectra in Spring Summer and Unicellular respiration
figure(15)
exportgraphics(gcf,'spectrumRates_SpringSummer.pdf')
figure(16)
exportgraphics(gcf,'Respiration_simC_noLabels.pdf')


%% Appendix figures
sensitivityCalibrationParams(sim, true) % sensitivity plots for the 3 calibrated params
exportgraphics(gcf,'sensitivityCalibrationParams.pdf')

%%
plotDiatoms
exportgraphics(gcf,'diatoms.pdf')

%%
p = setupNUMmodel(bParallel=true); 
plot_diatoms_vs_data(sim)
exportgraphics(gcf,'diatoms_vs_data.pdf')


%%
MyNewPLot_update(sim,-5,5)  % Upwelling water-column
exportgraphics(gcf,'WC_upwelling.pdf')

%%
MyNewPLot_update(sim,24,-158)  % Oligotrophic water-column
exportgraphics(gcf,'WC_oligotrophic.pdf')

%%
PlotMicroMesoCopepods(sim)
exportgraphics(gcf,'MicroMeso_copepods_vCont20_maps.pdf')

%%
r = calcRadiusGroups(sim.p);
GOPOPCORNfigures(sim,r) % transect map

%%
PicophytoFiguresAtlantic(sim,r) % shows only data transects in the Atlantic
figure(7)
exportgraphics(gcf,'picoPhytoplankton_transects.pdf')

%%
plotWatercolumnTime(sim, lat, lon, depthMax=200) % or simWC
annotation('textbox', [0.1, 0.5, 0.5, 0.04], 'String', 'Depth (m)', 'FontSize', 12,'rotation',90,...
    'edgecolor','none');
exportgraphics(gcf,'watercolumn.pdf')

%%
plotDiatom_vulnerability(sim)
exportgraphics(gcf,'diatom_vulnerability.pdf')

%%
figure_convergence
exportgraphics(gcf,'convergence.pdf')

%%
plot_test_bottomBC
exportgraphics(gcf,'test_bottom_BC.pdf')