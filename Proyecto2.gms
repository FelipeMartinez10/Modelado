Sets
     i   nodos   / n1 * n7/
     m   nodos fuente    /n1/
     p   nodos destino   /n7/
alias(i,j);


Variables
  x(i,j,m,p)       1 si se usa el arco (i j) para ir de m a p 0 si no se utiliza.
  y1(m,p)          Cantidad de drones mensajeros que se envian de m a p
  y2(m,p)          Cantidad de drones fotografos que se envian de m a p
  z                maximizacion ;
Binary Variable x;



Equations
Fun_Obj(m)               Funcion Objetivo
restriccion_demanda1(p)  Restriccion de demanda y1
restriccion_demanda2(p)  Restriccion de demanda y2
restriccion_oferta1(m)   Restriccion de oferta y1
restriccion_oferta2(m)   Restriccion de oferta y2
nodos_intermedios        Restriccion nodos intermedios
restriccion_altura       Restriccion de altura
;

Fun_Obj(m)                  ..      z =e= sum(p,(2*sum((i,j), x(i,j,m,p)*C(i,j)*(y1(m,p) + y2(m,p));
restriccion_demanda1(p)     ..      sum(m,y1(m,p)) =e= D1(p);
restriccion_demanda2(p)     ..      sum(m,y2(m,p)) =e= D2(p);
restriccion_oferta1(m)      ..      sum(p,y1(m,p)) =l= O1(m);
restriccion_oferta2(m)      ..      sum(p,y2(m,p)) =l= O2(m);
nodos_intermedios(m,p)      ..      sum((i,j), x(i,j,m,p)) - sum((i,j), x(j,i,m,p)) =e= 0;




Model Modelo1 /all/ ;


option mip=CPLEX
Solve Modelo1 using mip minimizing z;

Display x.l;
Display y1.l;
Display y2.l;
Display z.l;

