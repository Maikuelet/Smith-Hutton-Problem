% PHYSICAL PROPERTIES DOMAIN FILLING
%------------------------------------

classdef PhysProp < handle
  properties (SetAccess=private)
    rhogamma, cp, k, rho
  end
  methods
    function obj=PhysProp(mesh,rhogamma,cp,k,rho)
        
      sizeX=numel(mesh.nodeX);
      sizeY=numel(mesh.nodeY);
      
      obj.rhogamma=zeros(sizeX,sizeY);
      obj.cp=zeros(sizeX,sizeY);
      obj.k=zeros(sizeX,sizeY);
      obj.rho = zeros(sizeX,sizeY);   
      
      %for one material
      
      obj.rhogamma(:,:)=rhogamma;  
      obj.rho(:,:)=rho;
      obj.cp(:,:)=cp;
      obj.k(:,:)=k;      
      
    end
  end
end
