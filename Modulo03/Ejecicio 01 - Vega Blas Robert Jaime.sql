create or replace function scott.fn_importe_venta
(p_num1 in number, p_num2 number)
return number
is
v_importe number;
begin
  --proceso
  v_importe := p_num1*p_num2;
  --respuesta
  return v_importe;
end;