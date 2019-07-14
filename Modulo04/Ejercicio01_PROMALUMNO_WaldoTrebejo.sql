
create or replace 
procedure  PromedioAlumno
(p_nota1 in number, p_nota2 in number, p_nota3 in number, p_nota4 in number)
is
  v_Promedio number;
  v_NotaMenor number; 
begin
  --Comparación
  if p_nota1 < p_nota2 then
    v_NotaMenor := p_nota1;
  else
    v_NotaMenor := p_nota2;
  end if;
  if v_NotaMenor < p_nota3 then
    v_NotaMenor := v_NotaMenor;
  else 
    v_NotaMenor := p_nota3;
  end if;
  if v_NotaMenor > p_nota4 then
    v_NotaMenor := p_nota4;
  end if;
  
  --Calculo promedio
  
  v_Promedio := ((p_nota1 + p_nota2 + p_nota3 + p_nota4) - v_NotaMenor) / 3;
  
  -- Reporte
  DBMS_OUTPUT.PUT_LINE('v_Promedio = ' || v_Promedio);
  DBMS_OUTPUT.PUT_LINE('v_NotaMenor = ' || v_NotaMenor);
  
end;