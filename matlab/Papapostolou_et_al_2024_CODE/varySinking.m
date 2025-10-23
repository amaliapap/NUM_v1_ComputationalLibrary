sinking = linspace(5,20,8);
parinit = [0.067635, 14.584566, 0.042676];
parinit = [0.06, 10, 0.042676];


%load NUMmodelsmall.mat
load NUMmodel_init.mat
siminit = sim;

p = setupNUMmodel([0.5 2], [10 1000], 6,6,1, bParallel= true); % A fast version of the NUM setup
p = setupNUMmodel(bParallel=true);
p = parametersGlobal(p,1);
p.BC_POMclosed = false;
p.BCdiffusion = [1 0 10]; % Diffusivities of N, DOC, and Si at the bottom
setSinkingPOM(p, parinit(2))
p.tEnd = 3*365;
p.bUse_parday_light = true; % Use the PARday file for light
p.kw = parinit(1);

mHTL = .1;
bHTLdecline = false;
bHTLquadratic = true;

% The objective we are optimizing towards:
objExpected = [1 1 1 800 200 1000]; % Pico, POC, copepods; NPP , eutrophic oligotrophic and seasonal

%p.tSave = 1;
%p.tEnd = 12;

%simHTL = {};
for i = 1:length(mortHTL)
    poolobj = gcp('nocreate');
        delete(poolobj);

    p = setupNUMmodel(bParallel=true);
    p = parametersGlobal(p,1);
    p.BC_POMclosed = false;
    p.BCdiffusion = [1 0 10]; % Diffusivities of N, DOC, and Si at the bottom
    
    p.tEnd = 3*365;
    p.bUse_parday_light = true; % Use the PARday file for light
    p.kw = parinit(1);
    setHTL(parinit(3), mHTL, bHTLquadratic, bHTLdecline);

    setSinkingPOM(p, sinking(i))
    simHTL{i} = simulateGlobal(p,siminit,bCalcAnnualAverages=true, bVerbose=false);
    drawnow
    obj(i,:) = EvaluateRun(simHTL{i});
    err = double(mean(abs(log(obj(i,:) ./ objExpected))));

    siminit = simHTL{i};
end
%%
clf
tiledlayout(2,1)

nexttile
plot(sinking,obj(:,1:3), sinking, 0*sinking,'k--')
legend({'Pico','POC','Copepods'})

nexttile
plot(sinking,obj(:,4:6))
ylabel('NPP')
xlabel('mortHTL')
legend({'Eutrophic','Oligotrophic','Seasonal'})