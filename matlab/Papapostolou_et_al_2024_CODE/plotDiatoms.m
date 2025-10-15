%%
% Plot rhoC:Si ratio and vacuole fraction based upon Brezinski 1985 data
%
table = readtable('../../data/Brezinski1985_data.xlsx'); % Data from Brezinski 1985
mass = table.pmolC_cell*12e-6;

%%
figure
clf
tiledlayout(2,1,"TileSpacing",'tight')
%setFigWidth(8)
%setFigHeight(10)
rhoC = 0.4e-6;

nexttile
loglog(mass, 1./(table.molarSi_C*28/12),'ko')
ylabel('C:Si mass ratio')
hold on
p = polyfit(log(mass), log(table.molarSi_C*28/12), 1)
%plot(mass, exp(p(2))*mass.^p(1),'x')
plot([1e-6, 0.01],3.4*[1,1],'k--')
set(gca,'xticklabel','')

nexttile
nu_vac = 1 - table.pmolC_cell*12e-6./(table.Volume_mum_3_*rhoC);
semilogx(mass, nu_vac, 'ko')
%xlabel('Mass (mug C )')
ylabel('Vacuole frac. \nu_{vac}')
p = polyfit(log(mass), log(nu_vac),1)
hold on
%plot(mass, exp(p(2))*mass.^p(1),'x')
plot([1e-6, 0.01],0.8*[1,1],'k--')
xlabel('Cell mass ({\mu}g C)')

exportgraphics(gcf,'diatoms.pdf')
