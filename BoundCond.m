%BOUNDARY CONDITIONS for defined PROPERTY
%----------------------------------------
classdef BoundCond < handle
    properties (SetAccess = private)
        inletProp, outletProp, leftProp, rightProp, upperProp
    end
    
    methods
        function obj = BoundCond(inletProp, outletProp, leftProp, rightProp, upperProp)
            obj.inletProp = inletProp;
            obj.outletProp= outletProp;
            obj.leftProp  = leftProp;
            obj.rightProp = rightProp;
            obj.upperProp = upperProp;
        end
    end
end
    
    