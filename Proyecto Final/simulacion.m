function [sM, sF, iM, iF, fM, fF, satM, satF] = simulacion(nodesCoordinates,matrizDeCostos, m, f, maxM, maxF )
% SIMULADOR DE EVENTOS DISCRETOS
fprintf('Iniciando simulacion con %d drones mensajeros y %d drones fotografos para %d misiones de mensajeria y %d misiones de fotografia \n', m,f,maxM,maxF);
% Inicializacion de variables
solicitudesMensajeria = 0;
solicitudesFotografia = 0;
iniciadasMensajeria = 0;
iniciadasFotografia = 0;
terminadasMensajeria = 0;
terminadasFotografia = 0;
mensajeros = m;
fotografos = f;
maximoFotografia = maxF;
maximoMensajeria = maxM;
saturadoFotografia = 0;
saturadoMensajeria = 0;
% El conjunto de nodos origen
origenes = [14 21];
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
evt.t = unidrnd(150-30+1)+(30-1);
evt.type = 'Fotografo A';
evt.r = 0;
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
evt.t = unidrnd(75-20+1)+(20-1);
evt.type = 'Mensajero A';
evt.r = 0;
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
              newEvt.r = 0;
              evtQueue = [evtQueue newEvt];
           else
              saturadoFotografia = 1; 
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
           newEvt.r = 0;
           evtQueue = [evtQueue newEvt];
        end
    end
    
    % Procesamiento del evento A: drone fotografo sale
    if evt.type=='Fotografo B'
        %Se suma al numero de misiones iniciadas
        iniciadasFotografia = iniciadasFotografia + 1;
        %Se resta al numero de drones mensajeros disponibles
        fotografos = fotografos - 1;
        %Se calcula la ruta a seguir y el tiempo que va a demorar
        [sp, spcost, P]=dijkstra_v2(matrizDeCostos, evt.s, evt.d);
        %Se crea el evento c
        newEvt.type = 'Fotografo C';
        tiempo = spcost/30;
        newEvt.t = t + tiempo + 150;
        newEvt.s = evt.s;
        newEvt.d = evt.d;        
        newEvt.r = length(sp);
        evtQueue = [evtQueue newEvt];
        
    end    
    
    % Procesamiento del evento B: drone fotografo llega
    if evt.type=='Fotografo C'
       %Se suma al numero de misiones completadas
       terminadasFotografia = terminadasFotografia + 1;
       %Se calcula el tiempo de carga o cambio de baterias, antes de poder viajar de nuevo
       carga = evt.r*20;
       %Se crea el evento d
       newEvt.s = evt.s;
       newEvt.d = evt.d;
       newEvt.t = t + carga;
       newEvt.r = evt.r;
       newEvt.type = 'Fotografo D';
       evtQueue = [evtQueue newEvt];
    end
    
    if evt.type=='Fotografo D'
       %Se suma al numero de drones mensajeros disponibles
       fotografos = fotografos + 1;
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
              newEvt.r = 0;
              evtQueue = [evtQueue newEvt];
           else
              saturadoMensajeria = 1; 
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
           newEvt.r = 0;
           evtQueue = [evtQueue newEvt];
        end
    end
    
    % Procesamiento del evento B: drone mensajero sale
    if evt.type=='Mensajero B'
        %Se suma al numero de misiones iniciadas
        iniciadasMensajeria = iniciadasMensajeria + 1;
        %Se resta al numero de drones mensajeros disponibles
        mensajeros = mensajeros - 1;
        %Se calcula la ruta a seguir y el tiempo que va a demorar
        [sp, spcost, P]=dijkstra_v2(matrizDeCostos, evt.s, evt.d);
        %Se crea el evento c
        newEvt.type = 'Mensajero C';
        tiempo = spcost/30;
        newEvt.t = t + tiempo + 60;
        newEvt.s = evt.s;
        newEvt.d = evt.d;        
        newEvt.r = length(sp);
        evtQueue = [evtQueue newEvt];
    end  
    
    % Procesamiento del evento C: drone mensajero llega
    if evt.type=='Mensajero C'
       %Se suma al numero de misiones completadas
       terminadasMensajeria = terminadasMensajeria + 1;
       %Se calcula el tiempo de carga o cambio de baterias, antes de poder viajar de nuevo
       carga = evt.r*20;
       %Se crea el evento d
       newEvt.s = evt.s;
       newEvt.d = evt.d;
       newEvt.t = t + carga;
       newEvt.r = evt.r;
       newEvt.type = 'Mensajero D';
       evtQueue = [evtQueue newEvt];
    end
    
    % Procesamiento del evento D: drone mensajero cargado y disponible
    if evt.type=='Mensajero D'
       %Se suma al numero de drones mensajeros disponibles
       mensajeros = mensajeros + 1;
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

end

sM = solicitudesMensajeria;
sF = solicitudesFotografia;
iM = iniciadasMensajeria;
iF = iniciadasFotografia;
fM = terminadasMensajeria;
fF = terminadasFotografia;
satF = saturadoFotografia;
satM = saturadoMensajeria;
end
