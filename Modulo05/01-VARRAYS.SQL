
-- Ejemplo 01

DECLARE
	-- Definimos los tipos de datos
	TYPE AlumnosArray IS VARRAY(15) OF VARCHAR2(100);
	TYPE NotasArray IS VARRAY(15) OF NUMBER(4);
	-- Definiendo las variables
	alumnos AlumnosArray;
	notas   NotasArray;
BEGIN
	-- Creando los arreglos
	alumnos := AlumnosArray('Gustavo','Lucero','Ricardo','Andrea','Laura','Susana');
	notas := NotasArray(20,18,16,10,15,20);
	-- Mostrando los arreglos
  dbms_output.PUT_LINE( 'Limite: ' || alumnos.LIMIT );
  dbms_output.PUT_LINE( 'Current: ' || alumnos.COUNT );
	FOR i IN 1 .. alumnos.count LOOP
		dbms_output.PUT_LINE( alumnos(i) || ' - ' || notas(i) );
	END LOOP;
END;
/



-- Ejemplo 02

DECLARE
	-- Definimos los tipos de datos
	TYPE AlumnosArray IS VARRAY(20) OF VARCHAR2(100);
	TYPE NotasArray IS VARRAY(20) OF NUMBER(4);
	-- Definiendo las variables
	alumnos AlumnosArray;
	notas   NotasArray;
BEGIN
	-- Creando los arreglos
	alumnos := AlumnosArray();
  notas := NotasArray();
	-- Mostrando los arreglos
  dbms_output.PUT_LINE( '-----------CASO 1---------------' );  
  dbms_output.PUT_LINE( 'Limite: ' || alumnos.LIMIT );
  dbms_output.PUT_LINE( 'Tamaño: ' || alumnos.COUNT );
	FOR i IN 1 .. alumnos.count LOOP
		dbms_output.PUT_LINE( alumnos(i) || ' - ' || notas(i) );
	END LOOP;
	-- Un nuevo elemento
  dbms_output.PUT_LINE( '-----------CASO 2---------------' );
	alumnos.EXTEND;
	alumnos(alumnos.LAST) := 'PATRICIA';
	notas.EXTEND;
	notas(notas.LAST) := 19;
  dbms_output.PUT_LINE( 'Limite: ' || alumnos.LIMIT );
  dbms_output.PUT_LINE( 'Tamaño: ' || alumnos.COUNT );
	FOR i IN 1 .. alumnos.count LOOP
		dbms_output.PUT_LINE( alumnos(i) || ' - ' || notas(i) );
	END LOOP;  
	-- Un nuevo elemento
  dbms_output.PUT_LINE( '---------CASO 3-----------------' );
	alumnos.EXTEND;
	alumnos(alumnos.LAST) := 'GUSTAVO';
	notas.EXTEND;
	notas(notas.LAST) := 20;
  dbms_output.PUT_LINE( 'Limite: ' || alumnos.LIMIT );
  dbms_output.PUT_LINE( 'Tamaño: ' || alumnos.COUNT );  
  FOR i IN 1 .. alumnos.count LOOP
    dbms_output.PUT_LINE( alumnos(i) || ' - ' || notas(i) );
  END LOOP;	
END;
/


-- Ejemplo 03

DECLARE
	-- Definimos los tipos de datos
	TYPE VARRAY_EMPLEADOS IS VARRAY(5000) OF RECURSOS.EMPLEADO%ROWTYPE;
	-- Definiendo las variables
	V_EMPLEADOS VARRAY_EMPLEADOS;
	V_CONT NUMBER(8);
BEGIN
	V_EMPLEADOS := VARRAY_EMPLEADOS();
	DBMS_OUTPUT.PUT_LINE('TAMAÑO INICIAL: ' || V_EMPLEADOS.COUNT);
  -- Carga el arreglo con empleados
	FOR REC IN (SELECT * FROM RECURSOS.EMPLEADO) LOOP
		V_EMPLEADOS.EXTEND;
		V_CONT := V_EMPLEADOS.LAST;
		V_EMPLEADOS(V_CONT) := REC;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('TAMAÑO FINAL: ' || V_EMPLEADOS.COUNT);
  -- Muestra el arreglo de empleados
	FOR I IN V_EMPLEADOS.FIRST..V_EMPLEADOS.LAST LOOP
		DBMS_OUTPUT.PUT_LINE( I || '.- ' || V_EMPLEADOS(I).NOMBRE);
	END LOOP;
END;
/


