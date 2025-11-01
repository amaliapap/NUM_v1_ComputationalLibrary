function Bmeso_intTop170=calcMesoCopepods(sim)

r = calcRadius(sim.p);

field = squeeze(sum(sim.B(:,:,:,1:3,r>1000),5));

dz = sim.dznom(1:3);
Bmeso_intTop170 =double(squeeze( sum(field.*reshape(dz ,1,1,1,numel(dz)),4) / 1000)); % g/m2
