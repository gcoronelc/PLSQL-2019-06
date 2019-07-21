/*******************************************************************************
   EXAMEN FINAL DE PL/SQL WORKSHOP - SISTEMAS UNI
   Base de Datos de una Tienda de Musica - Version 1.0
   Script: 04_BD_MUSIC_PROCESO_SIMPLE.sql
   Descripcion: Crea listas de Reproduccion Aleatorias de un genero
   Integrantes: 
	- Lopez Villanueva, Timoteo
	- Vega Blas, Robert Jaime
********************************************************************************/

select * from genero;

/*******************************************************************************
   Procedimiento
********************************************************************************/
CREATE OR REPLACE PROCEDURE PRC_PRO_GEN_PLAYLIST_ALEA
  (   i_id_genero        IN NUMBER  
    , i_numero_canciones IN NUMBER) 

IS
    l_nombre_genero VARCHAR2(120);
    l_nombre_lista VARCHAR2(120);
    l_id_lista  NUMBER(10);
BEGIN
  
  SELECT nombre INTO l_nombre_genero 
    FROM GENERO
   WHERE id_genero = i_id_genero;
  
   -- Crea un nueva lista de reproducci�n
   INSERT INTO LISTA_REPRODUCCION (
		  id_lista_reproduccion
        , nombre
    ) VALUES (
          (SELECT MAX(id_lista_reproduccion) + 1 FROM LISTA_REPRODUCCION)
        , 'MIX de ' || l_nombre_genero || '( ' || i_numero_canciones ||') '  
    ) RETURNING id_lista_reproduccion INTO l_id_lista;
   
   -- Selecciona n canciones de forma aleatoria 
   -- de un genero x e inserta en el nuevo PlayList
    INSERT INTO lista_reproduccion_cancion
    (id_lista_reproduccion, id_cancion )
    SELECT  l_id_lista, id_cancion
      FROM   (
        SELECT id_cancion
          FROM CANCION
         WHERE id_genero = i_id_genero  
      ORDER BY DBMS_RANDOM.VALUE)
     WHERE  rownum <= i_numero_canciones;
    COMMIT;

EXCEPTION
  WHEN OTHERS THEN  
      ROLLBACK;

END PRC_PRO_GEN_PLAYLIST_ALEA;
/

/*******************************************************************************
   Prueba del Procedimiento
********************************************************************************/
CALL PRC_PRO_GEN_PLAYLIST_ALEA (6, 10); 

select * from genero;

select * from genero
WHERE ID_GENERO = 3;

select * from lista_reproduccion;

wHERE id_lista_reproduccion = 19;

select l.*, c.nombre from lista_reproduccion_cancion l
left join cancion c on (l.id_cancion = c.id_cancion)
wHERE id_lista_reproduccion = 20;


