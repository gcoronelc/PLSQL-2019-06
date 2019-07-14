CREATE OR REPLACE PROCEDURE SCOTT.Promedio_y_Menor
(p_num1 in number, p_num2 in number, p_num3 in number, p_num4 in number,
v_menor out number, v_prom out number)

IS
  v_men1 number;
  v_men2 number;

BEGIN
  -- punto de partida
  if p_num1 < p_num2 then
    v_men1 := p_num1;
  else
    v_men1 := p_num2;
  end if;
  
  if p_num3 < p_num4 then
    v_men2 := p_num3;
  else
    v_men2 := p_num4;
  end if;
  
  if v_men1 > v_men2 then
    v_menor := v_men2;
  else
    v_menor := v_men1;
  end if;
  -- proceso
  v_prom := (p_num1 + p_num2 + p_num3 + p_num4 - v_menor)/3;
  
END;