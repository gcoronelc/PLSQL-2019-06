
create or replace function scott.egcc_numero
( p_num number ) return varchar2
is
  v_rpta varchar2(100);
begin
  -- Valor inicial
  v_rpta := null;
  -- Proceso
  case p_num 
    when 1 then 
      v_rpta := 'UNO';
    when 2 then 
      v_rpta := 'DOS';
    when 3 then 
      v_rpta := 'TRES';
    when 4 then 
      v_rpta := 'CUATRO';
    when 5 then 
      v_rpta := 'CINCO';
    else
      v_rpta := 'no se';
  end case;
  -- Reporte
  return v_rpta;
end;
/

select scott.egcc_numero( 8 ) from dual;


-- Evaluar Salario

create or replace function scott.egcc_clasifica_salario2
( p_empno scott.emp.empno%type )
return varchar2
is
  v_salario  scott.emp.sal%type;
  v_rpta     varchar2(100);
begin
  -- Obtener salario
  select sal into v_salario
  from scott.emp
  where empno = p_empno;
  -- Proceso
  case
  when v_salario <= 2500.0 then
    v_rpta := 'Salario Bajo';
  when v_salario <= 4000.0 then
    v_rpta := 'Salario Regular';
  else
    v_rpta := 'Salario Bueno';
  end case;
  -- Repuesta
  return v_rpta;
end;
/

select * from scott.emp;

select scott.egcc_clasifica_salario2(7698) from dual;

select scott.egcc_clasifica_salario2(7499) from dual;

select scott.egcc_clasifica_salario2(9898) from dual;



-- Evaluar Salario -- Solucion 1

create or replace function scott.egcc_clasifica_salario2
( p_empno scott.emp.empno%type )
return varchar2
is
  v_salario  scott.emp.sal%type;
  v_rpta     varchar2(100);
  v_conta    number(5);
begin
  -- Validar
  select count(1) into v_conta
  from scott.emp
  where empno = p_empno;
  if v_conta <> 1 then
    v_rpta := 'Código no existe';
    return v_rpta;
  end if;
  -- Obtener salario
  select sal into v_salario
  from scott.emp
  where empno = p_empno;
  -- Proceso
  case
  when v_salario <= 2500.0 then
    v_rpta := 'Salario Bajo';
  when v_salario <= 4000.0 then
    v_rpta := 'Salario Regular';
  else
    v_rpta := 'Salario Bueno';
  end case;
  -- Repuesta
  return v_rpta;
end;
/

select * from scott.emp;

select scott.egcc_clasifica_salario2(7698) from dual;

select scott.egcc_clasifica_salario2(7499) from dual;

select scott.egcc_clasifica_salario2(9898) from dual;



-- Evaluar Salario - Solucion 2

create or replace function scott.egcc_clasifica_salario2
( p_empno scott.emp.empno%type )
return varchar2
is
  v_salario  scott.emp.sal%type;
  v_rpta     varchar2(100);
begin
  -- Obtener salario
  select sal into v_salario
  from scott.emp
  where empno = p_empno;
  -- Proceso
  case
  when v_salario <= 2500.0 then
    v_rpta := 'Salario Bajo';
  when v_salario <= 4000.0 then
    v_rpta := 'Salario Regular';
  else
    v_rpta := 'Salario Bueno';
  end case;
  -- Repuesta
  return v_rpta;
exception
  when others then
    v_rpta := 'Código no existe';
    return v_rpta;
end;
/

select * from scott.emp;

select scott.egcc_clasifica_salario2(7698) from dual;

select scott.egcc_clasifica_salario2(7499) from dual;

select scott.egcc_clasifica_salario2(9898) from dual;





