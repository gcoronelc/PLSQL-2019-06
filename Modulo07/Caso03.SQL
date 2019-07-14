
CREATE TABLE SCOTT.PLANILLAMES( 
  ANIO NUMBER(4), 
  MES NUMBER(2), 
  DEPTNO NUMBER(2), 
  EMPS NUMBER(2) NOT NULL, 
  PLANILLA NUMBER(10,2) NOT NULL, 
  CONSTRAINT PK_PLANILLAMES PRIMARY KEY(ANIO,MES, DEPTNO) 
);



create or replace procedure scott.pr116
(p_anio in number, p_mes in number) 
is 
  cursor c_dept is select deptno from scott.dept; 
  v_deptno scott.dept.deptno%type; 
  cont number; 
  v_emps number; 
  v_planilla number; 
begin 
  -- Verificar planilla
  select count(*) into cont 
  from scott.planillames 
  where anio = p_anio and mes = p_mes; 
  if (cont > 0) then 
    dbms_output.put_line('Ya esta procesado'); 
    return; 
  end if; 
  -- Proceso
  open c_dept; 
  fetch c_dept into v_deptno; 
  while c_dept%found loop 
    select count(*), sum(sal) into v_emps, v_planilla 
    from scott.emp 
    where deptno = v_deptno; 
    insert into scott.planillames 
    values(p_anio, p_mes, v_deptno, v_emps, nvl(v_planilla,0)); 
    fetch c_dept into v_deptno; 
  end loop; 
  close c_dept; 
  commit; 
  dbms_output.put_line('Proceso ok.'); 
end;  
/


call scott.pr116( 2019, 01 );


select * from scott.planillames;

SELECT * FROM EUREKA.cuenta;

-- Ejercicio 01
/*
Desarrollar un procedimiento que retorne los 
los movimientos de una cuenta.

De cada movimiento se necesita:
- nro. cuenta
- nro. movimiento
- Fecha
- Tipo de movimiento (nombre)
- moneda (nombre)
- importe 

*/


