% ITERATIVE SOLVER METHODS
%----------------------------------------

classdef Solver < handle
    
    properties (SetAccess = private)
        
        
        
    end
    
    methods   
        
        
        function obj=Solver(coef, Prop)
            
            
            
            
            %POINT-BY-POINT SOLVER
            %------------------------------------------------
            %posar per poder seleccionar solver amb els parametres
            %d'entrada
            
            
            sizeX=size(coef.ap,1);
            sizeY=size(coef.ap,2);         
            
            
            for indPX=2:sizeX-1
                for indPY=2:sizeY-1
                    Prop.T(indPX,indPY) = (coef.ae(indPX,indPY)*Prop.T0(indPX+1,indPY)+ ...  
                                          coef.aw(indPX,indPY)*Prop.T0(indPX-1,indPY)+ ...
                                          coef.an(indPX,indPY)*Prop.T0(indPX,indPY+1)+ ...
                                          coef.as(indPX,indPY)*Prop.T0(indPX,indPY-1)+ ...
                                          coef.b(indPX,indPY))/(coef.ap(indPX,indPY))   ;
                end
            end
            
            
%             Prop.T(2:sizeX-1,2:sizeY-1) = (coef.ae(2:sizeX-1,2:sizeY-1).*Prop.T0((2:sizeX-1)+1,2:sizeY-1)+ ...  
%                                           coef.aw(2:sizeX-1,2:sizeY-1).*Prop.T0((2:sizeX-1)-1,(2:sizeY-1))+ ...
%                                           coef.an(2:sizeX-1,2:sizeY-1).*Prop.T0((2:sizeX-1),(2:sizeY-1)+1)+ ...
%                                           coef.as(2:sizeX-1,2:sizeY-1).*Prop.T0((2:sizeX-1),(2:sizeY-1)-1)+ ...
%                                           coef.b(2:sizeX-1,2:sizeY-1))./(coef.ap(2:sizeX-1,2:sizeY-1))   ;
                                       
             %LINE-BY-LINE SOLVER
             %--------------------------------------------
             
             
                                      
        end
        
        
        
    end
    
end
