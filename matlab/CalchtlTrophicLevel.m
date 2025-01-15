% Algorithm that interpolates trophic level (lambda) values
% and finds the max trophic level at each size range of the spectrum
% lambda: trophic-level vector of all groups 
function [lhtl]=CalchtlTrophicLevel(sim,rates,Biom)
% B=sim.B(end,:);
arguments
    sim struct;
    rates struct;
    Biom double;
end
cd('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab')
lambdaG = calcTrophicLevelamp(sim,rates,Biom);   % calculate trophic levels
cd('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\Trophic Efficiency');
    lhtl=sum(rates.mortHTL.*Biom.*lambdaG)/sum(rates.mortHTL.*Biom); %size-wise
