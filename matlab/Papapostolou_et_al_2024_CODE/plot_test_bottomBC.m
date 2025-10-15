pp = setupNUMmodel;
pp = parametersWatercolumn(pp);

pp.tEnd = 10*365;

BCvalues = logspace(1,3,5);

for i = 1:length(BCvalues)
    p = pp;
    p.BCvalue(1) = BCvalues(i);
    sim = simulateWatercolumn(p, 60, -40);

    N = sim.N;
    N(N<=0) = 1e-20;

    %contourf(sim.t, sim.z, N', linspace(0,200,10))
    %colorbar

    sim = calcFunctions(sim);
    NPP(i,:) = sim.ProdNet;
    B(i,:) = sim.Bplankton;
end
%%
% Plot the results for NPP and Bplankton
fig=figure();
height=10;  
width=9;

set(fig,'Renderer','Painters','Units','centimeters',...
'Position',[0 0 width height],...
'PaperPositionMode','auto','Name','Convergence');


subplot(2,1,1);
semilogx(BCvalues, mean(NPP'), '-o','LineWidth',2);
ylabel('Mean NPP (mg_C/m^2/day)');
set(gca,'XTickLabel','')

subplot(2,1,2);
semilogx(BCvalues, mean(B'), '-o','LineWidth',2);
xlabel('N value at bottom boundary');
ylabel('Plankton Biomass (mg_C/m^2)');

