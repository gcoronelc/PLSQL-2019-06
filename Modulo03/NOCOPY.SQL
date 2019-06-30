

create or replace function scott.fn_doble
( p_num in number ) return number
is
  v_doble number;
begin
  -- Proceso
  v_doble := p_num * 2;
  -- Respuesta
  return v_doble;
end;
/



-- ===========================================================

create or replace procedure scott.pr_doble
( p_dato in number, p_doble out number )
is
begin
  p_doble := p_dato * 2;
  raise_application_error(-20000,'Perú Campeón, Error!!!!!!!');    
end;
/


DECLARE
  V_DATO NUMBER;
  V_DOBLE NUMBER;
BEGIN
  -- Dato
  V_DATO  := 80;
  V_DOBLE := 40;
  -- Proceso
  scott.PR_DOBLE( V_DATO, V_DOBLE );
  -- Reporte
  DBMS_OUTPUT.PUT_LINE('(1) DOBLE = ' || V_DOBLE);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('(2) DOBLE = ' || V_DOBLE);
END;
/


-- ===========================================================

create or replace procedure scott.pr_doble
( p_dato in number, p_doble out NOCOPY number )
is
begin
  p_doble := p_dato * 2;
  raise_application_error(-20000,'Perú Campeón, Error!!!!!!!');    
end;
/


DECLARE
  V_DATO NUMBER;
  V_DOBLE NUMBER;
BEGIN
  -- Dato
  V_DATO  := 80;
  V_DOBLE := 40;
  -- Proceso
  scott.PR_DOBLE( V_DATO, V_DOBLE );
  -- Reporte
  DBMS_OUTPUT.PUT_LINE('(1) DOBLE = ' || V_DOBLE);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('(2) DOBLE = ' || V_DOBLE);
END;
/







