
-- Ejercicio 01
/* Desarrollar una función para encontrar el importe de una venta.
Los datos son_: precio, cantidad */

create or replace function scott.fn_calcula_importe
(p_precio in number , p_cantidad number)
return number
is
  v_importe number;
begin
  -- Proceso
  v_importe := p_precio*p_cantidad;
  -- Respuesta
  return v_importe;
end;
/

select scott.fn_calcula_importe (2.55, 4) suma
from dual;
