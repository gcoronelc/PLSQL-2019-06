create or replace procedure scott.showEmp( cod emp.empno%type ) 
is 
  type reg is record ( 
    nombre emp.ename%type, 
    salario emp.sal%type,
    comision emp.comm%type
  ); 
  r reg;
  abc number;
begin 
  select ename, sal, comm into r
    from emp where empno = cod; 
  dbms_output.put_line( 'Nombre: ' || r.nombre ); 
  dbms_output.put_line( 'Salario: ' || r.salario ); 
  dbms_output.put_line( 'Comisión: ' || r.comision );
end;
/

call scott.showEmp(7698);

call scott.showEmp(7499);


select * from scott.emp;




create or replace procedure scott.showEmp2( cod dept.deptno%type ) 
is 
  r dept%rowtype; 
begin 
  select * into r 
    from dept where deptno = cod; 
  dbms_output.put_line('Codigo: ' || r.deptno); 
  dbms_output.put_line('Nombre: ' || r.dname); 
  dbms_output.put_line('Localización: ' || r.loc); 
end; 



call scott.showEmp2(20);
