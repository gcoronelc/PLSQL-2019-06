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
