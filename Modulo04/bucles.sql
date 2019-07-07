-- FACTORIAL CON LOOP

create or replace function scott.egcc_factorial
( p_num in number ) return number
is
  v_fact number;
  v_cont number;
begin
  -- Valores iniciales
  v_cont := p_num;
  v_fact := 1;
  -- Validar
  if( v_Cont < 0 ) then
    v_fact := -1;
    return v_fact;
  end if;
  if( v_Cont = 0 ) then
    v_fact := 1;
    return v_fact;
  end if;
  -- Proceso
  loop
    v_fact := v_fact * v_cont;
    v_cont := v_cont - 1;
    exit when (v_cont = 0);
  end loop;
  -- Reporte
  return v_fact;
end;
/


select scott.egcc_factorial(0) from dual;

select scott.egcc_factorial(-5) from dual;




-- FACTORIAL CON WHILE

create or replace function scott.egcc_factorial
( p_num in number ) return number
is
  v_fact number;
  v_cont number;
begin
  -- Valores iniciales
  v_cont := p_num;
  v_fact := 1;
  -- Validar
  if( v_Cont < 0 ) then
    v_fact := -1;
    return v_fact;
  end if;
  -- Proceso
  WHILE (V_CONT > 1) loop
    v_fact := v_fact * v_cont;
    v_cont := v_cont - 1;
  end loop;
  -- Reporte
  return v_fact;
end;
/


select scott.egcc_factorial(0) from dual;

select scott.egcc_factorial(-5) from dual;



-- FACTORIAL CON FOR

create or replace function scott.egcc_factorial
( p_num in number ) return number
is
  v_fact number;
begin
  -- Valores iniciales
  v_fact := 1;
  -- Validar
  if( p_num < 0 ) then
    v_fact := -1;
    return v_fact;
  end if;
  -- Proceso
  FOR N IN 2 .. P_NUM loop
    v_fact := v_fact * N;
  end loop;
  -- Reporte
  return v_fact;
end;
/


select scott.egcc_factorial(0) from dual;

select scott.egcc_factorial(-5) from dual;

-- ejercicio de bucles
/*
Desarrollar una función o procedimiento que convierta un
número entero a letras:

  5   Cinco
  11  Once
  .. . 
  
*/



