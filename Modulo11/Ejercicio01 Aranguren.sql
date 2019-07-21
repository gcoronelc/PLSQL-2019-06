CREATE OR REPLACE TRIGGER SCOTT.TR_LOG_EMP_SAL_K 
AFTER INSERT OR UPDATE ON SCOTT.EMP 
FOR EACH ROW 
BEGIN 

  -- Reto: Este insert solo se debe ejecutar cuando
  --       cambie el salario
  IF :OLD.SAL <> :NEW.SAL THEN
    INSERT INTO SCOTT.SAL_HISTORY(EMPNO, SALOLD, SALNEW, STARTDATE, SETUSER) 
    VALUES( :NEW.EMPNO, :OLD.SAL, :NEW.SAL, SYSDATE, USER ); 
  END IF;
  
END TR_LOG_EMP_SAL_K;

SELECT * FROM SCOTT.SAL_HISTORY;

INSERT INTO SCOTT.EMP( EMPNO, ENAME, SAL )
VALUES( 1111, ' GUSTAVO', 8888 );

UPDATE SCOTT.EMP SET SAL=9999 WHERE EMPNO = 9999;