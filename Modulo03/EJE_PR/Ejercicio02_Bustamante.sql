
create or replace procedure sp_importe_mensual
( p_importe_total in number, p_cuotas in number, p_importe_mensual out number)
is
begin
    --Proceso
    p_importe_mensual := p_importe_total / p_cuotas;

end;
/