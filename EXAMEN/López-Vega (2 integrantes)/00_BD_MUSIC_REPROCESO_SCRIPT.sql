
/*******************************************************************************
   EXAMEN FINAL DE PL/SQL WORKSHOP - SISTEMAS UNI
   Base de Datos de una Tienda de Música - Version 1.0
   Script: 00_BD_MUSIC_REPROCESO_SCRIPT.sql
   Descripción: Elimina el esquema en caso se requiera reproceso
   Integrantes: 
	- López Villanueva, Timoteo
	- Vega Blas, Robert Jaime
********************************************************************************/

/*******************************************************************************
   Elimina el usuario
********************************************************************************/
DROP USER BD_MUSIC CASCADE;

/*******************************************************************************
   Elimina los tablespaces
********************************************************************************/
DROP TABLESPACE TBS_BD_MUSIC_TABLAS_01 INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE TBS_BD_MUSIC_INDICES INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE TBS_BD_MUSIC_TEMPORAL INCLUDING CONTENTS AND DATAFILES;



