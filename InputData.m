%---------------INPUT DATA----------------
%-----------------------------------------

%Domain lengths
%------------------------
domainPoints=[-1 1; 0 1];       %First  row for X dim
                                %Second row for Y dim                       
               

%Requested points (x: OUTLET)
%--------------------------
reqPoints=[0.1 0; 0.2 0; 0.3 0 ; 0.4 0;  0.5 0; 0.6 0; 0.7 0; 0.8 0; 0.9 0; 1 0]; %[x ; y] points

%Mesh sizes
%--------------------
meshSizes=[100 50];

%Initial properties
%---------------------
initProp=1;

%Boundary conditions
%----------------------
inletProp = [0 2];
outletProp = 0;
leftProp = 0;
rightProp = 0;
upperProp = 0;

%Time inputs
%---------------------
timeStep=1.0e1;
lastTime=1.0e2;
refTime=5.0e1;

%Material properties
%---------------------
rhogamma=1000;
rho=10;
cp=4;
k=170;

%Iterative solver parameters
%-----------------------------
maxIter=1e4;
maxDiff=1e-4;

%solverName='GaussSeidel';
% solverName='Jacobi';

%solver=eval(sprintf('%sSolver',solverName));


%Other solvers

% solverName='Divide';
% solverName='Sparse';
% solver=eval(sprintf('%sSolver',solverName));
