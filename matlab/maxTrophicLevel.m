% Algorithm that interpolates trophic level (lambda) values
% and finds the max trophic level at each size range of the spectrum
% lambda: trophic-level vector of all groups 
function [mass_range, max_linterp,lhtl,lamAC]=maxTrophicLevel(sim,rates,Biom,lat,lon)
% B=sim.B(end,:);
arguments
    sim struct;
    rates struct;
    Biom double;
    lat double = [];
    lon double = [];
end
p=sim.p;
cd('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab')
nGroups = p.nGroups-1;                           % plankton groups without POM
lambdaG = calcTrophicLevelamp(sim,rates,Biom);   % calculate trophic levels
cd('C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\matlab\Trophic Efficiency');

% generalists
[~, idxG ]=find(sim.p.typeGroups==5);    % index of generalists
ixG  = (sim.p.ixStart( idxG (1)):sim.p.ixEnd( idxG (end)));
mG=p.m(ixG);                             % mass of generalists
lamG=lambdaG(ixG-sim.p.idxB+1);          % trophic level

% diatoms
[~, idxD ]=find(sim.p.typeGroups==3); 
ixD  = (sim.p.ixStart( idxD (1)):sim.p.ixEnd( idxD (end)));% index of diatoms
mD=p.m(ixD);                                               % mass of diatoms
lamD=lambdaG(ixD-sim.p.idxB+1);

% Copepods
[~, idxC ]=find(sim.p.typeGroups==10|sim.p.typeGroups==11); 
ixC  = (sim.p.ixStart( idxC (1)):sim.p.ixEnd( idxC (end)));% index of Copepods
mC=p.m(ixC);                                               % mass of copepods
lamC=lambdaG(ixC-sim.p.idxB+1);

% Active Copepods
[~, idxAC ]=find(sim.p.typeGroups==11); 
ixAC  = (sim.p.ixStart( idxAC (1)):sim.p.ixEnd( idxAC (end)));% index of Active Copepods
mAC=p.m(ixAC);                                               % mass of active copepods
lamAC=lambdaG(ixAC-sim.p.idxB+1);
% lamAC_avg=mean(lamAC);
%% Step1: Interpolation 
% Augment mass and interpolate the corresponding trophic level (lambda)
%
nPoints=nGroups*25;                  % # points for the interpolation. 25 is an arbitrary number
m_nPoints=zeros(nGroups,nPoints);    % initialize mass for these points/rows<-groups
lambdaGroup=m_nPoints;               % initialize lambda's for the interrpolation
for iGroup = 1:nGroups          
    ix = p.ixStart(iGroup):p.ixEnd(iGroup);
    m = p.m(ix);                     % group mass
    ixB = ix-p.idxB+1;               % index of group's trophic level
    %  augmented mass-array for the different groups, discretized in nPoints
    m_nPoints(iGroup,:) = logspace(log10(min(m)), log10(max(m)), nPoints);                                                               
    val_to_interp = lambdaG(ixB) ;
    % Interpolation
    val_interp = (interp1(log(m), val_to_interp, log(m_nPoints(iGroup,:)), 'linear'));
    lambdaGroup(iGroup,:)=val_interp;
end

B = reshape(m_nPoints',[],1);   % reshape augmented mass-array to a vector
C = reshape(lambdaGroup',[],1); % reshape interpolated lambda's to a vector
    
%%
% Step2: Find max trophic level with the interpolated values
%
rangePoints=nGroups*25; % rangePoints 
% Augmented mass range
mass_range_aug = logspace(log10(min(min(m_nPoints))),log10(max(max(m_nPoints))), rangePoints);
max_linterp=ones(1,rangePoints-1);

for ix =1:numel(m_nPoints)                 % iterate through all size classes for all augmented size-classes
    % B(ix): mass of each size from the augmented mass-array
    for iRange=1:length(mass_range_aug)-1  % iterate through all mass-ranges
        if B(ix)>=mass_range_aug(iRange) && B(ix)<=mass_range_aug(iRange+1)
            if C(ix)>max_linterp(iRange)
                max_linterp(iRange)=C(ix); 
            end
        end
    end
end
mass_range = mass_range_aug(1:end-1);
%%  New lambda_htl
    lhtl=sum(rates.mortHTL.*Biom.*lambdaG)/sum(rates.mortHTL.*Biom); %size-wise

%% Diagnostic Figure
% figure(1)
% clf
% set(gcf,'color','w');
%     plot(mass_range,max_linterp,'g:','LineWidth',2)
%     plot(mass_range,max_linterp,'gs')
% xlabel('Mass (\mugC)')
% ylabel('Trophic level')
% legend('\lambda_{max}')
% set(gca,'XScale','log')
% axis tight

%% More detailed diagnostics
% figure(2)
% clf
% set(gcf,'color','w');
%     plot(mG,lamG,'r*')
% hold on
%     plot(B(1:length(m_nPoints)),C(1:length(m_nPoints)),'ro')
%     plot(mD,lamD,'b*')
%     plot(B(length(m_nPoints)+1:2*length(m_nPoints)),C(length(m_nPoints)+1:2*length(m_nPoints)),'bs')
%     plot(mC,lamC,'m*')
%     plot(B(2*length(m_nPoints)+1:nGroups*length(m_nPoints)),C(2*length(m_nPoints)+1:nGroups*length(m_nPoints)),'md')
%     plot(mass_range,max_linterp,'g:','LineWidth',2)
%     plot(mass_range,max_linterp,'gs')
% xlabel('Mass (\mugC)')
% ylabel('Trophic level')
% legend('\lambda_G','\lambda_{Ginterp}','\lambda_D','\lambda_{Dinterp}',...
%         '\lambda_C','\lambda_{Cinterp}','\lambda_{max.interp}')
% set(gca,'XScale','log')
% axis tight