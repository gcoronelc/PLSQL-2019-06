
/*******************************************************************************
   EXAMEN FINAL DE PL/SQL WORKSHOP - SISTEMAS UNI
   Base de Datos de una Tienda de Música - Version 1.0
   Script: 03_BD_MUSIC_PAQUETE_CRUD.sql
   Descripción: Implementa las operaciones mantenimiento de tablas de BD
   Integrantes: 
	- López Villanueva, Timoteo
	- Vega Blas, Robert Jaime
********************************************************************************/

  
/*******************************************************************************
   Define el paquete.
********************************************************************************/

CREATE OR REPLACE PACKAGE PKG_MANTENIMIENTOS AS 

 PROCEDURE PRC_MAN_EMPLEADO(i_operacion  IN  VARCHAR2       , i_empleado IN  EMPLEADO%ROWTYPE, o_cursor OUT NOCOPY SYS_REFCURSOR);
 PROCEDURE PRC_MAN_CLIENTE(i_operacion   IN  VARCHAR2       , i_cliente  IN  CLIENTE%ROWTYPE, o_cursor  OUT NOCOPY SYS_REFCURSOR); 
 PROCEDURE PRC_MAN_CANCION(i_operacion   IN  VARCHAR2       , i_cancion  IN  CANCION%ROWTYPE, o_cursor  OUT NOCOPY SYS_REFCURSOR);

END PKG_MANTENIMIENTOS;


create or replace PACKAGE BODY PKG_MANTENIMIENTOS AS 

/*******************************************************************************
   MANTENIMIENTO DE EMPLEADOS
********************************************************************************/ 
 PROCEDURE PRC_MAN_EMPLEADO(    
          i_operacion                  IN  VARCHAR2
        , i_empleado                   IN  EMPLEADO%ROWTYPE
        , o_cursor                     OUT NOCOPY SYS_REFCURSOR
    ) IS
 
 BEGIN
  CASE i_operacion
      WHEN 'INSERT'
        THEN
          INSERT INTO EMPLEADO      ( id_empleado
                                    , apellidos
                                    , nombres
                                    , titulo
                                    , cumpleanios
                                    , fecha_contratacion
                                    , direccion
                                    , ciudad
                                    , estado
                                    , pais
                                    , codigo_postal
                                    , telefono
                                    , fax
                                    , correo
                                    )
                              VALUES ((SELECT MAX(id_empleado) + 1 FROM EMPLEADO)
                                    , i_empleado.apellidos
                                    , i_empleado.nombres
                                    , i_empleado.titulo
                                    , i_empleado.cumpleanios
                                    , i_empleado.fecha_contratacion
                                    , i_empleado.direccion
                                    , i_empleado.ciudad
                                    , i_empleado.estado
                                    , i_empleado.pais
                                    , i_empleado.codigo_postal
                                    , i_empleado.telefono
                                    , i_empleado.fax
                                    , i_empleado.correo
                                    );

      WHEN 'UPDATE'
        THEN
          UPDATE EMPLEADO 
          SET    apellidos              = i_empleado.apellidos
                , nombres               = i_empleado.nombres
                , titulo                = i_empleado.titulo
                , cumpleanios           = i_empleado.cumpleanios
                , fecha_contratacion    = i_empleado.fecha_contratacion
                , direccion             = i_empleado.direccion
                , ciudad                = i_empleado.ciudad
                , estado                = i_empleado.estado
                , pais                  = i_empleado.pais
                , codigo_postal         = i_empleado.codigo_postal
                , telefono              = i_empleado.telefono
                , fax                   = i_empleado.fax
                , correo                = i_empleado.correo
          WHERE id_empleado             = i_empleado.id_empleado; 

      WHEN 'DELETE' 
        THEN
          DELETE FROM EMPLEADO
          WHERE id_empleado  = i_empleado.id_empleado;

      WHEN 'SELECT'
        THEN 
          OPEN o_cursor FOR SELECT                id_empleado
                                                , apellidos
                                                , nombres
                                                , titulo
                                                , cumpleanios
                                                , fecha_contratacion
                                                , direccion
                                                , ciudad
                                                , estado
                                                , pais
                                                , codigo_postal
                                                , telefono
                                                , fax
                                                , correo
                            FROM EMPLEADO;

      END CASE;        

 END PRC_MAN_EMPLEADO;


/*******************************************************************************
   MANTENIMIENTO DE CLIENTES
********************************************************************************/ 
 PROCEDURE PRC_MAN_CLIENTE(    
         i_operacion                  IN  VARCHAR2
        ,i_cliente                    IN  CLIENTE%ROWTYPE
        ,o_cursor                     OUT NOCOPY SYS_REFCURSOR
    )
   IS

 BEGIN
  CASE i_operacion
      WHEN 'INSERT'
        THEN
          INSERT INTO CLIENTE       (   id_cliente 
									  , nombres 
									  , apellidos 
									  , empresa 
									  , direccion 
									  , ciudad 
									  , estado 
									  , pais 
									  , codigo_postal 
									  , telefono 
									  , fax 
									  , correo 
									  , id_empleado_soporte 
                                    )
                              VALUES ((SELECT MAX(id_cliente) + 1 FROM CLIENTE)
                                    , i_cliente.nombres
                                    , i_cliente.apellidos
                                    , i_cliente.empresa
                                    , i_cliente.direccion
                                    , i_cliente.ciudad
                                    , i_cliente.estado
                                    , i_cliente.pais
                                    , i_cliente.codigo_postal
                                    , i_cliente.telefono
                                    , i_cliente.fax
                                    , i_cliente.correo
                                    , i_cliente.id_empleado_soporte
                                    );

      WHEN 'UPDATE'
        THEN
          UPDATE CLIENTE 
          SET    nombres               = i_cliente.nombres
			   , apellidos 			   = i_cliente.apellidos
			   , empresa               = i_cliente.empresa
			   , direccion             = i_cliente.direccion
			   , ciudad                = i_cliente.ciudad
			   , estado                = i_cliente.estado
			   , pais                  = i_cliente.pais
			   , codigo_postal         = i_cliente.codigo_postal
			   , telefono              = i_cliente.telefono
			   , fax                   = i_cliente.fax
			   , correo                = i_cliente.correo
			   , id_empleado_soporte   = i_cliente.id_empleado_soporte
          WHERE  id_cliente            = i_cliente.id_cliente; 

      WHEN 'DELETE' 
        THEN
          DELETE FROM CLIENTE
          WHERE id_cliente  = i_cliente.id_cliente;

      WHEN 'SELECT'
        THEN 
          OPEN o_cursor FOR SELECT                id_cliente 
												, nombres 
												, apellidos 
												, empresa 
												, direccion 
												, ciudad 
												, estado 
												, pais 
												, codigo_postal 
												, telefono 
												, fax 
												, correo 
												, id_empleado_soporte 
                            FROM CLIENTE;
      END CASE;        

 END PRC_MAN_CLIENTE;

/*******************************************************************************
   MANTENIMIENTO DE CANCIONES
********************************************************************************/ 
 PROCEDURE PRC_MAN_CANCION(    
         i_operacion                  IN  VARCHAR2
        ,i_cancion                    IN  CANCION%ROWTYPE
        ,o_cursor                     OUT NOCOPY SYS_REFCURSOR
    )
   IS

 BEGIN
  CASE i_operacion
      WHEN 'INSERT'
        THEN
          INSERT INTO CANCION       (     id_cancion 
										, nombre 
										, id_album 
										, id_formato 
										, id_genero 
										, compositor 
										, duracion 
										, tamanio_bytes 
										, precio_unidad  )
               VALUES ((SELECT MAX(id_cliente) + 1 FROM CANCION)
										, i_cancion.nombre
										, i_cancion.id_album
										, i_cancion.id_formato
										, i_cancion.id_genero
										, i_cancion.compositor
										, i_cancion.duracion
										, i_cancion.tamanio_bytes
										, i_cancion.precio_unidad
                                    );

      WHEN 'UPDATE'
        THEN
          UPDATE CANCION 
          SET    nombre                = i_cancion.nombre
			   , id_album 			   = i_cancion.id_album
			   , id_formato            = i_cancion.id_formato
			   , id_genero             = i_cancion.id_genero
			   , compositor            = i_cancion.compositor
			   , duracion              = i_cancion.duracion
			   , tamanio_bytes         = i_cancion.tamanio_bytes
			   , precio_unidad         = i_cancion.precio_unidad
          WHERE  id_cancion            = i_cancion.id_cancion; 

      WHEN 'DELETE' 
        THEN
          DELETE FROM CANCION
          WHERE id_cancion  = i_cancion.id_cancion;

      WHEN 'SELECT'
        THEN 
          OPEN o_cursor FOR SELECT                id_cancion 
												, nombre 
												, id_album 
												, id_formato 
												, id_genero 
												, compositor 
												, duracion 
												, tamanio_bytes 
												, precio_unidad   
                            FROM CANCION;

      END CASE;        

 END PRC_MAN_CANCION;

 END PKG_MANTENIMIENTOS;
 
 
 