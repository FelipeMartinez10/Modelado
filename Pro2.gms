Sets
     i   nodos                   /n1 * n7/
     m(i)   nodos fuente         /n7, n2, n5/
     p(i)   nodos destino        /n6/
     c coordenadas               /x, y/
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


Table a(i,j) altura entre cada par de nodos
       n1        n2        n3        n4        n5        n6        n7
n1     115       138       68        110       147       97        117
n2     57        92        82        63        89        86        117
n3     65        65        119       89        115       107       103
n4     59        63        74        111       51        62        85
n5     141       133       75        87        97        117       93
n6     76        77        90        126       140       111       90
n7     117       84        120       91        141       69        142


Parameter u(i,c) ubicaciones;
         u(i,c) = ubis(i,c);

Parameter d(i,j) distancias;
         d(i,j) = sqrt(sqr(u(i, 'x') - u(j, 'x')) + sqr(u(i, 'y') - u(j, 'y')));

Parameter dist_max distancia máxima en km que puede recorrer el dron /7.5/;

Parameter alt_min altura mínima a la que debe volar el dron /50/;

parameter D1(p) demanda de drones mensajeros en nodos destino
         /n6 50/;
parameter D2(p) demanda de drones fotografos en nodos destino
         /n6 50/;
parameter O1(m) oferta de drones mensajeros en nodos fuente
         /n7 35, n2 5, n5 10/;
parameter O2(m) oferta de drones fotografos en nodos fuente
         /n7 21, n2 9, n5 20/;

Variables
  x(i,j,m,p)       1 si se usa el arco (i j) para ir de m a p 0 si no se utiliza.
  y1(m,p)          Cantidad de drones mensajeros que se envian de m a p
  y2(m,p)          Cantidad de drones fotografos que se envian de m a p
  z                Minimizacion;

Positive variable x;



Equations
Fun_Obj(m)               Funcion Objetivo
restriccion_demanda1(p)  Restriccion de demanda y1
restriccion_demanda2(p)  Restriccion de demanda y2
restriccion_oferta1(m)   Restriccion de oferta y1
restriccion_oferta2(m)   Restriccion de oferta y2
nodos_intermedios        Restriccion nodos intermedios
alturas(i,j,m,p)         Restriccion de la altura
rest_1                 Restriccion 0
*rest_2(i,j,m,p)                      sabcjs
rest_3(i,j,m,p)                 Restriccion
;

Fun_Obj(m)                  ..      z =e= sum(p,(2*sum((i,j), x(i,j,m,p)*d(i,j)*(y1(m,p) + y2(m,p)))));
restriccion_demanda1(p)     ..      sum(m,y1(m,p)) =e= D1(p);
restriccion_demanda2(p)     ..      sum(m,y2(m,p)) =e= D2(p);
restriccion_oferta1(m)      ..      sum(p,y1(m,p)) =l= O1(m);
restriccion_oferta2(m)      ..      sum(p,y2(m,p)) =l= O2(m);
nodos_intermedios(m,p)      ..      sum((i,j), x(i,j,m,p)) - sum((i,j), x(j,i,m,p)) =e= 0;
alturas(i,j,m,p)            ..      x(i,j,m,p)*d(i,j) =l= (dist_max * (alt_min/a(i,j)));
rest_1                      ..      z=g=0;
*rest_2(i,j,m,p)                 ..      x(i,j,m,p)=g=-1;
rest_3(i,j,m,p)                 ..      x(i,j,m,p)=l=2;

Model Modelo1 /all/ ;


*option minlp=COUENNE
option minlp=BONMIN
*option minlp=BONMINH
*option minlp=KNITRO

Solve Modelo1 using minlp minimizing z;

Display x.l;
Display y1.l;
Display y2.l;
Display z.l;