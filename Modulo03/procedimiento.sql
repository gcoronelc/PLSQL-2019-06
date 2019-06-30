
-- Ejemplo 01

create or replace procedure scott.sp_suma(
  p_num1 in number,
  p_num2 in number,
  p_suma out number
) 
is
begin
  -- Proceso
  p_suma := p_num1 + p_num2;
end;
/

-- Prueba

DECLARE
  P_NUM1 NUMBER;
  P_NUM2 NUMBER;
  P_SUMA NUMBER;
BEGIN
  -- Datos
  P_NUM1 := 98;
  P_NUM2 := 43;
  -- Proceso
  scott.SP_SUMA(P_NUM1,P_NUM2,P_SUMA);
  -- Reporte
  DBMS_OUTPUT.PUT_LINE('P_SUMA = ' || P_SUMA);
END;


-- Ejercicio 1
/*
Procedimiento para calcular el importe de una
cuota de un prestamo bancario.
Todos los meses se debe pagar la misma cuota.
*/





