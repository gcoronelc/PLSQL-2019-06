-- CREACI�N DEL ESQUEMA
-- =========================================
-- CREAR CARPETAS EN EL DISCO C: - C:\DATA_ORACLE\DIS_1\ 2 Y 3
-- =========================================

CREATE TABLESPACE FARMACIA_BUENA_SALUD DATAFILE 'C:\DATA_ORACLE\DIS_1\FARMACIA_BUENA_SALUD1.DBF' SIZE 100M, 'C:\DATA_ORACLE\DIS_2\FARMACIA_BUENA_SALUD2.DBF' SIZE 100M, 'C:\DATA_ORACLE\DIS_3\FARMACIA_BUENA_SALUD3.DBF' SIZE 100M;
--CREATE TEMPORARY TABLESPACE FARMACIA_BUENA_SALUD DATAFILE 'C:\DATA_ORACLE\DIS_1\FARMACIA_BUENA_SALUD_TEMP.DBF' SIZE 100M;

SELECT * FROM DBA_DATA_FILES;

-- =========================================
-- CREAR ROL
-- =========================================
CREATE ROLE ADMIN_DB;

-- =========================================
-- Asignando permisos al rol ADMIN_DB
-- =========================================
--GRANT CONNECT, RESOURCE TO ADMIN_DB;
GRANT CREATE SESSION TO ADMIN_DB;
GRANT CREATE ANY TABLE TO ADMIN_DB;
GRANT CREATE ROLE TO ADMIN_DB;
GRANT CREATE USER TO ADMIN_DB;
GRANT CREATE VIEW TO ADMIN_DB;
GRANT CREATE ANY INDEX TO ADMIN_DB;
GRANT CREATE TRIGGER TO ADMIN_DB;
GRANT CREATE PROCEDURE TO ADMIN_DB;
GRANT CREATE SEQUENCE TO ADMIN_DB;

-- =========================================
-- CREAR EL USUARIO A USAR
-- =========================================
CREATE USER ADMIN_FARMACIA IDENTIFIED BY ADMIN123
DEFAULT TABLESPACE FARMACIA_BUENA_SALUD TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON FARMACIA_BUENA_SALUD;

GRANT UNLIMITED TABLESPACE TO ADMIN_FARMACIA;

GRANT CONNECT TO ADMIN_FARMACIA;
GRANT CREATE TABLE TO ADMIN_FARMACIA;
GRANT RESOURCE TO ADMIN_FARMACIA;

SELECT 
USERNAME, default_tablespace, temporary_tablespace
FROM DBA_USERS
WHERE USERNAME LIKE 'ADMI%';

-- =========================================
-- ASIGNAR ROL AL USUARIO CREADO
-- =========================================
GRANT ADMIN_DB TO ADMIN_FARMACIA;

-- =========================================
-- INICIAR SESSION CON EL NUEVO USUARIO
-- =========================================
 /*USU:ADMIN_FARMACIA PASS:ADMIN123*/

-- ===========================================================================================================================
-- ===========================================================================================================================
CREATE TABLE ADMIN_FARMACIA.CATEGORIA(
  COD_CATEGORIA    NUMBER NOT NULL,
  NOM_CATEGORIA    VARCHAR2(20) NOT NULL,
  ESTADO_CATEGRIA  NUMBER NOT NULL,
  CONSTRAINT PK_CATEGORIA PRIMARY KEY(COD_CATEGORIA)
);

CREATE SEQUENCE ADMIN_FARMACIA.SEQ_CATEGORIA;

INSERT INTO  ADMIN_FARMACIA.CATEGORIA VALUES (SEQ_CATEGORIA.NEXTVAL,'MEDICAMENTOS',1);
INSERT INTO  ADMIN_FARMACIA.CATEGORIA VALUES (SEQ_CATEGORIA.NEXTVAL,'PERFUMERIA',1);
INSERT INTO  ADMIN_FARMACIA.CATEGORIA VALUES (SEQ_CATEGORIA.NEXTVAL,'REGALOS',1);

COMMIT;

SELECT * FROM ADMIN_FARMACIA.CATEGORIA;

-- ===========================================================================================================================
-- ===========================================================================================================================
CREATE TABLE ADMIN_FARMACIA.LABORATORIO(
  COD_LABORATORIO     NUMBER NOT NULL,
  NOM_LABORATORIO     VARCHAR2(50) NOT NULL,
  ESTADO_LABORATORIO  NUMBER NOT NULL,
  CONSTRAINT PK_LABORATORIO PRIMARY KEY(COD_LABORATORIO)
);

CREATE SEQUENCE ADMIN_FARMACIA.SEQ_LABORATORIO;

INSERT INTO  ADMIN_FARMACIA.LABORATORIO VALUES (SEQ_LABORATORIO.NEXTVAL,'BAYER',1);
INSERT INTO  ADMIN_FARMACIA.LABORATORIO VALUES (SEQ_LABORATORIO.NEXTVAL,'FARMAINDUSTRIA',1);
INSERT INTO  ADMIN_FARMACIA.LABORATORIO VALUES (SEQ_LABORATORIO.NEXTVAL,'PERULAB',1);
INSERT INTO  ADMIN_FARMACIA.LABORATORIO VALUES (SEQ_LABORATORIO.NEXTVAL,'QUIMICA ZUIZA',1);

COMMIT;

SELECT * FROM ADMIN_FARMACIA.LABORATORIO;


-- ===========================================================================================================================
-- ===========================================================================================================================
CREATE TABLE ADMIN_FARMACIA.ACCION_FARMACOLOGICA(
  COD_ACCION          NUMBER NOT NULL,
  DESCRIPCION         VARCHAR2(50) NOT NULL,
  ESTADO_ACCION       NUMBER NOT NULL,
  CONSTRAINT PK_ACCION_FARMACOLOGICA PRIMARY KEY(COD_ACCION)
);

CREATE SEQUENCE ADMIN_FARMACIA.SEQ_ACCION;

INSERT INTO  ADMIN_FARMACIA.ACCION_FARMACOLOGICA VALUES (SEQ_ACCION.NEXTVAL,'ANTIINFLAMATORIO',1);
INSERT INTO  ADMIN_FARMACIA.ACCION_FARMACOLOGICA VALUES (SEQ_ACCION.NEXTVAL,'ANTIGRIPAL',1);
INSERT INTO  ADMIN_FARMACIA.ACCION_FARMACOLOGICA VALUES (SEQ_ACCION.NEXTVAL,'ANTICONCEPTIVOS',1);
INSERT INTO  ADMIN_FARMACIA.ACCION_FARMACOLOGICA VALUES (SEQ_ACCION.NEXTVAL,'REUMATOLOGIA',1);

COMMIT;

SELECT * FROM ADMIN_FARMACIA.ACCION_FARMACOLOGICA;

-- ===========================================================================================================================
-- ===========================================================================================================================
CREATE TABLE ADMIN_FARMACIA.PRODUCTO(
  COD_PRODUCTO         NUMBER NOT NULL,
  COD_CATEGORIA        NUMBER NOT NULL,
  COD_ACCION           NUMBER NOT NULL,
  COD_LABORATORIO      NUMBER NOT NULL,
  NOM_PRODUCTO         VARCHAR2(100) NOT NULL,
  PRECIO_COSTO         NUMBER(10,2) NOT NULL,
  PRECIO_UNIDAD        NUMBER(10,2) NOT NULL,
  FECHA_VCTO           DATE,
  STOCK                NUMBER,
  STOCK_MIN            NUMBER,
  ESTADO               NUMBER,
  CONSTRAINT PK_PRODUCTO PRIMARY KEY(COD_PRODUCTO),
  CONSTRAINT FK_PRODUCTO_CATEGORIA FOREIGN KEY(COD_CATEGORIA) REFERENCES ADMIN_FARMACIA.CATEGORIA(COD_CATEGORIA),
  CONSTRAINT FK_PRODUCTO_ACCION FOREIGN KEY(COD_ACCION) REFERENCES ADMIN_FARMACIA.ACCION_FARMACOLOGICA(COD_ACCION),
  CONSTRAINT FK_PRODUCTO_LABORATORIO FOREIGN KEY(COD_LABORATORIO) REFERENCES ADMIN_FARMACIA.LABORATORIO(COD_LABORATORIO)
);

CREATE SEQUENCE ADMIN_FARMACIA.SEQ_PRODUCTO;

INSERT INTO  ADMIN_FARMACIA.PRODUCTO VALUES (SEQ_PRODUCTO.NEXTVAL,1,2,1,'PANADOL FORTE 500MG',15.5,3.5,TO_DATE('2019-07-12','YYYY-MM-DD'),100,5,1);
INSERT INTO  ADMIN_FARMACIA.PRODUCTO VALUES (SEQ_PRODUCTO.NEXTVAL,2,2,1,'IBUPROFENO 500MG',30.2,2.5,TO_DATE('2019-07-12','YYYY-MM-DD'),200,5,1);
INSERT INTO  ADMIN_FARMACIA.PRODUCTO VALUES (SEQ_PRODUCTO.NEXTVAL,3,2,1,'DICLOFENACO',100.5,1.5,TO_DATE('2019-07-12','YYYY-MM-DD'),50,5,1);
INSERT INTO  ADMIN_FARMACIA.PRODUCTO VALUES (SEQ_PRODUCTO.NEXTVAL,2,2,1,'ASPIRINA 500MG',30.6,3.5,TO_DATE('2019-07-12','YYYY-MM-DD'),20,5,1);
INSERT INTO  ADMIN_FARMACIA.PRODUCTO VALUES (SEQ_PRODUCTO.NEXTVAL,2,2,1,'PANADOL FORTE 500MG',25.8,3.5,TO_DATE('2019-07-12','YYYY-MM-DD'),10,5,1);

COMMIT;

SELECT * FROM ADMIN_FARMACIA.PRODUCTO;


-- ===========================================================================================================================
-- ===========================================================================================================================
CREATE TABLE ADMIN_FARMACIA.CLIENTE(
  COD_CLIENTE          NUMBER NOT NULL,
  COD_TIPODOCUMENTO    NUMBER NOT NULL,
  NUM_DOCUMENTO        NUMBER(11) NOT NULL,
  NOMBRE_CLIENTE       VARCHAR2(100) NOT NULL,
  DIRECCION            VARCHAR2(200) NOT NULL,
  PAIS                 VARCHAR2(50) NOT NULL,
  TELEFONO             VARCHAR2(15),
  CELULAR              VARCHAR2(10),
  EMAIL                VARCHAR2(50),
  ESTADO               NUMBER,
  CONSTRAINT PK_CLIENTE PRIMARY KEY(COD_CLIENTE)
);

CREATE SEQUENCE ADMIN_FARMACIA.SEQ_CLIENTE;

INSERT INTO  ADMIN_FARMACIA.CLIENTE VALUES (SEQ_CLIENTE.NEXTVAL,1,84562145,'WALTER LOPEZ','LIMA','PERU','5284600','989563148','CORREO@CORREO.COM',1);
INSERT INTO  ADMIN_FARMACIA.CLIENTE VALUES (SEQ_CLIENTE.NEXTVAL,1,15562100,'ENMA SANCHEZ','LIMA','PERU','528454','977723148','CORREO@CORREO.COM',1);
INSERT INTO  ADMIN_FARMACIA.CLIENTE VALUES (SEQ_CLIENTE.NEXTVAL,1,00562188,'LUZ GAMARRA','LIMA','PERU','5274564','974563148','CORREO@CORREO.COM',1);
INSERT INTO  ADMIN_FARMACIA.CLIENTE VALUES (SEQ_CLIENTE.NEXTVAL,1,75262196,'CYNTHIA SALAS','LIMA','PERU','5452664','90002148','CORREO@CORREO.COM',1);
INSERT INTO  ADMIN_FARMACIA.CLIENTE VALUES (SEQ_CLIENTE.NEXTVAL,1,41221456,'DIEGO VERA','LIMA','PERU','585264','987823148','CORREO@CORREO.COM',1);

COMMIT;

SELECT * FROM ADMIN_FARMACIA.CLIENTE;


-- ===========================================================================================================================
-- ===========================================================================================================================
CREATE TABLE ADMIN_FARMACIA.TIPOCOMPROBANTE(
  COD_TIPOCOMPROBANTE    NUMBER NOT NULL,
  TIPO_COMPROBANTE       VARCHAR2(50) NOT NULL,
  ESTADO                 NUMBER NOT NULL,
  CONSTRAINT PK_TIPOCOMPROBANTE PRIMARY KEY(COD_TIPOCOMPROBANTE)
);

CREATE SEQUENCE ADMIN_FARMACIA.SEQ_TIPOCOMPROBANTE;

INSERT INTO  ADMIN_FARMACIA.TIPOCOMPROBANTE VALUES (SEQ_TIPOCOMPROBANTE.NEXTVAL,'FACTURA',1);
INSERT INTO  ADMIN_FARMACIA.TIPOCOMPROBANTE VALUES (SEQ_TIPOCOMPROBANTE.NEXTVAL,'BOLETA',1);
INSERT INTO  ADMIN_FARMACIA.TIPOCOMPROBANTE VALUES (SEQ_TIPOCOMPROBANTE.NEXTVAL,'NOTA DEBITO',1);
INSERT INTO  ADMIN_FARMACIA.TIPOCOMPROBANTE VALUES (SEQ_TIPOCOMPROBANTE.NEXTVAL,'NOTA CREDITO',1);

COMMIT;

SELECT * FROM ADMIN_FARMACIA.TIPOCOMPROBANTE;


-- ===========================================================================================================================
-- ===========================================================================================================================
CREATE TABLE ADMIN_FARMACIA.VENTA(
  COD_VENTA               NUMBER NOT NULL,
  COD_TIPOCOMPROBANTE     NUMBER NOT NULL,
  NUM_SERIE               VARCHAR2(50) NOT NULL,
  COD_CLIENTE             NUMBER NOT NULL,
  COD_EMPLEADO            NUMBER NOT NULL,
  FECHA_VENTA             DATE NOT NULL,
  TOTAL_DESCUENTO         NUMBER(10,2) NOT NULL,
  IGV                     NUMBER(10,2) NOT NULL,
  TOTAL_VENTA             NUMBER(10,2) NOT NULL,
  CONSTRAINT PK_VENTA PRIMARY KEY(COD_VENTA),
  CONSTRAINT FK_VENTA_TIPOCOMP FOREIGN KEY(COD_TIPOCOMPROBANTE) REFERENCES ADMIN_FARMACIA.TIPOCOMPROBANTE(COD_TIPOCOMPROBANTE),
  CONSTRAINT FK_VENTA_CLIENTE FOREIGN KEY(COD_CLIENTE) REFERENCES ADMIN_FARMACIA.CLIENTE(COD_CLIENTE)
);

CREATE SEQUENCE ADMIN_FARMACIA.SEQ_VENTA;

INSERT INTO  ADMIN_FARMACIA.VENTA VALUES (SEQ_VENTA.NEXTVAL,1,'F001-123',1,1,TO_DATE(SYSDATE,'YYYY-MM-DD'),80,20,550);
INSERT INTO  ADMIN_FARMACIA.VENTA VALUES (SEQ_VENTA.NEXTVAL,2,'B001-789',2,1,TO_DATE(SYSDATE,'YYYY-MM-DD'),50,25,600);
INSERT INTO  ADMIN_FARMACIA.VENTA VALUES (SEQ_VENTA.NEXTVAL,1,'F001-448',2,1,TO_DATE(SYSDATE,'YYYY-MM-DD'),60,40,700);
INSERT INTO  ADMIN_FARMACIA.VENTA VALUES (SEQ_VENTA.NEXTVAL,2,'B001-564',3,1,TO_DATE(SYSDATE,'YYYY-MM-DD'),70,150,320);
INSERT INTO  ADMIN_FARMACIA.VENTA VALUES (SEQ_VENTA.NEXTVAL,3,'ND01-123',1,1,TO_DATE(SYSDATE,'YYYY-MM-DD'),10,45,150);

COMMIT;

SELECT * FROM ADMIN_FARMACIA.VENTA;


-- ===========================================================================================================================
-- ===========================================================================================================================
CREATE TABLE ADMIN_FARMACIA.DETALLE_VENTA(
  COD_DETALLEVENTA        NUMBER NOT NULL,
  COD_VENTA               NUMBER NOT NULL,
  NUM_SERIE               VARCHAR2(50) NOT NULL,  
  COD_PRODUCTO            NUMBER NOT NULL,
  CANTIDAD                NUMBER NOT NULL,
  PRECIO_UNITARIO         NUMBER(10,2) NOT NULL,
  DESCUENTO               NUMBER(10,2) NOT NULL,
  IGV                     NUMBER(10,2) NOT NULL,
  VALORTOTAL              NUMBER(10,2) NOT NULL,
  CONSTRAINT PK_DETALLE_VENTA PRIMARY KEY(COD_DETALLEVENTA),
  CONSTRAINT FK_DETALLE_VENTA_VENTA FOREIGN KEY(COD_VENTA) REFERENCES ADMIN_FARMACIA.VENTA(COD_VENTA),
  CONSTRAINT FK_DETALLE_VENTA_PRODUCTO FOREIGN KEY(COD_PRODUCTO) REFERENCES ADMIN_FARMACIA.PRODUCTO(COD_PRODUCTO)
);

CREATE SEQUENCE ADMIN_FARMACIA.SEQ_DETALLE_VENTA;

INSERT INTO  ADMIN_FARMACIA.DETALLE_VENTA VALUES (SEQ_DETALLE_VENTA.NEXTVAL,1,'F001-123',1,5,64,70,57.60,320);
INSERT INTO  ADMIN_FARMACIA.DETALLE_VENTA VALUES (SEQ_DETALLE_VENTA.NEXTVAL,1,'F001-123',2,8,5.6,10,27,150);

COMMIT;

SELECT * FROM ADMIN_FARMACIA.DETALLE_VENTA;






