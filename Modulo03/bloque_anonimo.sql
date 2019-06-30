-- Previas
/*
En consola se debe habilitar las salidas DBMS.

set serveroutput on

*/


-- Ejemplo 01

begin
  dbms_output.put_line('ORALCE es lo maximo!!!');
end;
/


-- Ejemplo 02

declare
  v_a number;
  v_b number;
  v_suma number;
begin
  -- Datos
  v_a := 56;
  v_b := 76;
  -- Proceso
  v_suma := v_a + v_b;
  -- Reporte
  dbms_output.put_line('A: ' || v_a);
  dbms_output.put_line('B: ' || v_b);
  dbms_output.put_line('Suma: ' || v_suma);
end;
/





