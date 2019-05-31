%UNIFOR MESH & VELOCITY FIELD GENERATION 
%------------------------------------------

classdef UniformMesh < handle
  properties (SetAccess=private)
    nodeX, nodeY, faceX, faceY, domain, U, V, Uf, Vf
  end
  methods
        
    function obj = UniformMesh(domainPoints,meshSizes)
        
      [domainLengths] = DomainLength(domainPoints);
        
      dim=1;
      [obj.nodeX,obj.faceX]=facesZVB(domainLengths(dim),meshSizes(dim),domainPoints([1],[1]));
      dim=2;
      [obj.nodeY,obj.faceY]=facesZVB(domainLengths(dim),meshSizes(dim),domainPoints([2],[1]));
      
            U   = zeros(numel(obj.nodeX),numel(obj.nodeY));
            V   = zeros(numel(obj.nodeX),numel(obj.nodeY));
            Uf  = zeros(numel(obj.faceX),numel(obj.faceY));
            Vf  = zeros(numel(obj.faceX),numel(obj.faceY));
            
            for indPX=1:numel(obj.nodeX)
                for indPY=1:numel(obj.nodeY)

                    x = obj.nodeX(indPX);
                    y = obj.nodeY(indPY);

                    obj.U(indPX,indPY) =  2*y*(1-x^2);
                    obj.V(indPX,indPY) =  2*x*(1-y^2);
                    
                    
                end
            end
            
            for indPX=2:(numel(obj.faceX))
                for indPY=1:(numel(obj.faceY))
                    
                    xf = obj.faceX(indPX);
                    yf = obj.faceY(indPY);
                    
                    obj.Uf(indPX,indPY) =  2*yf*(1-xf^2);
                    obj.Vf(indPX,indPY) =  -2*xf*(1-yf^2);
                    
                end
            end    
            
            %No slip boundary Condition
            
            obj.Uf(2:end,end)=0;    %TopBoundary
            obj.Vf(2:end,end)=0;    
            obj.Uf(1,2:end)=0;      %LeftBoundary
            obj.Vf(1,2:end)=0;      
            obj.Uf(end,2:end)=0;    %RightBoundary
            obj.Vf(end,2:end)=0;    
           
            
        
    end  
    
    
    
    function [s]=surfX(obj)
      s=obj.faceX(2:end)-obj.faceX(1:end-1);
    end
    function [s]=surfY(obj)
      s=obj.faceY(2:end)-obj.faceY(1:end-1);
    end
  end
end

%Domain Length
function [domainLengths] = DomainLength (domainPoints)

xLength = domainPoints([1],[2])-domainPoints([1],[1]);  
yLength = domainPoints([2],[2])-domainPoints([2],[1]);                              
domainLengths=[xLength, yLength]; 

end

%facesZeroVolumeBoundaries
function [nx,fx]=facesZVB(length,numCV,initPoint)

fx=linspace(initPoint,initPoint+length,numCV+1);
nx(1,1)=initPoint;
nx(1,2:numCV+1)=(fx(2:end)+fx(1:end-1))*0.5;
nx(1,numCV+2)=initPoint+length;

end

