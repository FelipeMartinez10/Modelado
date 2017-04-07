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
       n1        n2        n3        n4        n5        n6        n7        n8        n9        n10       n11       n12         n13         n14        n15       n16        n17        n18        n19        n20        n21        n22        n23        n24        n25        n26        n27
n1     115       138       68        110       147       97        117       138       139       61        64        138         73          107        70        150        148        125        141        57         140        90         71         58         125        62         53
n2     57        92        82        63        89        86        117       132       146       64        117       135         62          107        129       148        84         104        68         118        56         69         138        128        121        112        123
n3     65        65        119       89        115       107       103       103       83        135       127       120         112         93         144       139        89         111        111        126        106        105        51         78         122        127        89
n4     59        63        74        111       51        62        85        125       149       114       139       147         57          61         131       120        93         101        61         71         112        100        88         61         92         75         62
n5     141       133       75        87        97        117       93        76        67        64        133       103         75          111        103       100        123        75         82         67         65         106        134        135        80         90         98
n6     76        77        90        126       140       111       90        63        105       90        136       88          136         144        148       72         142        58         152        123        124        52         127        118        62         108        112
n7     117       84        120       91        141       69        142       117       113       118       68        142         67          103        120       113        103        61         118        149        76         115        50         80         91         91         99
n8     139       150       146       63        82        122       107       56        74        108       111       124         79          150        68        55         77         79         114        92         107        78         111        89         70         128        148
n9     51        55        83        111       91        144       75        109       74        71        54        82          67          124        146       55         107        57         107        131        127        128        145        74         149        50         152
n10    147       148       103       144       100       132       96        52        146       54        113       62          107         88         52        84         127        58         116        116        146        152        133        150        80         113        80
n11    138       151       128       52        101       126       77        94        60        122       68        71          140         65         116       72         149        93         123        131        79         124        131        108        147        132        95
n12    146       121       96        151       113       104       107       127       104       100       120       146         85          71         147       130        90         84         69         69         143        140        145        96         90         127        118
n13    65        71        136       58        139       76        94        51        143       118       109       91          144         126        102       119        62         148        129        127        64         64         144        91         77         92         54
n14    108       55        119       119       89        92        109       89        146       113       59        132         64          133        151       88         119        51         63         149        83         131        59         88         95         63         131
n15    70        63        98        149       120       101       77        63        98        84        104       103         104         50         114       87         89         115        52         140        110        125        74         62         146        68         71
n16    101       88        94        123       58        145       141       131       127       114       86        135         104         79         120       119        130        62         123        130        124        138        106        149        152        103        80
n17    111       103       131       131       134       96        150       82        152       61        144       54          106         111        63        123        143        56         74         141        71         87         131        82         141        147        150
n18    113       102       131       119       57        71        117       68        148       83        120       61          58          138        109       96         134        67         126        113        74         104        135        150        106        89         139
n19    79        114       119       86        105       57        135       123       142       50        124       81          52          138        142       71         128        103        98         120        75         117        89         129        55         58         83
n20    139       117       127       61        126       72        91        71        98        61        67        54          122         119        102       106        116        102        117        81         139        63         90         116        67         72         75
n21    83        79        95        111       52        55        137       118       122       89        70        51          78          91         145       53         115        84         104        121        125        110        122        144        62         138        145
n22    94        132       129       109       129       130       115       64        60        105       74        121         94          99         123       97         91         100        148        115        118        126        119        93         55         98         83
n23    75        59        130       85        102       61        62        63        113       63        129       82          54          82         96        94         127        91         138        83         118        106        59         61         105        58         134
n24    73        145       52        122       55        109       142       97        106       84        63        50          101         86         101       142        139        139        119        61         99         92         111        90         57         107        135
n25    124       99        58        74        118       53        150       83        52        109       127       84          109         94         55        112        118        64         92         66         142        125        83         64         55         112        118
n26    147       113       112       136       52        50        64        121       114       54        149       110         63          126        66        107        142        64         78         57         144        79         148        129        60         136        88
n27    84        80        119       81        101       82        149       141       69        144       75        129         54          51         66        56         138        104        133        80         131        134        120        62         147        120        76

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