/*******************************************************************************
   EXAMEN FINAL DE PL/SQL WORKSHOP - SISTEMAS UNI
   Base de Datos de una Tienda de Musica - Version 1.0
   Script: 05_BD_MUSIC_RESUMEN_DATOS.sql
   Descripcion: Consultas resumen, temporales y mediante cursor
   Integrantes: 
	- Lopez Villanueva, Timoteo
	- Vega Blas, Robert Jaime
********************************************************************************/

-- Canciones compradas por un cliente
   SELECT   fac_det.id_cancion
          , SUM(fac_det.precio_unidad * fac_det.cantidad)
          , can.nombre, count(*)
     FROM FACTURA_DETALLE fac_det
LEFT JOIN FACTURA fac ON (fac_det.id_factura = fac.id_factura)
LEFT JOIN CANCION can ON (fac_det.id_cancion = can.id_cancion)
    WHERE fac.id_cliente = '31'
GROUP BY  fac_det.id_cancion,  can.nombre
ORDER BY COUNT(*) DESC;

-- Artistas favoritos por cliente  
   SELECT   fac_det.id_cancion
          , SUM(fac_det.precio_unidad * fac_det.cantidad)
          , can.nombre
          , count(*)
     FROM FACTURA_DETALLE fac_det
LEFT JOIN FACTURA fac ON (fac_det.id_factura = fac.id_factura)
LEFT JOIN CANCION can ON (fac_det.id_cancion = can.id_cancion)
LEFT JOIN ALBUM alb   ON (can.id_album = alb.id_album)
LEFT JOIN ARTISTA art ON (alb.id_artista = art.id_artista)
    WHERE fac.id_cliente = '31'
 GROUP BY fac_det.id_cancion,  can.nombre
 ORDER BY COUNT(*) DESC;
 
-- Numero de Canciones compradas por un clinete 
 SELECT     cli.id_cliente
          , cli.nombres
          , count(*)
     FROM CLIENTE cli
LEFT JOIN FACTURA fac ON (cli.id_cliente = fac.id_cliente)         
LEFT JOIN FACTURA_DETALLE fac_det ON (fac_det.id_factura = fac.id_factura)
 GROUP BY cli.id_cliente, cli.nombres
 ORDER BY COUNT(*) DESC;

/*********************************
TEMPORALES
************************************/
--drop table GBL_INDICADORES;
-- Total y Promedio de Ventas
CREATE GLOBAL TEMPORARY TABLE GBL_INDICADORES 
ON COMMIT PRESERVE ROWS AS
SELECT extract(year from f.fecha_factura) AS anio
    , extract(month from f.fecha_factura) AS mes
    , round(SUM(f.total),2) AS suma
    , round(AVG(f.total),2) AS promedio
 FROM FACTURA f
GROUP BY 
    extract(year from f.fecha_factura)
  , extract(month from f.fecha_factura);
--ON COMMIT PRESERVE ROWS; 

select * from GBL_INDICADORES;


/*********************************
CONSULTA CON CURSOR
************************************/

CREATE OR REPLACE PROCEDURE PRC_CON_FACTURA
  (      i_id_factura             IN       NUMBER
      ,  oc_factura_detalle       OUT  NOCOPY sys_refcursor
  ) 
IS
BEGIN
  
  SELECT   fac.id_factura
           , fac.fecha_factura
           , cli.nombres || ' '|| cli.apellidos AS cliente
           , fac.total
           , facd.id_factura_detalle
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
   
EXCEPTION
  WHEN OTHERS THEN  
      ROLLBACK;
      raise_application_error(-20001,'Error: ' || sqlerrm);

END PRC_CON_FACTURA;
/



   











