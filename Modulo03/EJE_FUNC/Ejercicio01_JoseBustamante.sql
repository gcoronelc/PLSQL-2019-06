create or replace function scott.fn_importe_venta
(p_precio in number, p_cantidad in number)
return number
is
 v_importe number;
begin
    --Proceso
    v_importe := p_precio * p_cantidad;
    --Respuesta
    return v_importe;
end;
/

select scott.fn_importe_venta(15,4) as importe 
from dual;