Sets
     i   nodos                   /n1 * n15/
     m(i)   nodos fuente         /n7/
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
n8       7       3
n9       7       8
n10      8       6
n11      8       8
n12      9       7
n13      9       1
n14     10       5
n15     10       2
;

Table a(i,j) altura entre cada par de nodos
         n1        n2        n3        n4        n5        n6        n7        n8        n9        n10        n11        n12        n13       n14        n15
n1       115       57        65        59        141       76        117       139       51        147        138        146        65        108        70
n2       57        92        65        63        133       77        84        150       55        148        151        121        71        55         63
n3       65        65        119       74        75        90        120       146       83        103        128        96         136       119        98
n4       59        63        74        111       87        126       91        63        111       144        52         151        58        119        149
n5       141       133       75        87        97        117       93        76        67        64         133        103        75        111        103
n6       76        77        90        126       117       111       90        63        105       90         136        88         136       144        148
n7       117       84        120       91        93        90        142       117       113       118        68         142        67        103        120
n8       139       150       146       63        76        63        117       56        74        108        111        124        79        150        68
n9       51        55        83        111       67        105       113       74        74        71         54         82         67        124        146
n10      147       148       103       144       64        90        118       108       71        54         113        62         107       88         52
n11      138       151       128       52        133       136       68        111       54        113        68         71         140       65         116
n12      146       121       96        151       103       88        142       124       82        62         71         146        85        71         147
n13      65        71        136       58        75        136       67        79        67        107        140        85         144       126        102
n14      108       55        119       119       111       144       103       150       124       88         65         71         126       133        151
n15      70        63        98        149       103       148       120       68        146       52         116        147        102       151        114

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
         /n7 50/;
parameter O2(m) oferta de drones fotografos en nodos fuente
         /n7 50/;

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
;

Fun_Obj(m)                  ..      z =e= sum(p,(2*sum((i,j), x(i,j,m,p)*d(i,j)*(y1(m,p) + y2(m,p)))));
restriccion_demanda1(p)     ..      sum(m,y1(m,p)) =e= D1(p);
restriccion_demanda2(p)     ..      sum(m,y2(m,p)) =e= D2(p);
restriccion_oferta1(m)      ..      sum(p,y1(m,p)) =l= O1(m);
restriccion_oferta2(m)      ..      sum(p,y2(m,p)) =l= O2(m);
nodos_intermedios(m,p)      ..      sum((i,j), x(i,j,m,p)) - sum((i,j), x(j,i,m,p)) =e= 0;
alturas(i,j,m,p)            ..      x(i,j,m,p)*d(i,j) =l= (dist_max * (alt_min/a(i,j)));


Model Modelo1 /all/ ;


option nlp=CONOPT
Solve Modelo1 using nlp minimizing z;

Display x.l;
Display y1.l;
Display y2.l;
Display z.l;
