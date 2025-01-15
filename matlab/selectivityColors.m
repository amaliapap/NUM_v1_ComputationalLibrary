%% B: Size spectrum - shaded area HTL selectivity

figure;
myFONT = 13;
set(gca,'fontsize', myFONT)
% myColor={[21, 16, 240]/256,[0, 163, 136]/256,[240, 154, 15]/256,[240, 154, 15]/256,...
    % [219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256,[219, 6, 6]/256,[116, 71, 145]/256};
%
myColor = {[0 0.4470 0.7410], [0.8500 0.3250 0.0980],...
    [0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560], [0.4660 0.6740 0.1880],...
    [0.3010 0.7450 0.9330],[0.3010 0.7450 0.9330],[0.3010 0.7450 0.9330]};
% mortHTL_new = [0.1];
% mAdults = logspace(log10(0.2), log10(1000), 5);
% from setupNUMmodel
% setHTL(0.005, 0.1 ,true, false); % "Quadratic" mortality; not declining
mortHTL_new=0.005;
mHTL_new=0.1;
mixing_new = 0.1;
% default:
for i = 1:length(mixing_new)
    % subplot(2,1,i)
    % p = setupNUMmodel(bParallel=true);
    p = parametersChemostat(p);
    p.tEnd = 365*10;
    % p.d = mixing_new;
    % boolQua = false;
    % boolDec = false;
    % setHTL(mortHTL_new(i), mHTL_new, boolQua, boolDec);
    % setHTL(0.005, 0.1 ,true, false); % "Quadratic" mortality; not declining
    simC = simulateChemostat(p,100);
    p = simC.p;
    sLegend = {};
    ixTime = length(simC.t); % Defaults to last time step
    for iGroup = 1:p.nGroups
        ix = p.ixStart(iGroup):p.ixEnd(iGroup);
        m = p.m(ix);
        Delta = p.mUpper(ix)./p.mLower(ix);
        ixB = ix-p.idxB+1;

        %
        % Plot background to show oscillations over the last half of the simulation:
        %

        ixAve = find( simC.t > simC.t(end)/2 );
        if (length(simC.t) >1)
            Blower = min( simC.B(ixAve,ixB) )./ log(Delta);
            Bupper = max( simC.B(ixAve,ixB) )./ log(Delta);
            % patch([m, m(end:-1:1)], [Blower, Bupper(end:-1:1)] , ...
            % p.colGroup{iGroup},...
            % 'edgecolor','none', 'facealpha',0.15);
        end
        set(gca,'xscale','log','yscale','log')
        hold on
    end

%
% Community spectrum:
%
[mc, Bc] = calcCommunitySpectrum(simC.B, simC);
legendentries(1) = loglog(mc, Bc, 'linewidth', 4.5,'color',[0.7, 0.7, 0.7]);
sLegend{1} = 'Community spectrum';

%
% Group spectra:
%
ixAve = find( simC.t > simC.t(end)/2 );
yyaxis left
for iGroup = 1:p.nGroups
ix = p.ixStart(iGroup):p.ixEnd(iGroup);
m = p.m(ix);
Delta = p.mUpper(ix)./p.mLower(ix);
ixB = ix-p.idxB+1;

%
% Plot the spectrum:
%
simC.B(simC.B<=0) = 1e-100; % avoid negative values
legendentries(iGroup+1) = ...
loglog(m, exp( mean( log(simC.B(ixAve, ixB)./log(Delta)),1)), '-','linewidth',2,...
'color',myColor{iGroup});
% loglog(m, exp( mean( log(simC.B(ixAve, ixB)./log(Delta)),1)), 'linewidth',1.5,...
% 'color',p.colGroup{iGroup});
% loglog(m, simC.B(ixTime, ixB)./log(Delta), ':','linewidth',1,...
% 'color',p.colGroup{iGroup})
sLegend{iGroup+1} = p.nameGroup{iGroup};
end
ylim([.1,50])
xlim(calcXlim(simC.p))
hold off
xlabel('Mass ({\mu}gC)', 'Fontsize', myFONT)
ylabel('Sheldon biomass ({\mu}gC/L)', 'Fontsize', myFONT)
yyaxis right

syms x

XX = logspace(log10(3.16230000000000e-09), log10(max(simC.p.m)), 1000);
fdec = (1 ./ (1+ (x./ mHTL_new).^(-2))) * (x./ mHTL_new).^(-0.25);
fdec_res = double(subs(fdec, x, XX));

% semilogx(XX, fdec_res, '--k', 'LineWidth', 1)
legendentries(8) = area(XX,fdec_res,'EdgeColor', 'none', 'FaceColor', [0.6392 0 0], ...
'ShowBaseLine', 'off', 'FaceAlpha', 0.15);
ax = gca;
ax.YColor = 'k';
ylabel('HTL selectivity', 'Fontsize', myFONT)
xlim([XX(1), XX(end)])
ylim([0 1])
sLegend{end+1} = 'HTL selectivity';
legend(legendentries, sLegend, 'location','northeast','box','off', 'NumColumns', 7)
end