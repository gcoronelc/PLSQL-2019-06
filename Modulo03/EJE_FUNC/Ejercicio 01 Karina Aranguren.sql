CREATE OR REPLACE FUNCTION 
SCOTT.FN_IMPORTE_VTA (p_precio in number, p_cantidad number)
return number
is
  vimporte number;
begin
  -- proceso
  vimporte := p_precio * p_cantidad;
  --respuesta
  return vimporte;
end;
/


