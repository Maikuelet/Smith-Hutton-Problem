%TRANSIENT 2-D CONVECTION-DIFFUSSION EQUATION
%------------------------------------------------

classdef TransientConvectionDiffusion2D < handle
    
    properties (SetAccess=public)
        mesh, physProp,boundCond ,timeStep, refTime , coef, Prop,Pref, err
    end
    
    %Prop = property to compute
    
    methods
        
        function  obj = TransientConvectionDiffusion2D(mesh, physProp, boundCond, timeStep, initProp, refTime)
            obj.mesh=mesh;
            obj.physProp=physProp;
            obj.boundCond=boundCond;            
            obj.timeStep=timeStep;
            obj.refTime = refTime;
            
            obj.Prop = Properties(mesh, initProp); 
            obj.coef = Coefficients(obj.mesh);
            
            
        end
        
        
        %Main algorithm
        function [PropReqPoints,timeReqPoints]=solveTime(obj,lastTime, reqPoints, maxIter, maxDiff)
            
            
            
            %CONSTANT COEFFICIENTS
            %-----------------------------------------------------------------------
            %Inner matrix
            obj.coef.innerAfor(obj.physProp,obj.mesh,obj.timeStep, obj.Prop);  
            
            
            %Boundaries
            obj.coef.topBoundary(obj.boundCond.upperProp,obj.Prop);   
            obj.coef.leftBoundary(obj.boundCond.leftProp, obj.Prop);      
            obj.coef.bottomBoundary(obj.boundCond.outletProp,obj.boundCond.inletProp,obj.Prop,obj.mesh);
            obj.coef.rightBoundary(obj.boundCond.rightProp,obj.Prop);
            
            
            %MAIN ALGORITHM
            %------------------------------------------------------------------------
            
            time=0.0;
            
            
            
            %REQUESTED POINTS RESULTS
            %-----------------
            numTotalValues=min(lastTime/max(1,obj.timeStep),1e4)+1;
            
            timeReqPoints=zeros(1,numTotalValues);      
            PropReqPoints=zeros(numTotalValues,size(reqPoints,1));   
            
            %Matlab Interpolation Function FOR reqPoints
            PropReqPoints(1,:)=interp2(obj.mesh.nodeX,obj.mesh.nodeY,...
            obj.Prop.T',reqPoints(:,1),reqPoints(:,2))';     
        
        
            
            obj.Prop.T0 = obj.Prop.T;                       
            
            cnt=1;
            t1=toc;
            fprintf(' Time: %f\nsolveTime: :Iterate: \n',t1);
            
            %CORE OF THE CODE
            %--------------------------------------------------------------
            tic;t1=toc;
            saveRefTime=true;    
      
            
            
            while time<lastTime
                
                % TIMING OF ITERATIONS FOR LAST TIME STEP
                %-----------------
                time=time+obj.timeStep;
%                 if mod(round(time),showStep)==0 &&...
%                     abs(time-round(time))<0.5*obj.timeStep
% 
%                     t2=toc;
%                     timePerIte=(t2-t1)/showStep;
%                     fprintf('Current Time: %6.f TpI: %.3es ETC: %5.fs\n',...
%                     time,timePerIte,timePerIte*(lastTime-time));
%                     t1=t2;
%                 end
                
                %DOMAIN CONVERGENCE
                %-----------------
                it = 0;
                sizeX=size(obj.coef.ap,1);
                sizeY=size(obj.coef.ap,2);
                obj.err = zeros (sizeX-1,sizeY-1)+1;
                a=max(obj.err);
                stop=0;
                
                while (max(a) > maxDiff)  || stop == 1
                    
                    it = it +1;
                    
                    %SOLVER 
                    %-----------------
                    obj.Prop.T0 = obj.Prop.T;
                    
                    Solver(obj.coef, obj.Prop);                     
                    
                    
                                       
                    %COEFFICIENTS
                    %------------------
                    %Inner matrix
                    obj.coef.innerAforTime(obj.mesh,obj.timeStep,obj.Prop);
                    
                    
                    % CONVERGENCE CHECK
                    %-----------------
                    
                    
                    
                    obj.err = abs(obj.Prop.T0-obj.Prop.T);
                    a=max(obj.err);
                    
                    
                    
%                     for indPX=2:sizeX-1
%                         for indPY=2:sizeY-1
%                             
%                             
%                             error = obj.Prop.T-obj.Prop.T0;
%                             
%                             if abs(error) < maxDiff 
%                                 
%                                 divergence = 0;                                
%                             else
%                                 divergence = 1;
%                             end
%                                                        
%                         end  
%                     end                   
                    
                    if it > maxIter
                        error("Can not reach convergence of the results, check Input Data")
                        stop=1;
                    end
                    
                end
                
                       
                
                
                
                
                %Ensures time steps count and saves times
                if (time+obj.timeStep)>cnt
                  cnt=cnt+1;
                  timeReqPoints(cnt)=time;


                  PropReqPoints(cnt,:)=interp2(obj.mesh.nodeX,obj.mesh.nodeY,...
                    obj.Prop.T',reqPoints(:,1),reqPoints(:,2))';
                end
                %Saves temperature at reference time
                if saveRefTime && (time+obj.timeStep)>obj.refTime
                    fprintf('Saving refTemp: %f\n',time);
                    obj.Pref=obj.Prop.T;
                    saveRefTime=false;
                end    
                 
            end
            
            o = rot90(obj.Prop.T,-1);
            O=fliplr(o);
            
            
            figure(1);
           
            subplot(2,1,1);
            contour(O);     %mostra les isotermes
            colormap(jet);
            colorbar;
            title('Temperature isoterms (Steady State)');
            xlabel('x'), ylabel('y');

            subplot(2,1,2);
            pcolor(obj.mesh.nodeX,obj.mesh.nodeY,O);
            shading interp; 
            colormap(jet);
            colorbar;
            title('Temperature (Steady State)');
            xlabel('x'), ylabel('y');

            figure(2);
            
                      
            ax1=subplot(2,1,1);
            contour(O);     %mostra les isotermes
            colormap(jet);
            colorbar;
            title('Temperature isoterms (Steady State)');
            xlabel('x'), ylabel('y');

            ax2=subplot(2,1,2);
            contourf(obj.mesh.nodeX,obj.mesh.nodeY,O);     %mostra les isotermes
            colormap(ax2,jet);
            colorbar;
            title('Temperature isoterms (Steady State)');
            xlabel('x'), ylabel('y');

            figure(3);
            pcolor(obj.mesh.nodeX,obj.mesh.nodeY,O);
            shading interp; 
            colormap(jet);
            colorbar;
            title('Temperature (Steady State)');
            xlabel('x'), ylabel('y');
            
            figure(4);
            h = heatmap(rot90(o,-2));  %heatmap
            colormap(jet);
            colorbar;
            title('Temperature (Steady State)');
            xlabel('x'), ylabel('y');

            
        end
        
        
        
                
    end
    
    
    
end
