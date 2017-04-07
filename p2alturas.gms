Sets
     i   nodos                   /n1 * n27/
     m(i)   nodos fuente         /n7, n16, n24/
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

Table a(i,j) altura entre cada par de nodos
         n1        n2        n3        n4        n5        n6        n7        n8        n9        n10        n11        n12        n13       n14        n15        n16        n17       n18       n19       n20       n21       n22       n23       n24       n25       n26       n27
n1       115       57        65        59        141       76        117       139       51        147        138        146        65        108        70         101        111       113       79        139       83        94        75        73        124       147       84
n2       57        92        65        63        133       77        84        150       55        148        151        121        71        55         63         88         103       102       114       117       79        132       59        145       99        113       80
n3       65        65        119       74        75        90        120       146       83        103        128        96         136       119        98         94         131       131       119       127       95        129       130       52        58        112       119
n4       59        63        74        111       87        126       91        63        111       144        52         151        58        119        149        123        131       119       86        61        111       109       85        122       74        136       55
n5       141       133       75        87        97        117       93        76        67        64         133        103        75        111        103        100        123       75        82        67        65        106       134       135       80        90        98
n6       76        77        90        126       117       111       90        63        105       90         136        88         136       144        148        72         142       58        152       123       124       52        127       118       62        108       112
n7       117       84        120       91        93        90        142       117       113       118        68         142        67        103        120        113        103       61        118       149       76        115       50        80        91        91        99
n8       139       150       146       63        76        63        117       56        74        108        111        124        79        150        68         55         77        79        114       92        107       78        111       89        70        128       148
n9       51        55        83        111       67        105       113       74        74        71         54         82         67        124        146        55         107       57        107       131       127       128       145       74        149       50        152
n10      147       148       103       144       64        90        118       108       71        54         113        62         107       88         52         84         127       58        116       116       146       152       133       150       80        113       80
n11      138       151       128       52        133       136       68        111       54        113        68         71         140       65         116        72         149       93        123       131       79        124       131       108       147       132       95
n12      146       121       96        151       103       88        142       124       82        62         71         146        85        71         147        130        90        84        69        69        143       140       145       96        90        127       118
n13      65        71        136       58        75        136       67        79        67        107        140        85         144       126        102        119        62        148       129       127       64        64        144       91        77        92        54
n14      108       55        119       119       111       144       103       150       124       88         65         71         126       133        151        88         119       51        63        149       83        131       59        88        95        63        131
n15      70        63        98        149       103       148       120       68        146       52         116        147        102       151        114        87         89        115       52        140       110       125       74        62        146       68        71
n16      101       88        94        123       100       72        113       55        55        84         72         130        119       88         87         119        130       62        123       130       124       138       106       149       152       103       80
n17      111       103       131       131       123       142       103       77        107       127        149        90         62        119        89         130        143       56        74        141       71        87        131       82        141       147       150
n18      113       102       131       119       75        58        61        79        57        58         93         84         148       51         115        62         56        67        126       113       74        104       135       150       106       89        139
n19      79        114       119       86        82        152       118       114       107       116        123        69         129       63         52         123        74        126       98        120       75        117       89        129       55        58        83
n20      139       117       127       61        67        123       149       92        131       116        131        69         127       149        140        130        141       113       120       81        139       63        90        116       67        72        75
n21      83        79        95        111       65        124       76        107       127       146        79         143        64        83         110        124        71        74        75        139       125       110       122       144       62        138       145
n22      94        132       129       109       106       52        115       78        128       152        124        140        64        131        125        138        87        104       117       63        110       126       119       93        55        98        83
n23      75        59        130       85        134       127       50        111       145       133        131        145        144       59         74         106        131       135       89        90        122       119       59        61        105       58        134
n24      73        145       52        122       135       118       80        89        74        150        108        96         91        88         62         149        82        150       129       116       144       93        61        90        57        107       135
n25      124       99        58        74        80        62        91        70        149       80         147        90         77        95         146        152        141       106       55        67        62        55        105       57        55        112       118
n26      147       113       112       136       90        108       91        128       50        113        132        127        92        63         68         103        147       89        58        72        138       98        58        107       112       136       88
n27      84        80        119       55        98        112       99        148       152       80         95         118        54        131        71         80         150       139       83        75        145       83        134       135       118       88        76
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
         /n7 35, n16 5, n24 10/;
parameter O2(m) oferta de drones fotografos en nodos fuente
         /n7 21, n16 9, n24 20/;

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
