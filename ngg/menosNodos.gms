Sets
     i   nodos                   /n1 * n7/
     m(i)   nodos fuente         /n6/
     p(i)   nodos destino        /n3/
     k(i) nodos intermedios      /n1,n2,n4,n5,n7/
     c coordenadas               /x, y/
alias(i,j);
alias(k,l);

Table ubis(i,c) ubicaciones por nodo
         x       y
n1       1       3
n2       2       4
n3       2       6
n4       4       7
n5       5       3
n6       6       3
n7       6       5
;

Table a(i,j) altura entre cada par de nodos
         n1        n2        n3        n4        n5        n6        n7
n1       115       57        65        59        141       76        117
n2       57        92        65        63        133       77        84
n3       65        65        119       74        75        90        120
n4       59        63        74        111       87        126       91
n5       141       133       75        87        97        117       93
n6       76        77        90        126       117       111       90
n7       117       84        120       91        93        90        142

Parameter u(i,c) ubicaciones;
         u(i,c) = ubis(i,c);

Parameter d(i,j) distancias;
         d(i,j) = sqrt(sqr(u(i, 'x') - u(j, 'x')) + sqr(u(i, 'y') - u(j, 'y')));

Parameter dist_max distancia máxima en km que puede recorrer el dron /7.5/;

Parameter alt_min altura mínima a la que debe volar el dron /50/;

Parameter cant_m cantidad de origenes /1/

Parameter cant_p cantidad de destinos /1/

Parameter D1(p) demanda de drones mensajeros en nodos destino
         /n3 50/;
Parameter D2(p) demanda de drones fotografos en nodos destino
         /n3 50/;
Parameter O1(m) oferta de drones mensajeros en nodos fuente
         /n6 50/;
Parameter O2(m) oferta de drones fotografos en nodos fuente
         /n6 50/;

Variables
  x(i,j,m,p)       1 si se usa el arco (i j) para ir de m a p 0 si no se utiliza.
  y1(m,p)          Cantidad de drones mensajeros que se envian de m a p
  y2(m,p)          Cantidad de drones fotografos que se envian de m a p
  z                Minimizacion;
Binary variable x;



Equations
Fun_Obj                  Funcion Objetivo
restriccion_demanda1(p)  Restriccion de demanda y1
restriccion_demanda2(p)  Restriccion de demanda y2
restriccion_oferta1(m)   Restriccion de oferta y1
restriccion_oferta2(m)   Restriccion de oferta y2
nodos_origen(m)          Restriccion de los nodos oringen
nodos_destino(p)         Restriccion de los nodos destino
nodos_intermedios(m,p)   Restriccion nodos intermedios
mismo_nodo(i,m,p)        Restriccion del mismo nodo
alturas(i,j,m,p)         Restriccion de la altura
;

Fun_Obj                     ..      z =e= sum((m,p),(2*(sum((i,j), x(i,j,m,p)*d(i,j)*(y1(m,p) + y2(m,p))))));
restriccion_demanda1(p)     ..      sum((m),y1(m,p)) =e= D1(p);
restriccion_demanda2(p)     ..      sum((m),y2(m,p)) =e= D2(p);
restriccion_oferta1(m)      ..      sum((p),y1(m,p)) =l= O1(m);
restriccion_oferta2(m)      ..      sum((p),y2(m,p)) =l= O2(m);
nodos_origen(m)             ..      sum((i,j,p), x(i,j,m,p)) =e= cant_m;
nodos_destino(p)            ..      sum((i,j,m), x(i,j,m,p)) =e= cant_p;
nodos_intermedios(m,p)      ..      sum((k,l), x(k,l,m,p)) - sum((k,l), x(l,k,m,p)) =e= 0;
mismo_nodo(i,m,p)           ..      x(i,i,m,p) =e= 0;
alturas(i,j,m,p)            ..      x(i,j,m,p)*(dist_max*(alt_min/a(i,j))) =l= d(i,j);

Model Modelo1 /all/ ;

option minlp=ALPHAECP
Solve Modelo1 using minlp minimizing z;

Display x.l;
Display y1.l;
Display y2.l;
Display z.l;
