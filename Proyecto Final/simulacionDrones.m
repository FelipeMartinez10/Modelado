clc, clear all, close all

%% Inicio Graficar Nodos
% Posiciones de los nodos---------------------------------------------------            
nodesCoordinates=zeros(27,2);
nodesCoordinates(1,1)=1; nodesCoordinates(1,2)=3; nodesCoordinates(2,1)=2; nodesCoordinates(2,2)=4;
nodesCoordinates(3,1)=2; nodesCoordinates(3,2)=6; nodesCoordinates(4,1)=4; nodesCoordinates(4,2)=7;
nodesCoordinates(5,1)=5; nodesCoordinates(5,2)=3; nodesCoordinates(6,1)=6; nodesCoordinates(6,2)=3;
nodesCoordinates(7,1)=6; nodesCoordinates(7,2)=5; nodesCoordinates(8,1)=7; nodesCoordinates(8,2)=3;
nodesCoordinates(9,1)=7; nodesCoordinates(9,2)=8; nodesCoordinates(10,1)=8; nodesCoordinates(10,2)=6;
nodesCoordinates(11,1)= 8;nodesCoordinates(11,2)=8; nodesCoordinates(12,1)=9; nodesCoordinates(12,2)=7;
nodesCoordinates(13,1)=10; nodesCoordinates(13,2)=1; nodesCoordinates(14,1)=10; nodesCoordinates(14,2)=5;
nodesCoordinates(15,1)=11; nodesCoordinates(15,2)=2; nodesCoordinates(16,1)=11; nodesCoordinates(16,2)=9;
nodesCoordinates(17,1)=12; nodesCoordinates(17,2)=7; nodesCoordinates(18,1)=13; nodesCoordinates(18,2)=4;
nodesCoordinates(19,1)=13; nodesCoordinates(19,2)=10; nodesCoordinates(20,1)=14; nodesCoordinates(20,2)=1;
nodesCoordinates(21,1)=14; nodesCoordinates(21,2)=10; nodesCoordinates(22,1)=15; nodesCoordinates(22,2)=2;
nodesCoordinates(23,1)=15; nodesCoordinates(23,2)=5; nodesCoordinates(24,1)=16; nodesCoordinates(24,2)=7;
nodesCoordinates(25,1)=16; nodesCoordinates(25,2)=6; nodesCoordinates(26,1)=19; nodesCoordinates(26,2)=9;
nodesCoordinates(27,1)=1; nodesCoordinates(27,2)=12;

RC = 7.5; % Radio de cobertura
for i=1:length(nodesCoordinates)
    for j=1:length(nodesCoordinates)
        
            dij=sqrt( ( nodesCoordinates(i,1)-nodesCoordinates(j,1) )^2+( nodesCoordinates(i,2)-nodesCoordinates(j,2) )^2);
            if(dij<=RC) & i~=j
                
                matrLinks(i,j)=1;
                
                line([nodesCoordinates(i,1), nodesCoordinates(j,1)], [nodesCoordinates(i,2), nodesCoordinates(j,2)],'LineStyle',':', 'Color','k', 'LineWidth',1);
                hold on;
            else
                matrLinks(i,j)=inf;
            end
        
    end
end

for i=1:length(nodesCoordinates)
        x=nodesCoordinates(i,1);
        y=nodesCoordinates(i,2);
        if i==1
            plot(nodesCoordinates(i,1), nodesCoordinates(i,2), 's', 'LineWidth',1,'MarkerEdgeColor','k', 'MarkerFaceColor','k', 'MarkerSize',9);
        else
            plot(nodesCoordinates(i,1), nodesCoordinates(i,2), 'o', 'LineWidth',1,'MarkerEdgeColor','k', 'MarkerFaceColor','k', 'MarkerSize',7);            
        end
        text(x+1, y+0.5, num2str(i), 'FontSize',8, 'FontWeight', 'bold', 'Color','k');
        %title('Red Celular')
        % axis([0 110 0 60])
end



%% SIMULADOR DE EVENTOS DISCRETOS
% Inicializacion de variables

% Inicialización del tiempo de simulación
t=0;
% Programacion del evento inicial
evt.t = 1;
evt.type = 'A';
% Programacion en la cola de eventos
evtQueue = evt;
% Core de la simulacion
while length(evtQueue)>0 
    evtAct=evtQueue(1); 
    evtQueue(1)=[];
    
    t=evtAct.t;
    
    % Procesamiento del evento A.
    if evt.type=='A'
        
        
                
    end    
    
    % Procesamiento del evento B.
    if evt.type=='B'
        
        
                
    end 
    
    % Procesamiento del evento C.
    if evt.type=='C'
        
        
                
    end                 
    
       
    % Organizacion de la cola de eventos
    flag=1;
    while flag==1
        flag=0; 
        for i=1:(length(evtQueue)-1)
            if evtQueue(i).t>evtQueue(i+1).t
                temp=evtQueue(i);
                evtQueue(i)=evtQueue(i+1);
                evtQueue(i+1)=temp;
                flag=1; 
            end
        end
    end
    % Mostrado de la cola de eventos:
    fprintf('\nCola de eventos:\n');
    for i=1:length(evtQueue)
        fprintf('Evento %s en t=%f\n',evtQueue(i).type,evtQueue(i).t);
    end
    fprintf('----------------\n');
    %pause;
end

% Impresión de reporte final
