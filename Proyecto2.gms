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
Fun_Obj(m)                  Funcion Objetivo
nodos_origen             Nodos Origen
nodos_destino            Nodos Destino
nodos_intermedios        Restriccion nodos intermedios
;

Fun_Obj(m)                 ..      z =e= sum(p,(2*sum((i,j), x(i,j,m,p)*C(i,j)*(y1(m,p) + y2(m,p));






Model Modelo1 /all/ ;


option mip=CPLEX
Solve Modelo1 using mip minimizing z;

Display x.l;
Display y1.l;
Display y2.l;
Display z.l;

