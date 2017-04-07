Sets
     i   nodos   / n1 * n27/
     m(i)   nodos fuente    /n7, n16, n24/
     p(i)   nodos destino   /n6/
     c coordenadas /x, y/
alias(i,j);

Table ubis(i,c) ubicaciones por nodo
         x       y
n1       1       3
n2       2       4
n3       2       6
n4       4       7
n5       5       3
n6       6       3
n7       6       5
n8       7       3
n9       7       8
n10      8       6
n11      8       8
n12      9       7
n13      9       1
n14     10       5
n15     10       2
n16     11       9
n17     11       7
n18     12       4
n19     13      10
n20     14       1
n21     14      10
n22     15       2
n23     15       5
n24     16       7
n25     16       6
n26     19       9
n27      1      15;

Parameter u(i,c) ubicaciones;
         u(i,c) = ubis(i,c);

parameter D1(p) demanda de drones mensajeros en nodos destino
         /n6 50/;
parameter D2(p) demanda de drones fotografos en nodos destino
         /n6 50/;
parameter O1(m) oferta de drones mensajeros en nodos fuente
         /n7 35, n16 5, n24 10/;
parameter O2(m) oferta de drones fotografos en nodos fuente
         /n7 21, n16 9, n24 20/;

Variables
  x(i,j,m,p)       1 si se usa el arco (i j) para ir de m a p 0 si no se utiliza.
  y1(m,p)          Cantidad de drones mensajeros que se envian de m a p
  y2(m,p)          Cantidad de drones fotografos que se envian de m a p
  z                Minimizacion
  d(i,j)           Distancia entre el nodo i al nodo j;

Positive variable x;



Equations
Fun_Obj(m)               Funcion Objetivo
restriccion_demanda1(p)  Restriccion de demanda y1
restriccion_demanda2(p)  Restriccion de demanda y2
restriccion_oferta1(m)   Restriccion de oferta y1
restriccion_oferta2(m)   Restriccion de oferta y2
nodos_intermedios        Restriccion nodos intermedios
Distancia(i,j)           Matriz de distancias
;

Distancia(i,j)              ..      d(i,j) =e= sqrt(sqr(u(i, 'x') - u(j, 'x')) + sqr(u(i, 'y') - u(j, 'y')));
Fun_Obj(m)                  ..      z =e= sum(p,(2*sum((i,j), x(i,j,m,p)*d(i,j)*(y1(m,p) + y2(m,p)))));
restriccion_demanda1(p)     ..      sum(m,y1(m,p)) =e= D1(p);
restriccion_demanda2(p)     ..      sum(m,y2(m,p)) =e= D2(p);
restriccion_oferta1(m)      ..      sum(p,y1(m,p)) =l= O1(m);
restriccion_oferta2(m)      ..      sum(p,y2(m,p)) =l= O2(m);
nodos_intermedios(m,p)      ..      sum((i,j), x(i,j,m,p)) - sum((i,j), x(j,i,m,p)) =e= 0;


Model Modelo1 /all/ ;


option nlp=CONOPT
Solve Modelo1 using nlp minimizing z;

Display x.l;
Display y1.l;
Display y2.l;
Display z.l;

