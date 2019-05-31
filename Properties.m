% PROPERTIES TO BE SAVED FOR THE POST PROCESSINGe
%-------------------------------------------------

classdef Properties < handle
    properties  (SetAccess = public)
        
        T, T0
        
    end 
    
    methods 
        function obj = Properties(mesh, initProp)
            
            obj.T = zeros(numel(mesh.nodeX),numel(mesh.nodeY))+initProp;
            obj.T0 = zeros(numel(mesh.nodeX),numel(mesh.nodeY))+initProp;
                        
        end
    end
end