

create or replace procedure scott.pr117 
is 
  cursor c_dept is select * from scott.dept; 
  emps number; 
  planilla number; 
  cad varchar2(100); 
begin 

  for r in c_dept loop
  
    select count(*), sum(nvl(sal,0)) into emps, planilla 
    from scott.emp where deptno = r.deptno; 
      
    cad := r.deptno || ' - ' || emps || ' - ' || nvl(planilla,0); 
    dbms_output.put_line(cad); 
    
  end loop; 
  
end;
/


call scott.pr117();




-- Ejercicio 02
/*
Desarrollar un procedimiento que determine el empleado 
con mayor sueldo por departamento. 
*/




create or replace procedure scott.pr118 
is 
  prom number; 
begin 

  for r in (select deptno from scott.dept) loop 
  
    select avg(nvl(sal,0)) into prom 
    from scott.emp where deptno = r.deptno;
    
    dbms_output.put_line(r.deptno || ' - ' 
    || to_char(nvl(prom,0),'999,990.00')); 
    
  end loop;
  
end; 
/


call scott.pr118 ();


begin
  update scott.emp
  set sal = sal * 1.20;
  dbms_output.put_line(SQL%Rowcount);
end;


