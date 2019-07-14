

declare
  v_sueldo   number(12,2);
begin
  
  update recursos.empleado
  set sueldo = sueldo * 2
  where idempleado = 'E0001'
  returning sueldo into v_sueldo;
  
  dbms_output.put_line('sueldo: ' || v_sueldo);
  
end;
/

select * from RECURSOS.empleado;


