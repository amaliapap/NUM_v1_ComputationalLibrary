% Spectral slope
%chemostat
pfit=polyfit(simC.p.m(4:end),squeeze(simC.B(end,:)),1);
slope=pfit(:,1);% first column
Bmean=squeeze(mean(sim.B(:,:,:,1,:),1));
%%
pfitGlobal=cell(length(sim.x),length(sim.y));           
for i=1:length(sim.x)
    for j=1:length(sim.y)
        % pfitGlobal{i,j}=polyfit(sim.p.m(4:end),Bmean(i,j,:),1);
        allFit=polyfit(sim.p.m(4:end),Bmean(i,j,:),1);
        slopeGlobal(i,j)=allFit(:,1);
    end
end

% slopeGlobal=pfitGlobal(:,1);
