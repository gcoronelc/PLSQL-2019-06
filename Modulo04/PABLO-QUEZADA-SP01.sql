create or replace procedure scott.nota_promedio
(p_nota1 in number, p_nota2 in number, p_nota3 in number,p_nota4 in number,v_promedio out number,v_menor out number)
is
begin
  if p_nota1 > p_nota2 then
    v_promedio := (p_nota1+p_nota3+p_nota4)/3;
    v_menor:=p_nota2;
  end if;
  if p_nota1 > p_nota3 then
     v_promedio := (p_nota1+p_nota2+p_nota4)/3;
      v_menor:=p_nota3;
  end if;
  if p_nota1 > p_nota4 then
    v_promedio := (p_nota1+p_nota2+p_nota3)/3;
     v_menor:=p_nota4;
    else 
    v_promedio := (p_nota2+p_nota3+p_nota4)/3;
     v_menor:=p_nota1;
  end if;
end;
/