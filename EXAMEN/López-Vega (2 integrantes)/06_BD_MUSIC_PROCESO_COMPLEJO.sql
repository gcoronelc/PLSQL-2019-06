/*******************************************************************************
   EXAMEN FINAL DE PL/SQL WORKSHOP - SISTEMAS UNI
   Base de Datos de una Tienda de Musica - Version 1.0
   Script: 06_BD_MUSIC_PROCESO_COMPLEJO.sql
   Descripcion: Crea factura y factura detalle al comprar una canción, lista de canciones, 
        una lista de reproducción o un album completo. 
        Retorna una consulta con el detalle de la factura generada.
   Integrantes: 
	- Lopez Villanueva, Timoteo
	- Vega Blas, Robert Jaime
********************************************************************************/

/*******************************************************************************
   Procedimiento para la cabecera de la factura
********************************************************************************/
CREATE OR REPLACE PROCEDURE PRC_PRO_GEN_FACTURA
  (     i_id_cliente           IN      NUMBER
      , o_id_factura               OUT NUMBER
  ) 
IS
    l_cliente CLIENTE%ROWTYPE;
    l_nombre_lista VARCHAR2(120);
    l_id_lista  NUMBER(10);
    ex_cliente_no_encontrado EXCEPTION;
BEGIN
  
  -- Valida cliente
  SELECT * INTO l_cliente 
    FROM CLIENTE
   WHERE id_cliente = i_id_cliente;
  
  IF l_cliente.id_cliente IS NULL THEN
     RAISE ex_cliente_no_encontrado;
  END IF; 
      
   -- Crea un nueva factura
   INSERT INTO FACTURA (
		  id_factura
        , id_cliente
        , fecha_factura
        , direccion_envio
        , ciudad_envio
        , estado_envio
        , pais_envio
        , codigo_postal_envio
        , total
    ) VALUES (
          (SELECT MAX(id_factura) + 1 FROM FACTURA)
        , l_cliente.id_cliente
        , SYSDATE
        , l_cliente.direccion
        , l_cliente.ciudad
        , l_cliente.estado
        , l_cliente.pais
        , l_cliente.codigo_postal
        , 0
    ) RETURNING id_factura INTO o_id_factura;

   
EXCEPTION
  WHEN ex_cliente_no_encontrado THEN
     ROLLBACK;
     raise_application_error(-20001,'No existe el cliente');
  WHEN OTHERS THEN  
      ROLLBACK;
      raise_application_error(-20001,'Error: ' || sqlerrm);

END PRC_PRO_GEN_FACTURA;
/

/*******************************************************************************
   Prueba del Procedimiento PRC_PRO_GEN_FACTURA
********************************************************************************/
select * from cliente;

select * from factura
where id_cliente = 14;

SET SERVEROUTPUT ON;
DECLARE
    l_id_factura NUMBER;
BEGIN
    PRC_PRO_GEN_FACTURA(&id_cliente, l_id_factura); 
    DBMS_OUTPUT.PUT_LINE('Factura Id: '||l_id_factura);
END;
/

select * from factura
where id_cliente = 3;


/*******************************************************************************
   Procedimiento para el detalle de la factura
   Canci�n, una lista de reproducci�n o un album completo. 
********************************************************************************/
CREATE OR REPLACE PROCEDURE PRC_PRO_GEN_FACTURA_DETALLE
  (      i_id_factura             IN       NUMBER
      ,  i_modo                   IN       VARCHAR
      ,  i_tipo                   IN       VARCHAR  
      ,  i_id_cancion             IN       NUMBER   
      ,  i_id_lista_reproduccion  IN       NUMBER
      ,  i_id_album               IN       NUMBER
      ,  i_cantidad               IN       NUMBER
      ,  oc_factura_detalle           OUT  NOCOPY sys_refcursor
  ) 
IS
    l_cancion CANCION%ROWTYPE;
    l_lista_reproduccion LISTA_REPRODUCCION%ROWTYPE;
    l_album LISTA_REPRODUCCION%ROWTYPE;
    ex_cancion_no_encontrada EXCEPTION;
BEGIN
  
 IF (i_tipo = 'CANCION') THEN
      -- Valida cancion
      SELECT * INTO l_cancion 
        FROM CANCION
       WHERE id_cancion = i_id_cancion;
      
      IF l_cancion.id_cancion IS NULL THEN
         RAISE ex_cancion_no_encontrada;
      END IF; 
      
      -- Inserta una factura detalle
      INSERT INTO FACTURA_DETALLE (
		  id_factura_detalle
        , id_factura
        , id_cancion
        , precio_unidad
        , cantidad
    ) VALUES (
          (SELECT MAX(id_factura_detalle) + 1 FROM FACTURA_DETALLE)
        , i_id_factura
        , l_cancion.id_cancion
        , l_cancion.precio_unidad
        , i_cantidad
    );
    
    -- Actualiza la tabla padre
    UPDATE FACTURA
    SET total = total + (i_cantidad * l_cancion.precio_unidad)
    WHERE id_factura = i_id_factura; 
  
 END IF;    
  
  OPEN oc_factura_detalle FOR
    SELECT   facd.id_factura_detalle
           , can.nombre
           , facd.precio_unidad
           , facd.cantidad
           , ROUND(facd.cantidad * facd.precio_unidad, 2) subtotal
      FROM FACTURA_DETALLE facd
 LEFT JOIN FACTURA fac ON (facd.id_factura = fac.id_factura)
 LEFT JOIN CLIENTE cli ON (fac.id_cliente = cli.id_cliente)
 LEFT JOIN CANCION can ON (facd.id_cancion = can.id_cancion)
     WHERE facd.id_factura = i_id_factura
  ORDER BY facd.id_factura_detalle ASC;
  
  commit;
  
EXCEPTION
  WHEN ex_cancion_no_encontrada THEN
     ROLLBACK;
     raise_application_error(-20001,'No existe la canci�n');
  WHEN OTHERS THEN  
      ROLLBACK;
      raise_application_error(-20001,'Error: ' || sqlerrm);

END PRC_PRO_GEN_FACTURA_DETALLE;
/

/*******************************************************************************
   Prueba del Procedimiento PRC_PRO_GEN_FACTURA
********************************************************************************/

select * from cancion;

SET SERVEROUTPUT ON;
DECLARE
    c_detalle_factura sys_refcursor;
    l_id_facturax     NUMBER;
    l_id_factura        NUMBER;
    l_fecha_factura     DATE;
    l_cliente           VARCHAR2(100);
    l_total             NUMBER(10,2);
    l_id_factura_detalle NUMBER;
    
    l_nombre VARCHAR2(200);
    l_precio_unidad NUMBER(10,2);
    l_cantidad NUMBER;
    l_subtotal NUMBER(10,2);
BEGIN
     l_id_facturax := &id_factura;
     PRC_PRO_GEN_FACTURA_DETALLE(l_id_facturax, null, 'CANCION', &id_cancion , null, null, 1,  c_detalle_factura); 
      
     SELECT      fac.id_factura      
               , fac.fecha_factura   
               , cli.nombres || ' '|| cli.apellidos 
               , fac.total                         
               into l_id_factura, l_fecha_factura, l_cliente, l_total
          FROM FACTURA fac
     LEFT JOIN CLIENTE cli ON (fac.id_cliente = cli.id_cliente)
         WHERE fac.id_factura = l_id_facturax;
     
    dbms_Output.Put_Line('Id: '|| l_id_factura);
    dbms_Output.Put_Line('Fecha: '|| l_fecha_factura);
    dbms_Output.Put_Line('Cliente:  '|| l_cliente);
    dbms_Output.Put_Line('Total: ' || l_total);
    dbms_Output.Put_Line('DETALLES FACTURA');

    dbms_Output.Put_Line(RPAD('Item  ',15)||RPAD('Nombre    ', 20)||RPAD('Precio      ',10)||RPAD('Cantidad      ', 12)||RPAD('Subtotal      ', 10));
    loop
        FETCH c_detalle_factura INTO l_id_factura_detalle, l_nombre, l_precio_unidad, l_cantidad, l_subtotal ;
        EXIT WHEN c_detalle_factura%NOTFOUND;
        dbms_Output.Put_Line(RPAD(l_id_factura_detalle,15) ||RPAD(l_nombre, 20)||RPAD(l_precio_unidad,10)||RPAD(l_cantidad,12)||l_subtotal );
    end loop;
END;
/


-- Consultitas
select * from factura where id_factura = 414;

select * from factura_detalle where id_factura = 414;

   SELECT   facd.id_factura_detalle
           , can.nombre
           , facd.precio_unidad
           , facd.cantidad
           , ROUND(facd.cantidad * facd.precio_unidad, 2) subtotal
      FROM FACTURA_DETALLE facd
 LEFT JOIN FACTURA fac ON (facd.id_factura = fac.id_factura)
 LEFT JOIN CLIENTE cli ON (fac.id_cliente = cli.id_cliente)
 LEFT JOIN CANCION can ON (facd.id_cancion = can.id_cancion)
     WHERE facd.id_factura = 414
  ORDER BY facd.id_factura_detalle ASC;
