%
% Calculate the community trophic levels from all groups using interplotation.
%
% In:
%  lambda - vector of trophic level of each group
%  sim - simulation structure
%  iTime - (optional) time index to plot (if not set an average is used)
%
% Out:
%  mc - central masses of bins
%  BSheldon - Sheldon size spectrum as defined in Andersen and Visser (2023), Box V.
%  lambdaspectrum - Normalized biomass spectrum
%
% function [mc, lambdaspectrum] = calcCommunityTrophicLevel(lambda, sim)
% 
% arguments
%     lambda;
%     sim struct;
% end


p = sim.p;

nPoints = 100;
mc = logspace(log10(min(sim.p.m(p.idxB:end))), log10(max(sim.p.m)), nPoints);
lambdaSheldon = zeros(1, nPoints);

for iGroup = 1:p.nGroups-1
    % m(iGroup,:)=p.m(ix);
    ix = p.ixStart(iGroup):p.ixEnd(iGroup);
    m = p.m(ix);
    % ixB = ix-p.idxB+1;
    m_nPoints(iGroup,:) = logspace(log10(min(m)), log10(max(m)), nPoints);

    % Interpolation
    log_k1 = lambda(ixB) ;
    
        vq1 = (interp1(log(m), log_k1, log(m_nPoints(iGroup,:)), 'linear'));
       lambdaGroup(iGroup,:)=vq1;
    % vq1(isnan(vq1)) = 0; % get rid of the NAs]
    % lambdaSheldon = max(lambdaSheldon,vq1);
 end
%%
% Community spectrum:
%
t2=nexttile(2);
clf
 set(gca, 'XScale', 'log')
% [mc, Bc] = calcCommunityTrophicLevel(lambda, sim);
for iGroup=1:2%p.nGroups-1
    hold on
    loglog(m_nPoints(iGroup,:),lambdaGroup(iGroup,:));
end
sLegend{1} = 'Community Trophic Level';

% ylim([0.9 max(lambda)+0.3])
xlim(calcXlim(sim.p))
hold off
xticks=[10^-8 10^-7 10^-6 10^-5 10^-4 10^-3 10^-2 10^-1 1 10];

xlabel('Mass ({\mu}gC)')



% end
% Check interpolation (SOS! Only with marker!!!)
% figure
% 
% loglog(m, exp(log_k), '*')
% hold on 
% 
% loglog(mc, vq1)
% xlim([0, max(m)])