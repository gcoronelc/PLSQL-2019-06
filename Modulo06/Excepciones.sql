
declare
  v_dato number(3);
begin
  v_dato := 1234.56;
end;
/


create or replace procedure scott.FindEmp( p_cod Emp.EmpNo%Type ) 
is 
  v_salario Emp.Sal%Type; 
Begin 
  Select Sal Into v_salario 
    From scott.Emp 
    Where EmpNo = p_cod; 
  DBMS_Output.Put_Line( 'Salario: ' || v_salario ); 
Exception 
  When No_Data_Found Then 
    DBMS_Output.Put_Line( 'Código no existe.' ); 
End; 
/


call scott.FindEmp(1234);


create or replace procedure scott.FindEmp
( 
  p_cod  in  Emp.EmpNo%Type,
  p_rpta out varchar2
) 
is 
  v_salario Emp.Sal%Type; 
Begin 
  Select Sal Into v_salario 
    From scott.Emp 
    Where EmpNo = p_cod; 
  p_rpta := 'Salario: ' || v_salario ; 
Exception 
  When No_Data_Found Then 
    p_rpta := 'Código no existe.'; 
End; 
/

select * from scott.emp;

declare
  v_empno scott.emp.empno%type;
  v_rpta  varchar2(1000);
begin
  -- Dato
  v_empno := 7566;
  --v_empno := 8989;
  -- Proceso
  scott.FindEmp( v_empno, v_rpta );
  -- Reporte
  dbms_output.put_line('Rpta. :' || v_rpta);
end;
/


-- NUEVA VERSION

create or replace procedure scott.FindEmp
( 
  p_cod  in  Emp.EmpNo%Type,
  p_rpta out varchar2
) 
is 
  v_salario Emp.Sal%Type; 
Begin 
  Select Sal Into v_salario 
    From scott.Emp 
    Where EmpNo = p_cod; 
  p_rpta := 'Salario: ' || v_salario ; 
Exception 
  When No_Data_Found Then 
    RAISE_APPLICATION_ERROR( -20001, 'Código no existe' );
End; 
/

select * from scott.emp;

declare
  v_empno scott.emp.empno%type;
  v_rpta  varchar2(1000);
begin
  -- Dato
  -- v_empno := 7566;
  v_empno := 8989;
  -- Proceso
  scott.FindEmp( v_empno, v_rpta );
  -- Reporte
  dbms_output.put_line('Rpta. :' || v_rpta);
exception
  when others then
    dbms_output.put_line('ERROR : ' || sqlerrm);
end;
/






-- LA MEJOR VERSION

create or replace procedure scott.FindEmp2
( 
  p_cod     in  Emp.EmpNo%Type,
  p_rpta    out varchar2,
  p_estado  out nocopy number,
  p_mensaje out nocopy varchar2 
) 
is 
  v_salario Emp.Sal%Type; 
Begin 
  -- Valor de por defecto
  p_estado  := 1;
  p_mensaje := 'Proceso ejecutado correctamente';
  -- Proceso
  Select Sal Into v_salario 
    From scott.Emp 
    Where EmpNo = p_cod; 
  p_rpta := 'Salario: ' || v_salario ; 
Exception 
  When No_Data_Found Then 
    p_estado  := -1;
    p_mensaje := 'Código no existe.';
End; 
/

select * from scott.emp;

declare
  v_empno   scott.emp.empno%type;
  v_rpta    varchar2(1000);
  v_estado  number;
  v_mensaje varchar2(1000);
begin
  -- Dato
  v_empno := 7566;
  --v_empno := 8989;
  -- Proceso
  scott.FindEmp2( v_empno, v_rpta, v_estado, v_mensaje );
  -- Reporte
  if v_estado = 1 then
    dbms_output.put_line('Rpta.: ' || v_rpta);
  else
    dbms_output.put_line('Error: ' || v_mensaje);
  end if;
end;
/


