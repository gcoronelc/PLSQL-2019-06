
create or replace function scott.F_EMP_X_DEP
( V_DEPTNO NUMBER ) RETURN sys_refcursor
IS
  V_RETURNCURSOR sys_refcursor;
  V_SELECT VARCHAR(500);
BEGIN
  
  V_SELECT := 'SELECT * FROM SCOTT.EMP WHERE DEPTNO = ' || TO_CHAR(V_DEPTNO );
  
  OPEN V_RETURNCURSOR 
  FOR V_SELECT;
  
  RETURN V_RETURNCURSOR;
  
END;




declare
  v_cur SYS_REFCURSOR;
  r     scott.emp%rowtype;
begin
  v_cur := SCOTT.f_emp_x_dep(20);
  fetch v_cur into r;
  dbms_output.put_line( to_char(v_cur%rowcount) || ' ' || r.ename );
  close v_cur;
end;
/


DECLARE
  V_CUR SYS_REFCURSOr;
  R     SCOTT.EMP%ROWTYPE;
BEGIN
  v_cur := SCOTT.f_emp_x_dep(10);
  FETCH v_cur INTO R;
  WHILE v_cur%found LOOP
    dbms_output.put_line( to_char(v_cur%rowcount) || ' ' || R.ename );
    FETCH v_cur INTO R;
  END LOOP;
  CLOSE v_cur;
END;
/









