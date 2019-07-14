
create global temporary table test ( 
   id number primary key, 
   dato varchar2(30) 
) on commit preserve rows;



select * from test;

insert into test values( 1, 'Gustavo' );

commit;

select * from test;


/*
Ejercicio

Hacer una tabla temporal para gestionar el reporte de
cuentas y saldo por sucursal.

La estructura de la tabla es:

1.- Sucursal
2.- Cuenta
3.- moneda
4.- Ingreso (Importe total)
5.- Salida (Importe total)
6.- Saldo1 (Ingreso - Salida)
7.- Saldo2 (de la tabla cuenta)

Luego hacer un procedimiento que llene esta tabla.
*/





