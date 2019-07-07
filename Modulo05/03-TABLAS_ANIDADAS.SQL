/*
TABLA ANIDADA

TYPE type_name IS TABLE OF
 { column_type 
   | variable%TYPE
   | table.column%TYPE} [NOT NULL]
   | table%ROWTYPE
 }

*/


-- EJEMPLO 1

DECLARE
	TYPE tabla_varchar2 IS TABLE OF VARCHAR2 (100);
	empleados tabla_varchar2 := tabla_varchar2 ();
BEGIN
	-- Tamaño Inicial
	DBMS_OUTPUT.PUT_LINE('Tamaño Inicial: ' || empleados.COUNT);
	-- Se añaden 4 elementos
	empleados.EXTEND (4);
	empleados (1) := 'Pepe';
	empleados (2) := 'Elena';
	empleados (3) := 'Carmen';
	empleados (4) := 'Juan';
	-- Se añade un elemento mas
	empleados.EXTEND;
	empleados (empleados.LAST) := 'Gustavo';
	-- Tamaño Final
	DBMS_OUTPUT.PUT_LINE('Tamaño Final: ' || empleados.COUNT);
	-- Mostrar lista
	FOR I IN 1 .. empleados.COUNT
	LOOP
		DBMS_OUTPUT.put_line ( empleados(I) );
	END LOOP;
END;
/



-- Ejemplo 2

DECLARE
	-- Definimos los tipo de datos
	TYPE TABLA_EMPLEADOS IS TABLE OF RECURSOS.EMPLEADO%ROWTYPE;
	-- Definiendo las variables
	V_EMPLEADOS TABLA_EMPLEADOS;
BEGIN

  -- LLENA LA TABLA ANIDADA
	V_EMPLEADOS := TABLA_EMPLEADOS();
	DBMS_OUTPUT.PUT_LINE('TAMAÑO INICIAL: ' || V_EMPLEADOS.COUNT);
	FOR REC IN (SELECT * FROM RECURSOS.EMPLEADO) LOOP
		V_EMPLEADOS.EXTEND;
		V_EMPLEADOS(V_EMPLEADOS.LAST) := REC;
	END LOOP;
  
  -- MUESTRA LA TABALA
	DBMS_OUTPUT.PUT_LINE('TAMAÑO FINAL: ' || V_EMPLEADOS.COUNT);
	FOR I IN V_EMPLEADOS.FIRST..V_EMPLEADOS.LAST LOOP
		DBMS_OUTPUT.PUT_LINE( I || '.- ' || V_EMPLEADOS(I).NOMBRE
      || ' ' || V_EMPLEADOS(I).APELLIDO);
	END LOOP;

END;
/






