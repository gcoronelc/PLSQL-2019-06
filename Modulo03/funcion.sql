
-- Ejemplo 01

create or replace function scott.fn_suma
( p_num1 in number, p_num2 number )
return number
is
  v_suma number;
begin
  -- Proceso
  v_suma := p_num1 + p_num2;
  -- Respuesta
  return v_suma;
end;
/


select scott.fn_suma( 56, 43 ) suma 
from dual;

select * from dual;


-- Ejercicio 01
/*
Desarrollar una función para encontrar el
importe de una venta.
Los datos son:
  - Precio
  - Cantidad
*/