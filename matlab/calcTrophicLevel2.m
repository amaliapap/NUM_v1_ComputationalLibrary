%
% Returns the trophic level of each cell groups in a vector lambda
%
% In:
%  p - a structure with parameters from a setup
%  rates - a structure with jDOC, jLreal and jF rates (from getRates)
%
% Out:
%  lambda - the trophic level vector of all size groups that are not
%          nutrients.
%  lambdaHTL - The trophic level of the HTL calculated as 1 plus the biomass
%           weighted mean of the HTL consumption.
%

function [lambda, pC] = calcTrophicLevel2(p,B,rates)

arguments
    p struct
    B
    rates struct
    %lat double = []; %only for global simulation
    %lon double = []; %only for global simulation
end

%Get the size preference matrix of all size groups that are not nutrients.
theta = getTheta(p);


%cell rates
jPP = rates.jDOC+rates.jLreal; % Uptake of Primary Production 
jF  = rates.jFreal; % Uptake of Food
pC  = zeros(length(theta)); % rel contribution of prey j to total carbon assimilation by group i - including photosynthesis
%
%Calculate the trophic level
%

%Sort the masses in ascending order
[~,mSorted]=sort(p.m(p.idxB:end));

lambda =1+ 0*B;
lambda_part=0*B;
lambda(mSorted(1))=1;
for i=2:length(mSorted)
    idx = mSorted(i);
    for j=1:i-1
        idy=mSorted(j);
        if sum(theta(idx,:))==0
            lambda_part(idy)=1; %for cells not eating
        else
            pC(idx,idy)=theta(idx,idy)*B(idy)/sum(theta(idx,:).*B)/(jPP(idx)+jF(idx));
            %trophic level
            lambda_part(idy)=lambda(idy)*pC(idx,idy);
        end
    end
    lambda(idx)=1+sum(lambda_part);
end 
%
% Calc the trophic level of HTL:
%
lambdaHTL = 1 + sum( rates.mortHTL'.*B.*lambda ) / sum( rates.mortHTL'.*B );
    