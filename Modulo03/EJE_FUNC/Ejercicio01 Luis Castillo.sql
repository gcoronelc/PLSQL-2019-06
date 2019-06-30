--ejercicio 01
/*Desarrollar una funcion para encontrae el 
importe de una venta
los datos son
- precio
- cantidad
*/

create or replace function scott.Precio( p_precio number, p_cantidad number ) return number 
is 
 v_ImporteVenta number; 
begin 
 --proceso
 v_ImporteVenta:= p_precio * p_cantidad;
 --respuesta
 return v_ImporteVenta; 
end;
/

select scott.Precio(3,2) suma from dual;