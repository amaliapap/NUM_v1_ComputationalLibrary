%
% Algorithm that interpolates carbon fixed by generalists and diatoms 
% and sums it at each size range of the spectrum

function [mass_range, CfixedU]=CfixedoTotal(sim,rates,lat,lon)

arguments
    sim struct;
    rates struct;
    lat double = [];
    lon double = [];
end
p=sim.p;


% generalists
[~, idxG ]=find(sim.p.typeGroups==5);   % index of generalists
ixG  = (sim.p.ixStart( idxG (1)):sim.p.ixEnd( idxG (end)));
mG=p.m(ixG);                            % mass of generalists
Cfixed_G(ixG-sim.p.idxB+1)=sim.rates.jLreal(ixG-sim.p.idxB+1).*sim.B(end,ixG-sim.p.idxB+1)';         % trophic level

% diatoms
[~, idxD ]=find(sim.p.typeGroups==3); 
ixD  = (sim.p.ixStart( idxD (1)):sim.p.ixEnd( idxD (end)));% index of diatoms
mD=p.m(ixD);   
Cfixed_G(ixD-sim.p.idxB+1)=sim.rates.jLreal(ixD-sim.p.idxB+1).*sim.B(end,ixD-sim.p.idxB+1)';         % trophic level

%% Step1: Interpolation 
% Interpolate mD,mG and their lambda's, then repeat step2

nGroups=2;
nPoints=nGroups*25; % # points for the interpolation
m_nPoints=zeros(nGroups,nPoints); % initialize mass for these points/rows<-groups
CfixedGroup=m_nPoints;      % initialize lambda's for the interrpolation
for iGroup = 1:2            % check for only 2 groups
    % m(iGroup,:)=p.m(ix);
    ix = p.ixStart(iGroup):p.ixEnd(iGroup);
    m = p.m(ix); % group mass
    ixB = ix-p.idxB+1;      % index of group's trophic level
    %  augmented mass-array for the different groups, discretized in nPoints
    m_nPoints(iGroup,:) = logspace(log10(min(m)), log10(max(m)), nPoints); %this may need to be cell-array 
                                                                           % when copepods are included
   
    val_to_interp = Cfixed_G(ixB) ;
    % Interpolation
    val_interp = (interp1(log(m), val_to_interp, log(m_nPoints(iGroup,:)), 'linear'));
    CfixedGroup(iGroup,:)=val_interp;
end

B = reshape(m_nPoints',[],1);   % reshape augmented mass-array to a vector
C = reshape(CfixedGroup',[],1); % reshape interpolated lambda's to a vector
%%  mass range
mass_rangeUni= logspace(log10(min(min(mUni))),log10(max(max(mUni))), nPoints);
CfixedU=zeros(1,length(mass_rangeUni)-1);

%C fixed for Unicellular plankton    
for ix =1:numel(m_nPoints)                 % iterate through all size classes for the 2 groups
    for iRange=1:length(mass_rangeUni)-1
        if B(ix)>=mass_rangeUni(iRange) && B(ix)<=mass_rangeUni(iRange+1)
            CfixedU(iRange)=CfixedU(iRange)+C(ix);
        end
    end
end
mass_range2=mass_range1(1:end-1);
mass_rangeU=mass_rangeUni(1:end-1);
%
figure
clf
% plot(mG,lamG,'rd')
hold on
% plot(mD,lamD,'b*')
plot(m_nPoints(1,:),CfixedGroup(1,:),'r+')
plot(m_nPoints(2,:),CfixedGroup(2,:),'b+')
plot(mass_rangeU,CfixedU,'go')
plot(mass_rangeU,CfixedU,'g')

% title('\lambda_{max} before interp')
set(gca,'XScale','log')
axis tight
legend('Cg','Cd','Ctot')