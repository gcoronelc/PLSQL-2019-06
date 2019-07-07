-- Caso 1

create or replace function scott.egcc_mayor
(p_num1 in number, p_num2 in number, p_num3 in number)
return number
is
  v_mayor number := 0; -- El menor número pósible es cero
begin
  if v_mayor < p_num1 then
    v_mayor := p_num1;
  end if;
  if v_mayor < p_num2 then
    v_mayor := p_num2;
  end if;
  if v_mayor < p_num3 then
    v_mayor := p_num3;
  end if;
  return v_mayor;
end;

select scott.egcc_mayor(123,65,143) from dual;

select scott.egcc_mayor(-123,-65,-143) from dual;


-- Caso 2

create or replace function scott.egcc_mayor
(p_num1 in number, p_num2 in number, p_num3 in number)
return number
is
  v_mayor number; 
begin
  v_mayor := p_num1; -- Punto de partida
  if v_mayor < p_num2 then
    v_mayor := p_num2;
  end if;
  if v_mayor < p_num3 then
    v_mayor := p_num3;
  end if;
  return v_mayor;
end;


select scott.egcc_mayor(123,65,143) from dual;

select scott.egcc_mayor(-123,-65,-143) from dual;


-- Caso 3

create or replace function scott.egcc_mayor
(p_num1 in number, p_num2 in number, p_num3 in number)
return number
is
  v_mayor number; 
begin
  -- Punto de partida: Número mayor inicial
  if p_num1 > p_num2 then
    v_mayor := p_num1;
  else
    v_mayor := p_num2;
  end if;
  -- Proceso
  if v_mayor < p_num3 then
    v_mayor := p_num3;
  end if;
  -- Reporte
  return v_mayor;
end;


select scott.egcc_mayor(123,65,143) from dual;

select scott.egcc_mayor(-123,-65,-143) from dual;


create or replace function scott.egcc_clasifica_salario
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
  if v_salario <= 2500.0 then
    v_rpta := 'Salario Bajo';
  elsif v_salario <= 4000.0 then
    v_rpta := 'Salario Regular';
  else
    v_rpta := 'Salario Bueno';
  end if;
  -- Repuesta
  return v_rpta;
end;
/

select * from scott.emp;

select scott.egcc_clasifica_salario(7698) from dual;

select scott.egcc_clasifica_salario(7499) from dual;


-- Ejercicio IF
/*
Desarrollar un procedimiento que permita encontrar el promedio de un 
alumno de PL/SQL, se sabe que son 4 notas, y se promedian las 3 mejores.
Se necesita saber el promedio y la nota que no se promedia.
*/









