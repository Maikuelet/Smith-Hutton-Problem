%POSTPROCESSOR 
%-------------------------------------------------------------------------

classdef Postprocess < handle
    
    properties (SetAccess=private)
    
    end
    methods
        function Postprocess(A, mesh)
            
            
            figure(1);
            subplot(3,1,1);
            h = heatmap(A);  %heatmap
            colormap(jet);
            colorbar;
            title('Temperature (Steady State)');
            xlabel('x'), ylabel('y');


            subplot(3,1,2);
            contour(A);     %mostra les isotermes
            colormap(jet);
            colorbar;
            title('Temperature isoterms (Steady State)');
            xlabel('x'), ylabel('y');

            subplot(3,1,3);
            pcolor(mesh.nodeX,mesh.nodeY,A);
            shading interp; 
            colormap(jet);
            colorbar;
            title('Temperature (Steady State)');
            xlabel('x'), ylabel('y');

            figure(2);
            ax1=subplot(2,1,1);
            contour(A);     %mostra les isotermes
            colormap(jet);
            colorbar;
            title('Temperature isoterms (Steady State)');
            xlabel('x'), ylabel('y');

            ax2=subplot(2,1,2);
            contourf(mesh.nodeX,mesh.nodeY,A);     %mostra les isotermes
            colormap(ax2,jet);
            colorbar;
            title('Temperature isoterms (Steady State)');
            xlabel('x'), ylabel('y');

            
        end
          
    end
    
end

