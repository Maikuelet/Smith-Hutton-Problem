% --------EXERCICE 4 CODEv4----------- %

clear all
more off

%Load input data
InputData

tic;
mesh=UniformMesh(domainPoints,meshSizes);
fprintf('MeshTime %f\n',toc); tic;

physProp=PhysProp(mesh,rhogamma,cp,k,rho);
fprintf('PhysPropTime %f\n',toc); tic;

boundCond=BoundCond(inletProp, outletProp, leftProp, rightProp, upperProp);
fprintf('BoundCondTime %f\n',toc); tic;

tcd2D=TransientConvectionDiffusion2D(mesh, physProp, boundCond, timeStep, initProp, refTime);
fprintf('CreateTHC2DTime %f\n',toc); tic;

[PropReqPoints,timeReqPoints]=tcd2D.solveTime(lastTime, reqPoints, maxIter, maxDiff);

%Postprocess(tcd2D.Prop.T, mesh);






% PostProcess