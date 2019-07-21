/*******************************************************************************
   EXAMEN FINAL DE PL/SQL WORKSHOP - SISTEMAS UNI
   Base de Datos de una Tienda de Musica - Version 1.0
   Script: 01_BD_MUSIC_CREACION_ESQUEMA.sql
   Descripcion: Crea el esquema de base de datos. 
   Usa la carpeta BD_MUSIC del escritorio como repo de tablespaces.
   Debe tener permisos de Lectura y Escritura
   Integrantes: 
	- Lopez Villanueva, Timoteo
	- Vega Blas, Robert Jaime
********************************************************************************/

/*******************************************************************************
   Crea los tablespaces
********************************************************************************/
-- Para tablas
CREATE TABLESPACE TBS_BD_MUSIC_TABLAS
DATAFILE 'I:\Users\Oracle\Desktop\Examen\BD_MUSIC\tablas\TBS_BD_MUSIC_TABLAS_01.dbf' SIZE 100M 
AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

-- Para índices
CREATE TABLESPACE TBS_BD_MUSIC_INDICES
DATAFILE 'I:\Users\Oracle\Desktop\Examen\BD_MUSIC\indices\TBS_BD_MUSIC_INDICES_01.dbf' SIZE 100M
AUTOEXTEND ON NEXT 100M
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

-- Para temporales
CREATE TEMPORARY TABLESPACE TBS_BD_MUSIC_TEMPORAL
TEMPFILE 'I:\Users\Oracle\Desktop\Examen\BD_MUSIC\temporal\TBS_BD_MUSIC_TEMPORAL_01.dbf' SIZE 100M REUSE
AUTOEXTEND ON NEXT 100M
EXTENT MANAGEMENT LOCAL;

/*******************************************************************************
   Crea el usuario de base de datos
********************************************************************************/
alter session set "_ORACLE_SCRIPT"=true;

CREATE USER BD_MUSIC
IDENTIFIED BY 1234
DEFAULT TABLESPACE TBS_BD_MUSIC_TABLAS
TEMPORARY TABLESPACE TBS_BD_MUSIC_TEMPORAL
ACCOUNT UNLOCK;

/*******************************************************************************
   Otorga privilegios al usuario
********************************************************************************/
GRANT CONNECT TO BD_MUSIC;
GRANT CREATE VIEW TO BD_MUSIC;
GRANT CREATE TABLE TO BD_MUSIC;
GRANT CREATE PROCEDURE TO BD_MUSIC;
GRANT CREATE SEQUENCE TO BD_MUSIC;
-- QUOTAS
ALTER USER BD_MUSIC QUOTA UNLIMITED ON TBS_BD_MUSIC_TABLAS;
ALTER USER BD_MUSIC QUOTA UNLIMITED ON TBS_BD_MUSIC_INDICES;
GRANT UNLIMITED TABLESPACE TO BD_MUSIC

/*******************************************************************************
   Crea las Tablas
********************************************************************************/
CREATE TABLE BD_MUSIC.ALBUM
(
    id_album NUMBER NOT NULL,
    titulo VARCHAR2(160) NOT NULL,
    id_artista NUMBER NOT NULL,
    CONSTRAINT PK_ALBUM PRIMARY KEY  (id_album)
);

CREATE TABLE BD_MUSIC.ARTISTA
(
    id_artista NUMBER NOT NULL,
    nombre VARCHAR2(120),
    CONSTRAINT PK_ARTISTA PRIMARY KEY  (id_artista)
);

CREATE TABLE BD_MUSIC.CLIENTE
(
    id_cliente NUMBER NOT NULL,
    nombres VARCHAR2(40) NOT NULL,
    apellidos VARCHAR2(20) NOT NULL,
    empresa VARCHAR2(80),
    direccion VARCHAR2(70),
    ciudad VARCHAR2(40),
    estado VARCHAR2(40),
    pais VARCHAR2(40),
    codigo_postal VARCHAR2(10),
    telefono VARCHAR2(24),
    fax VARCHAR2(24),
    correo VARCHAR2(60) NOT NULL,
    id_empleado_soporte NUMBER,
    CONSTRAINT PK_CLIENTE PRIMARY KEY  (id_cliente)
);

CREATE TABLE BD_MUSIC.EMPLEADO
(
    id_empleado NUMBER NOT NULL,
    apellidos VARCHAR2(20) NOT NULL,
    nombres VARCHAR2(20) NOT NULL,
    titulo VARCHAR2(30),
    id_supervisor NUMBER,
    cumpleanios DATE,
    fecha_contratacion DATE,
    direccion VARCHAR2(70),
    ciudad VARCHAR2(40),
    estado VARCHAR2(40),
    pais VARCHAR2(40),
    codigo_postal VARCHAR2(10),
    telefono VARCHAR2(24),
    fax VARCHAR2(24),
    correo VARCHAR2(60),
    CONSTRAINT PK_EMPLEADO PRIMARY KEY  (id_empleado)
);

CREATE TABLE BD_MUSIC.GENERO
(
    id_genero NUMBER NOT NULL,
    nombre VARCHAR2(120),
    CONSTRAINT PK_GENERO PRIMARY KEY  (id_genero)
);

CREATE TABLE BD_MUSIC.FACTURA
(
    id_factura NUMBER NOT NULL,
    id_cliente NUMBER NOT NULL,
    fecha_factura DATE NOT NULL,
    direccion_envio VARCHAR2(70),
    ciudad_envio VARCHAR2(40),
    estado_envio VARCHAR2(40),
    pais_envio VARCHAR2(40),
    codigo_postal_envio VARCHAR2(10),
    Total NUMBER(10,2) NOT NULL,
    CONSTRAINT PK_FACTURA PRIMARY KEY  (id_factura)
);

CREATE TABLE BD_MUSIC.FACTURA_DETALLE
(
    id_factura_detalle NUMBER NOT NULL,
    id_factura NUMBER NOT NULL,
    id_cancion NUMBER NOT NULL,
    precio_unidad NUMBER(10,2) NOT NULL,
    cantidad NUMBER NOT NULL,
    CONSTRAINT PK_FACTURA_DETALLE PRIMARY KEY  (id_factura_detalle)
);

CREATE TABLE BD_MUSIC.FORMATO
(
    id_formato NUMBER NOT NULL,
    nombre VARCHAR2(120),
    CONSTRAINT PK_FORMATO PRIMARY KEY  (id_formato)
);

CREATE TABLE BD_MUSIC.LISTA_REPRODUCCION
(
    id_lista_reproduccion NUMBER NOT NULL,
    nombre VARCHAR2(120),
    CONSTRAINT PK_LISTA_REPRODUCCION PRIMARY KEY  (id_lista_reproduccion)
);

CREATE TABLE BD_MUSIC.LISTA_REPRODUCCION_CANCION
(
    id_lista_reproduccion NUMBER NOT NULL,
    id_cancion NUMBER NOT NULL,
    CONSTRAINT PK_LISTA_REPRODUCCION_CANCION PRIMARY KEY  (id_lista_reproduccion, id_cancion)
);

CREATE TABLE BD_MUSIC.CANCION
(
    id_cancion NUMBER NOT NULL,
    nombre VARCHAR2(200) NOT NULL,
    id_album NUMBER,
    id_formato NUMBER NOT NULL,
    id_genero NUMBER,
    compositor VARCHAR2(220),
    duracion NUMBER NOT NULL,
    tamanio_bytes NUMBER,
    precio_unidad NUMBER(10,2) NOT NULL,
    CONSTRAINT PK_PISTA PRIMARY KEY  (id_cancion)
);

/*******************************************************************************
   Crea Llaves Foráneas
********************************************************************************/
ALTER TABLE BD_MUSIC.ALBUM ADD CONSTRAINT FK_ARTISTA_01
    FOREIGN KEY (id_artista) REFERENCES BD_MUSIC.ARTISTA (id_artista)  ;

ALTER TABLE BD_MUSIC.CLIENTE ADD CONSTRAINT FK_SOPORTE_CLIENTE_01
    FOREIGN KEY (id_empleado_soporte) REFERENCES BD_MUSIC.EMPLEADO (id_empleado)  ;

ALTER TABLE BD_MUSIC.EMPLEADO ADD CONSTRAINT FK_SUPERVISOR_EMPLEADO_01
    FOREIGN KEY (id_supervisor) REFERENCES BD_MUSIC.EMPLEADO (id_empleado)  ;

ALTER TABLE BD_MUSIC.FACTURA ADD CONSTRAINT FK_CLIENTE_01
    FOREIGN KEY (id_cliente) REFERENCES BD_MUSIC.CLIENTE (id_cliente)  ;

ALTER TABLE BD_MUSIC.FACTURA_DETALLE ADD CONSTRAINT FK_FACTURA_01
    FOREIGN KEY (id_factura) REFERENCES BD_MUSIC.FACTURA (id_factura)  ;

ALTER TABLE BD_MUSIC.FACTURA_DETALLE ADD CONSTRAINT FK_CANCION_01
    FOREIGN KEY (id_cancion) REFERENCES BD_MUSIC.CANCION (id_cancion)  ;

ALTER TABLE BD_MUSIC.LISTA_REPRODUCCION_CANCION ADD CONSTRAINT FK_LISTA_REPRODUCCION_01
    FOREIGN KEY (id_lista_reproduccion) REFERENCES BD_MUSIC.LISTA_REPRODUCCION (id_lista_reproduccion)  ;

ALTER TABLE BD_MUSIC.LISTA_REPRODUCCION_CANCION ADD CONSTRAINT FK_CANCION_02
    FOREIGN KEY (id_cancion) REFERENCES BD_MUSIC.CANCION (id_cancion)  ;

ALTER TABLE BD_MUSIC.CANCION ADD CONSTRAINT FK_ALBUM_01
    FOREIGN KEY (id_album) REFERENCES BD_MUSIC.ALBUM (id_album)  ;

ALTER TABLE BD_MUSIC.CANCION ADD CONSTRAINT FK_GENERO_01
    FOREIGN KEY (id_genero) REFERENCES BD_MUSIC.GENERO (id_genero)  ;

ALTER TABLE BD_MUSIC.CANCION ADD CONSTRAINT FK_FORMATO_01
    FOREIGN KEY (id_formato) REFERENCES BD_MUSIC.FORMATO (id_formato)  ;

commit;

