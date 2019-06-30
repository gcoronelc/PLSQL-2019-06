
create or replace procedure scott.sp_calcula_importe_mensual
(p_monto_prestado in number ,
 p_numero_meses in number ,
 p_interes_mensual in number,
 p_importe_mensual out number)
is
begin  
  -- Proceso
    p_importe_mensual := p_monto_prestado * ( p_interes_mensual / ((power(1 + p_interes_mensual, p_numero_meses ) ) - 1)) ;
  --p_importe_mensual := p_monto_prestado * p_numero_meses * p_interes_mensual;
end;
/

DECLARE
  P_NUM1 NUMBER;
  P_NUM2 NUMBER;
  P_NUM3 NUMBER;
  P_IMPORTE NUMBER;
BEGIN
  P_NUM1 := 10000;
  P_NUM2 := 12;
  P_NUM3 := 0.05;

  scott.sp_calcula_importe(
    p_monto_prestado  => P_NUM1,
    p_numero_meses  => P_NUM2,
    p_interes_mensual => P_NUM3,
    p_importe_mensual  => P_IMPORTE 
  );
  --Legacy output: 
   DBMS_OUTPUT.PUT_LINE('IMPORTE MENSUAL = ' || ROUND(P_IMPORTE, 4));

END;



