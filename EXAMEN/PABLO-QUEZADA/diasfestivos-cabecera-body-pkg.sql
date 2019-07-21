
CREATE OR REPLACE PACKAGE toolspackage as 

 FUNCTION DIAS_LABORABLES (fecha_inicio IN DATE, fecha_fin IN DATE) RETURN NUMBER;

 
END toolspackage;
/



CREATE OR REPLACE PACKAGE BODY toolspackage as 
 
FUNCTION DIAS_LABORABLES (fecha_inicio IN DATE, fecha_fin IN DATE)
RETURN NUMBER IS
    nuDiasFeriados     NUMBER :=0;
    numero_dias NUMBER := 0;
    fecha_inicial DATE;
    fecha_final DATE;
    fecha_contar DATE;
BEGIN
    IF fecha_fin IS NULL THEN 
    fecha_final := SYSDATE;
    ELSE fecha_final := fecha_fin;
    END IF;
    IF fecha_inicio IS NULL THEN 
    fecha_inicial := SYSDATE;
    ELSE fecha_inicial := fecha_inicio;
    END IF;   

    IF fecha_final > fecha_inicial THEN    
        fecha_contar := fecha_inicial + 1;
        WHILE fecha_contar <= fecha_final LOOP
            IF TO_CHAR(fecha_contar,'D') NOT IN ('7','1')
            THEN numero_dias := numero_dias + 1;
            END IF;
            fecha_contar := fecha_contar + 1;
        END LOOP;

        SELECT COUNT(DF.DDESC_DIA)
        INTO nuDiasFeriados
        FROM DIAS_FESTIVOS DF
        WHERE DF.DDESC_DIA BETWEEN fecha_inicial AND fecha_final
        AND TO_CHAR(DF.DDESC_DIA,'D') NOT IN ('7','1');

        RETURN numero_dias - nuDiasFeriados;        
    ELSE
    	RETURN 0;
    END IF;
 END DIAS_LABORABLES;
  
END toolspackage; 



--FERIADO 25
--RS- 3 DIAS
select toolspackagE.DIAS_LABORABLES( '23-12-2019','27-12-2019') from dual; 






