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
min_x = 0;
max_x = 20;
min_y = 0;
max_y = 12;
c=imread('bogota.jpg');
figure;
imagesc([min_x max_x], [min_y max_y], flipdim(c,1));
set(gca,'ydir','normal');
hold on;
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
        if i==14
            plot(nodesCoordinates(i,1), nodesCoordinates(i,2), 's',  'LineWidth',1,'MarkerEdgeColor','k', 'MarkerFaceColor','r', 'MarkerSize',9);
        else
            plot(nodesCoordinates(i,1), nodesCoordinates(i,2), 'o', 'LineWidth',1,'MarkerEdgeColor','k', 'MarkerFaceColor','k', 'MarkerSize',7);            
        end
        text(x+1, y+0.5, num2str(i), 'FontSize',8, 'FontWeight', 'bold', 'Color','k');
        %title('Red Celular')
        % axis([0 110 0 60])
end

%Se crean las alturas!
alturaNodos=zeros(27,1);
alturaNodos(1,1)=122;
alturaNodos(2,1)=52;
alturaNodos(3,1)=138;
alturaNodos(4,1)=150;
alturaNodos(5,1)=58;
alturaNodos(6,1)=99;
alturaNodos(7,1)=92;
alturaNodos(8,1)=151;
alturaNodos(9,1)=90;
alturaNodos(10,1)=77;
alturaNodos(11,1)=82;
alturaNodos(12,1)=87;
alturaNodos(13,1)=86;
alturaNodos(14,1)=98;
alturaNodos(15,1)=139;
alturaNodos(16,1)=70;
alturaNodos(17,1)=62;
alturaNodos(18,1)=93;
alturaNodos(19,1)=123;
alturaNodos(20,1)=143;
alturaNodos(21,1)=62;
alturaNodos(22,1)=64;
alturaNodos(23,1)=58;
alturaNodos(24,1)=125;
alturaNodos(25,1)=112;
alturaNodos(26,1)=118;
alturaNodos(27,1)=53;


%% SIMULADOR DE EVENTOS DISCRETOS
% Inicializacion de variables
solicitudesMensajeria = 0;
solicitudesFotografia = 0;
iniciadasMensajeria = 0;
iniciadasFotografia = 0;
terminadasMensajeria = 0;
terminadasFotografia = 0;
mensajeros = 5;
fotografos = 10;
maximoFotografia = 100;
maximoMensajeria = 100;
% El conjunto de nodos origen
origenes = [14];
% Inicialización del tiempo de simulación
t=0;
% Programacion del evento inicial Fotografo
%El origen se escoge del conjunto de origenes
origen = origenes(unidrnd(length(origenes)));
evt.s = origen;
% Destino, aleatorio entre 1 y el numero de nodos
destino = unidrnd(length(nodesCoordinates));
% Origen y destino no pueden ser iguales
while destino == origen
   destino = unidrnd(length(nodesCoordinates)); 
end
evt.d = destino;
evt.t = unidrnd(15-5+1)+(5-1);
evt.type = 'Fotografo A';
% Programacion en la cola de eventos
evtQueue = evt;

% Programacion del evento inicial Mensajero

%El origen se escoge del conjunto de origenes
origen = origenes(unidrnd(length(origenes)));
evt.s = origen;
% Destino, aleatorio entre 1 y el numero de nodos
destino = unidrnd(length(nodesCoordinates));
% Origen y destino no pueden ser iguales
while destino == origen
   destino = unidrnd(length(nodesCoordinates)); 
end
evt.d = destino;
evt.t = unidrnd(15-5+1)+(5-1);
evt.type = 'Mensajero A';
% Programacion en la cola de eventos
evtQueue = [evtQueue evt];

% Core de la simulacion
while length(evtQueue)>0 && (solicitudesMensajeria < maximoMensajeria || solicitudesFotografia < maximoFotografia)
    evt=evtQueue(1); 
    evtQueue(1)=[];
    
    t=evt.t;
    
    % Procesamiento del evento A: solicitud de mision para drone mensajero
    if evt.type=='Fotografo A'
        if solicitudesFotografia < maximoFotografia
           %Se suma a las misiones de drone mensajero solicitadas
           solicitudesFotografia = solicitudesFotografia + 1;
           %Si hay disponibilidad, se envia el drone (evento B)
           if fotografos > 0
              newEvt.s = evt.s;
              newEvt.d = evt.d;
              newEvt.t = evt.t + unidrnd(15-5+1)+(5-1);
              newEvt.type = 'Fotografo B';
              evtQueue = [evtQueue newEvt];
           end
           %Se crea otro evento A
           origen = origenes(unidrnd(length(origenes)));
           newEvt.s = origen;
           destino = unidrnd(length(nodesCoordinates));
           while destino == origen
              destino = unidrnd(length(nodesCoordinates)); 
           end
           newEvt.d = destino;
           newEvt.t = t + unidrnd(150-30+1)+(30-1);
           newEvt.type = 'Fotografo A';
           evtQueue = [evtQueue newEvt];
        end
    end
    
    % Procesamiento del evento A: drone fotografo sale
    if evt.type=='Fotografo B'
        %Se suma al numero de misiones iniciadas
        
        %Se resta al numero de drones fotografos disponibles
        
        %Se calcula la ruta a seguir y el tiempo que va a demorar
        
        %Se crea el evento b
        
        %Se crea el evento a, teniendo en cuenta la oferta de drones
        %fotografos
        
    end    
    
    % Procesamiento del evento B: drone fotografo llega
    if evt.type=='Fotografo C'
       %Se suma al numero de misiones completadas
       
       %Se calcula el tiempo de carga, antes de poder viajar de nuevo
        
       %Se crea el evento c
    end
    
    if evt.type=='Fotografo D'
       %Se suma al numero de drones fotografos disponibles
       
    end
    
    % Procesamiento del evento A: solicitud de mision para drone mensajero
    if evt.type=='Mensajero A'
        if solicitudesMensajeria < maximoMensajeria
           %Se suma a las misiones de drone mensajero solicitadas
           solicitudesMensajeria = solicitudesMensajeria + 1;
           %Si hay disponibilidad, se envia el drone (evento B)
           if mensajeros > 0
              newEvt.s = evt.s;
              newEvt.d = evt.d;
              newEvt.t = evt.t + unidrnd(60-20+1)+(20-1);
              newEvt.type = 'Mensajero B';
              evtQueue = [evtQueue newEvt];
           end
           %Se crea otro evento A
           origen = origenes(unidrnd(length(origenes)));
           newEvt.s = origen;
           destino = unidrnd(length(nodesCoordinates));
           while destino == origen
              destino = unidrnd(length(nodesCoordinates)); 
           end
           newEvt.d = destino;
           newEvt.t = t + unidrnd(75-20+1)+(20-1);
           newEvt.type = 'Mensajero A';
           evtQueue = [evtQueue newEvt];
        end
    end
    
    % Procesamiento del evento B: drone mensajero sale
    if evt.type=='Mensajero B'
        %Se suma al numero de misiones iniciadas
        
        %Se resta al numero de drones fotografos disponibles
        
        %Se calcula la ruta a seguir y el tiempo que va a demorar
        
        %Se crea el evento b
        
        %Se crea el evento a, teniendo en cuenta la oferta de drones
        %fotografos
        
                
    end  
    
    % Procesamiento del evento C: drone mensajero llega
    if evt.type=='Mensajero C'
       %Se suma al numero de misiones completadas
       
       %Se calcula el tiempo de carga, antes de poder viajar de nuevo
        
       %Se crea el evento a    
        
                
    end     
    
    % Procesamiento del evento D: drone mensajero cargado y disponible
    if evt.type=='Mensajero D'
       %Se suma al numero de drones mensajeros disponibles
       
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
%     fprintf('\nCola de eventos:\n');
%     for i=1:length(evtQueue)
%         fprintf('Evento %s en t=%f\n',evtQueue(i).type,evtQueue(i).t);
%     end
%     fprintf('----------------\n');
    %pause;
end

% Impresión de reporte final
