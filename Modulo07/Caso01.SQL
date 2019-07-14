
declare 
  cursor c_demo is select * from scott.emp;
  r_emp scott.emp%ROWTYPE;
begin
  open c_demo;
  
  -- Registro 1
  fetch c_demo into r_emp;
  dbms_output.put_line('Fila: ' || c_demo%RowCount);
  dbms_output.put_line(r_emp.empno || ' - ' || r_emp.ename);
  
  -- Registro 2
  fetch c_demo into r_emp;
  dbms_output.put_line('Fila: ' || c_demo%RowCount);
  dbms_output.put_line(r_emp.empno || ' - ' || r_emp.ename);
  
  close c_demo;
end;
/

select * from scott.emp;

create or replace procedure scott.pr114 
is 
  cursor c_demo is select * from dept; 
  r dept%rowtype; 
begin 
  open c_demo; 
  fetch c_demo into r; 
  close c_demo; 
  dbms_output.put_line('deptno: ' || r.deptno); 
  dbms_output.put_line('dname:  ' || r.dname); 
  dbms_output.put_line('loc:    ' || r.loc); 
end; 
/


call scott.pr114();






