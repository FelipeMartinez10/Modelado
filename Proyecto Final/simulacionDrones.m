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
h = figure;
min_x = 0;
max_x = 20;
min_y = 0;
max_y = 12;
c=imread('bogota.jpg');
figure;
imagesc([min_x max_x], [min_y max_y], flipdim(c,1));
set(gca,'ydir','normal');
hold on;
%Se crean las alturas!
alturaNodos=zeros(27,1);
alturaNodos(1,1)=122;
alturaNodos(2,1)=52;
alturaNodos(3,1)=138;
alturaNodos(4,1)=60;
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
alturaNodos(15,1)=50;
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
alturaNodos(26,1)=53;
alturaNodos(27,1)=52;
for i=1:length(nodesCoordinates)
    for j=1:length(nodesCoordinates)
        
            dij=sqrt( ( nodesCoordinates(i,1)-nodesCoordinates(j,1) )^2+( nodesCoordinates(i,2)-nodesCoordinates(j,2) )^2);
            if(dij<=RC*50/max(alturaNodos(i),alturaNodos(j))) & i~=j
                
                matrLinks(i,j)=1;
                
                line([nodesCoordinates(i,1), nodesCoordinates(j,1)], [nodesCoordinates(i,2), nodesCoordinates(j,2)], 'Color','m', 'LineWidth',1);
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
        text(x+0.2, y+0.2, num2str(i), 'FontSize',8, 'FontWeight', 'bold', 'Color','k');
        %title('Red Celular')
        % axis([0 110 0 60])
end

saveas(h, 'grafo.jpg');

numeroMensajeros = 3;
numeroFotografos = 3;
maxMensajeros = 100;
maxFotografos = 100;
[ iM, iF, fM, fF] = Simulacion(nodesCoordinates,matrLinks,numeroMensajeros,numeroFotografos,maxMensajeros,maxFotografos);


% ImpresiÃ³n de reporte final
fprintf('Misiones de fotografía iniciadas:%d\n',iF);
fprintf('Misiones de fotografía finalizadas:%d\n',fF);
fprintf('Misiones de mensajería iniciadas:%d\n',iM);
fprintf('Misiones de mensajería finalizadas:%d\n',fM);

