CREATE OR REPLACE TRIGGER SCOTT.tr_test_emp 
AFTER INSERT OR DELETE OR UPDATE ON SCOTT.emp 
BEGIN 
  if inserting then 
    dbms_output.put_line( 'nuevo empleado se ha insertado' ); 
  Elsif updating then 
    dbms_output.put_line( 'un empleado se ha modificado' ); 
  Elsif deleting then 
    dbms_output.put_line( 'un empleado se ha eliminado' ); 
  end if; 
END tr_test_emp; 
/

SELECT * FROM SCOTT.EMP
WHERE EMPNO = 8888;

INSERT INTO SCOTT.EMP(EMPNO,ENAME,SAL)
VALUES(8888,'GUSTAVO',8978);

UPDATE SCOTT.EMP 
SET SAL = 9999
WHERE EMPNO = 8888;

DELETE FROM SCOTT.EMP 
WHERE EMPNO = 8888;


ALTER TRIGGER SCOTT.TR_TEST_EMP DISABLE;




