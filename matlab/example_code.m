p = setupNUMmodel( bParallel=true ); % model setup
p = parametersGlobal( p ); % the physical model
sim = simulateGlobal( p ); % Run simulation
plotSimulation( sim );
