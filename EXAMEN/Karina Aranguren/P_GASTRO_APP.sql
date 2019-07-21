CREATE OR REPLACE package P_GASTRO_APP is

-- Create

PROCEDURE SP_wsSetUsuarioG
--Registra Usuarios App Gastro
(
  i_NOMBRE in VARCHAR2,
  i_CARGO in VARCHAR2,
  i_EMPRESA in VARCHAR2,
  i_TELEFONO in VARCHAR2, 
  i_CORREO in VARCHAR2,
  i_QR in VARCHAR2,
  i_DETALLE in VARCHAR2, 
  i_TIPO_USU in VARCHAR2,
  i_PAIS in VARCHAR2,
  i_TIPO_DOC in VARCHAR2,
  i_DOCUMENTO in VARCHAR2,
  i_EVENTO in NUMBER,
  i_VOUCHER in VARCHAR2,
  o_COD_ERROR OUT NUMBER,
  O_MSG_ERROR OUT VARCHAR2
);

PROCEDURE SP_wsSetParticipacionG
--Registra Participacion de usuarios en temas de App Gastro
(
  i_COD_PARTICIPACION in INTEGER,
  i_PREGUNTA in VARCHAR2,
  i_RESPUESTA in VARCHAR2,
  i_ANULAR in CHAR, 
  i_COD_INVITADO in INTEGER,
  I_COD_TEMA IN INTEGER, 
  o_COD_ERROR OUT NUMBER,
  O_MSG_ERROR OUT VARCHAR2
);

-- Read

PROCEDURE SP_wsGetUsuarioG
--Devuelve datos del usuario
( 
  PI_ID_USUARIO IN INTEGER,
  PI_ID_NOMBRE IN VARCHAR2,
  PI_ID_CARGO IN VARCHAR2,
  PI_ID_EMPRESA IN VARCHAR2,
  PI_ID_DOCUMENTO IN VARCHAR2,
  PI_ID_EVENTO IN INTEGER,
  PI_ID_TIPO_USU IN VARCHAR2,
  PO_USUARIO  OUT SYS_REFCURSOR, 
  o_COD_ERROR   OUT INTEGER,
  o_MSG_ERROR   OUT VARCHAR2 -- HASTA 250 caracteres*/
);

PROCEDURE SP_WSGETINFOEVENTOG
-- Devuelve datos del evento
( 
  PI_CODIGO IN NUMBER,
  PI_NOMBRE IN VARCHAR2,  
  PI_LUGAR IN VARCHAR2,
  PI_SALA IN VARCHAR2,
  PO_EVENTO  OUT SYS_REFCURSOR, 
  o_COD_ERROR   OUT INTEGER,
  o_MSG_ERROR   OUT VARCHAR2 -- HASTA 250 caracteres*/
);


PROCEDURE SP_wsGetTemasG
--Devuelve lista de Actividades
( 
  PI_ID_EVENTO IN INTEGER,
  PI_ID_TEMA IN INTEGER,
  PO_TEMAS  OUT SYS_REFCURSOR, 
  o_COD_ERROR   OUT INTEGER,
  o_MSG_ERROR   OUT VARCHAR2 -- HASTA 250 caracteres*/
);


PROCEDURE SP_wsGetParticipacionG
--Devuelve preguntas hechas respecto a un tema
( 
  PI_ID_TEMA IN INTEGER,
  PI_ID_USUARIO IN INTEGER,
  PI_ID_PREGUNTA IN INTEGER,
  PO_TEMA  OUT SYS_REFCURSOR, 
  o_COD_ERROR   OUT INTEGER,
  o_MSG_ERROR   OUT VARCHAR2 -- HASTA 250 caracteres*/
);

end P_GASTRO_APP;
/


CREATE OR REPLACE package body P_GASTRO_APP is

-- Create

PROCEDURE SP_wsSetUsuarioG
--Registra Usuarios App Gastro
(
  i_NOMBRE in VARCHAR2,
  i_CARGO in VARCHAR2,
  i_EMPRESA in VARCHAR2,
  i_TELEFONO in VARCHAR2, 
  i_CORREO in VARCHAR2,
  i_QR in VARCHAR2,
  i_DETALLE in VARCHAR2, 
  i_TIPO_USU in VARCHAR2,
  i_PAIS in VARCHAR2,
  i_TIPO_DOC in VARCHAR2,
  i_DOCUMENTO in VARCHAR2,
  i_EVENTO in NUMBER,
  i_VOUCHER in VARCHAR2,
  o_COD_ERROR OUT NUMBER,
  o_MSG_ERROR OUT VARCHAR2
)
  as  
    cProceso     VARCHAR2(100);
    cCant        INTEGER;
    cBecado      INTEGER;
    V_FLAG_ASISTIO VARCHAR2(1);
    V_DOCUMENTO VARCHAR2(50);
    V_ASISTENCIA INTEGER;
    V_NOMBRE VARCHAR2(50);
    V_USU_CODIGO INTEGER;
    
  begin
  
    o_COD_ERROR     := 0;
    o_MSG_ERROR     := 'OK!';
    cProceso        := 'Registrar usuario';
    cCant           := 0;
    
    -----------------------------------------------
    -- Validaciones
    if i_NOMBRE is null then
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'No se ha ingresado el nombre del usuario';
      cProceso    := 'Validacion Datos';
      return;
    end if;
              
    if i_TELEFONO is null then
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'No se ha ingresado el telefono del usuario' ;
      cProceso    := 'Validacion Datos';
      return;
    end if;
    
    if i_CORREO is null then
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'No se ha ingresado el correo del usuario' ;
      cProceso    := 'Validacion Datos';
      return;
    end if;
         
    if i_QR is null and i_TIPO_USU = '0002' then
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'No se ha ingresado el codigo qr del usuario' ;
      cProceso    := 'Validacion Datos';
      return;
    end if;
    
    if i_TIPO_USU is null then
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'No se ha ingresado el tipo de usuario' ;
      cProceso    := 'Validacion Datos';
      return;
    end if;
      
    if i_PAIS is null then
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'No se ha ingresado el pais del usuario' ;
      cProceso    := 'Validacion Datos';
      return;
    end if;
    
    if i_TIPO_DOC is null then
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'No se ha ingresado el tipo de documento' ;
      cProceso    := 'Validacion Datos';
      return;
    end if;
     
    if i_DOCUMENTO is null then
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'No se ha ingresado el documento del usuario' ;
      cProceso    := 'Validacion Datos';
      return;
    end if;
    
    SELECT COUNT(USU_CODIGO) 
    INTO cCant FROM SCOTT.GSTR_USUARIO G
    WHERE USU_DOCUMENTO = i_DOCUMENTO 
    AND G.PARM_COD_TIPO_USUARIO = i_TIPO_USU
    AND G.INFO_CODIGO = i_EVENTO;
    
    IF cCant > 0 THEN
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'El numero de documento ya se encuentra registrado en este evento' ;
      cProceso    := 'Validacion Datos';
      return;
    END IF;
 
   
   SELECT GSTR_USUARIO_seq.NEXTVAL INTO V_USU_CODIGO FROM DUAL;
   
   ------------ INSERTA USUARIO ----------------------------
   INSERT INTO SCOTT.GSTR_USUARIO(USU_CODIGO,
        USU_NOMBRE,
        USU_CARGO,
        USU_EMPRESA,
        USU_TELEFONO,
        USU_CORREO,
        USU_DETALLE,
        PARM_COD_TIPO_USUARIO,
        PARM_COD_PAIS,
        USU_DOCUMENTO,
        PARM_COD_TIPO_DOCUMENTO,
        INFO_CODIGO) 
   VALUES(V_USU_CODIGO,
          i_NOMBRE,
          i_CARGO,
          i_EMPRESA,
          i_TELEFONO, 
          i_CORREO,
          i_DETALLE, 
          i_TIPO_USU,
          i_PAIS,
          i_DOCUMENTO,
          i_TIPO_DOC,
          i_EVENTO);           
          
    COMMIT;
    
          
  EXCEPTION
    WHEN OTHERS THEN
      o_MSG_ERROR := SUBSTR(SQLERRM,1,4000);
      o_COD_ERROR := SQLCODE;
      o_MSG_ERROR := cProceso || ': ' || SQLERRM;
    
  END SP_wsSetUsuarioG;

PROCEDURE SP_wsSetParticipacionG
--Registra Participacion de usuarios en temas de App Gastro
(
  i_COD_PARTICIPACION in INTEGER,
  i_PREGUNTA in VARCHAR2,
  i_RESPUESTA in VARCHAR2,
  i_ANULAR in CHAR, 
  i_COD_INVITADO in INTEGER,
  i_COD_TEMA in INTEGER, 
  o_COD_ERROR OUT NUMBER,
  o_MSG_ERROR OUT VARCHAR2
)
AS
    cProceso         VARCHAR2(100);
    cIdUsuario       INTEGER;
    cIdTema          INTEGER;
    cRespondido      CHAR(1);
    cIdParticipacion INTEGER;
    
BEGIN
  
    o_COD_ERROR     := 0;
    o_MSG_ERROR     := 'OK!';
    cProceso        := 'Registrar participacion';
            
    IF i_COD_PARTICIPACION = 0 OR i_COD_PARTICIPACION IS NULL THEN
       IF i_PREGUNTA IS NULL THEN
          o_MSG_ERROR := 'No ingreso pregunta o codigo de participacion para su respuesta.';
       ELSE
         IF i_COD_INVITADO IS NULL THEN
            o_COD_ERROR := 1;
            o_MSG_ERROR := 'No se ha ingresado el codigo del usuario';
            cProceso    := 'Validacion Datos';
            return;
         END IF;
          
         IF i_COD_TEMA IS NULL THEN
            o_COD_ERROR := 1;
            o_MSG_ERROR := 'No se ha ingresado el codigo del tema';
            cProceso    := 'Validacion Datos';
            return;
         END IF;
          
          --Valida existe usuario
         BEGIN
            SELECT GSTR_USUARIO.USU_CODIGO
            INTO CIDUSUARIO
            FROM SCOTT.GSTR_USUARIO 
            WHERE GSTR_USUARIO.USU_CODIGO = i_COD_INVITADO;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
              o_COD_ERROR := 1;
              o_MSG_ERROR := 'No existe usuario';
              RETURN;
            WHEN OTHERS THEN
              o_COD_ERROR := SQLCODE;
              o_MSG_ERROR := SQLERRM;
              RETURN;
         END;
          
         --Valida existe tema
         BEGIN
            SELECT GSTR_TEMAS.TEMA_CODIGO
            INTO CIDTEMA
            FROM SCOTT.GSTR_TEMAS 
            WHERE GSTR_TEMAS.TEMA_CODIGO = i_COD_TEMA;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
              o_COD_ERROR := 1;
              o_MSG_ERROR := 'No existe tema.';
              RETURN;
            WHEN OTHERS THEN
              o_COD_ERROR := SQLCODE;
              o_MSG_ERROR := SQLERRM;
              RETURN;
         END;
         
         ------------ INSERTA PARTICIPACION ----------------------------
         INSERT INTO SCOTT.GSTR_PARTICIPACION(PART_CODIGO,
              PART_PREGUNTA,
              PART_RESPUESTA,
              PART_FLAG_RESPONDIDO,
              PART_FLAG_ANULADO,
              PART_FEC_PREGUNTA,
              PART_FEC_RESPUESTA,
              USU_COD_INVITADO,
              TEMA_CODIGO) 
         VALUES(GSTR_PARTICIPACION_seq.NEXTVAL,
            i_PREGUNTA,
            NULL,
            NULL,
            NULL, 
            SYSDATE,
            NULL,
            cIdUsuario,
            cIdTema);
            
          COMMIT;
          
          o_MSG_ERROR     := 'Se guardo exitosamente.';
       END IF ;
    ELSE
        --Valida existe participacion
       BEGIN
         SELECT GSTR_PARTICIPACION.PART_CODIGO,GSTR_PARTICIPACION.PART_FLAG_RESPONDIDO
         INTO CIDPARTICIPACION,CRESPONDIDO
         FROM SCOTT.GSTR_PARTICIPACION 
         WHERE GSTR_PARTICIPACION.PART_CODIGO = i_COD_PARTICIPACION;
       EXCEPTION
        WHEN NO_DATA_FOUND THEN
          o_COD_ERROR := 1;
          o_MSG_ERROR := 'No existe participacion.';
          RETURN;
        WHEN OTHERS THEN
          o_COD_ERROR := SQLCODE;
          o_MSG_ERROR := SQLERRM;
          RETURN;
       END;
                    
       IF i_ANULAR = 0 OR i_ANULAR IS NULL THEN                        
           ------------ ACTUALIZA PARTICIPACION ----------------------------
           UPDATE SCOTT.GSTR_PARTICIPACION
                 SET 
                 GSTR_PARTICIPACION.PART_RESPUESTA = i_RESPUESTA,
                 GSTR_PARTICIPACION.PART_FLAG_RESPONDIDO = (CASE WHEN i_RESPUESTA IS NULL THEN NULL ELSE '1' END)
           WHERE 
               GSTR_PARTICIPACION.PART_CODIGO = cIdParticipacion;
                   
           COMMIT;
               
           o_MSG_ERROR := 'Se actualizo exitosamente';           
       ELSE         
           ---------------- ANULA PARTICIPACION ----------------------------
           UPDATE 
                 SCOTT.GSTR_PARTICIPACION
           SET 
                 GSTR_PARTICIPACION.PART_FLAG_ANULADO = i_ANULAR
           WHERE 
                 GSTR_PARTICIPACION.PART_CODIGO = cIdParticipacion;
                   
           COMMIT;
           o_MSG_ERROR := 'Se anulo exitosamente';

       END IF;
    END IF;
   
  EXCEPTION
    WHEN OTHERS THEN
      o_MSG_ERROR := SUBSTR(SQLERRM,1,4000);
      o_COD_ERROR := SQLCODE;
      o_MSG_ERROR := cProceso || ': ' || SQLERRM;
    
  END SP_wsSetParticipacionG;

-- Read

PROCEDURE SP_WSGETUSUARIOG
--Devuelve datos del usuario
( 
  PI_ID_USUARIO   IN INTEGER,
  PI_ID_NOMBRE    IN VARCHAR2,
  PI_ID_CARGO     IN VARCHAR2,
  PI_ID_EMPRESA   IN VARCHAR2,
  PI_ID_DOCUMENTO IN VARCHAR2,
  PI_ID_EVENTO    IN INTEGER,
  PI_ID_TIPO_USU  IN VARCHAR2,
  PO_USUARIO      OUT SYS_REFCURSOR, 
  O_COD_ERROR     OUT INTEGER,
  o_MSG_ERROR     OUT VARCHAR2 -- HASTA 250 caracteres*/
)
AS
  cProceso        VARCHAR2(100);
  V_MSG_ERROR     VARCHAR2(4000);
BEGIN
    cProceso    := 'Consulta usuario gastroenterologia';
    o_COD_ERROR := 0;
    o_MSG_ERROR := 'Ok';
    
    OPEN PO_USUARIO FOR
     
     SELECT 
         GSTR_USUARIO.USU_CODIGO,
         GSTR_USUARIO.PARM_COD_TIPO_DOCUMENTO,
         (SELECT GSTR_PARAMETRO.PARM_DESCRIPCION FROM SCOTT.GSTR_PARAMETRO 
                 WHERE GSTR_PARAMETRO.PARM_ID = GSTR_USUARIO.PARM_COD_TIPO_DOCUMENTO 
                 AND GSTR_PARAMETRO.PARM_CODPADRE =3) TIPO_DOC,
         GSTR_USUARIO.USU_DOCUMENTO,
         GSTR_USUARIO.USU_NOMBRE,
         GSTR_USUARIO.USU_CARGO,
         GSTR_USUARIO.USU_EMPRESA,
         GSTR_USUARIO.USU_TELEFONO,
         GSTR_USUARIO.USU_CORREO,
         GSTR_USUARIO.USU_DETALLE,
         GSTR_USUARIO.PARM_COD_TIPO_USUARIO,
         (SELECT GSTR_PARAMETRO.PARM_DESCRIPCION FROM SCOTT.GSTR_PARAMETRO 
                 WHERE GSTR_PARAMETRO.PARM_ID = GSTR_USUARIO.PARM_COD_TIPO_USUARIO 
                 AND GSTR_PARAMETRO.PARM_CODPADRE=1) TIPO_USU,
         GSTR_USUARIO.PARM_COD_PAIS,
         (SELECT GSTR_PARAMETRO.PARM_DESCRIPCION FROM SCOTT.GSTR_PARAMETRO 
                 WHERE GSTR_PARAMETRO.PARM_ID = GSTR_USUARIO.PARM_COD_PAIS
                 AND GSTR_PARAMETRO.PARM_CODPADRE=2) PAIS,
         GSTR_USUARIO.INFO_CODIGO
     FROM 
         SCOTT.GSTR_USUARIO
     
     WHERE
          NVL(PI_ID_USUARIO,0) IN (GSTR_USUARIO.USU_CODIGO,0)
          AND NVL(PI_ID_NOMBRE,'0') IN (GSTR_USUARIO.USU_NOMBRE,'0')
          AND NVL(PI_ID_CARGO,'0') IN (GSTR_USUARIO.USU_CARGO,'0')
          AND NVL(PI_ID_EMPRESA,'0') IN (GSTR_USUARIO.USU_EMPRESA,'0')          
          AND NVL(PI_ID_DOCUMENTO,'0') IN (GSTR_USUARIO.USU_DOCUMENTO,'0') 
          AND NVL(PI_ID_EVENTO,'0') IN (GSTR_USUARIO.INFO_CODIGO,'0')
          AND NVL(PI_ID_TIPO_USU,'0') IN (GSTR_USUARIO.PARM_COD_TIPO_USUARIO,'0'); 
EXCEPTION
 WHEN OTHERS THEN
  o_COD_ERROR := -1;
  o_MSG_ERROR := cProceso || ': ' || SQLERRM;

End SP_wsGetUsuarioG;

PROCEDURE SP_wsGetInfoEventoG
--Devuelve datos del evento
(
  PI_CODIGO IN NUMBER, 
  PI_NOMBRE IN VARCHAR2,  
  PI_LUGAR IN VARCHAR2,
  PI_SALA IN VARCHAR2,
  PO_EVENTO  OUT SYS_REFCURSOR, 
  o_COD_ERROR   OUT INTEGER,
  o_MSG_ERROR   OUT VARCHAR2 -- HASTA 250 caracteres*/
)
AS
  cProceso        VARCHAR2(100);
  V_MSG_ERROR     VARCHAR2(4000);
  
BEGIN
    cProceso    := 'Consulta informacion del evento';
    o_COD_ERROR := 0;
    o_MSG_ERROR := 'Ok';
    
    OPEN PO_EVENTO FOR
     
     SELECT 
         GSTR_INFO_EVENTO.INFO_CODIGO COD_EVENTO,
         GSTR_INFO_EVENTO.INFO_NOMBRE NOMBRE,
         TO_CHAR(GSTR_INFO_EVENTO.INFO_FEC_INICIO,'DD/MM/YYYY HH24:MI') FEC_INICIO,
         TO_CHAR(GSTR_INFO_EVENTO.INFO_FEC_FIN,'DD/MM/YYYY HH24:MI') FEC_FIN,
         GSTR_INFO_EVENTO.INFO_LUGAR LUGAR,
         GSTR_INFO_EVENTO.INFO_SALA SALA,
         GSTR_INFO_EVENTO.INFO_CAPACIDAD CAPACIDAD,
         GSTR_INFO_EVENTO.INFO_INVERSION INVERSION,
         GSTR_INFO_EVENTO.INFO_NUM_EXPOSITORES EXPOSITORES,
         GSTR_INFO_EVENTO.INFO_NUM_STANDS STANDS
     FROM 
         SCOTT.GSTR_INFO_EVENTO     
     WHERE
          NVL(PI_CODIGO,0) IN (GSTR_INFO_EVENTO.INFO_CODIGO,0)
          AND NVL(PI_NOMBRE,0) IN (GSTR_INFO_EVENTO.INFO_NOMBRE,0)          
          AND NVL(PI_LUGAR,'0') IN (GSTR_INFO_EVENTO.INFO_LUGAR,'0')
          AND NVL(PI_SALA,'0') IN (GSTR_INFO_EVENTO.INFO_SALA,'0'); 
EXCEPTION
 WHEN OTHERS THEN
  o_COD_ERROR := -1;
  o_MSG_ERROR := cProceso || ': ' || SQLERRM;

End SP_wsGetInfoEventoG;

PROCEDURE SP_wsGetTemasG
--Devuelve lista de Actividades
( 
  PI_ID_EVENTO IN INTEGER,
  PI_ID_TEMA IN INTEGER,
  PO_TEMAS  OUT SYS_REFCURSOR, 
  o_COD_ERROR   OUT INTEGER,
  o_MSG_ERROR   OUT VARCHAR2 -- HASTA 250 caracteres*/
)
AS
  cProceso        VARCHAR2(100);
  V_MSG_ERROR     VARCHAR2(4000);
  cIdEvento       INTEGER;       
 
BEGIN
    cProceso    := 'Consulta tema(s) del evento';
    o_COD_ERROR := 0;
    o_MSG_ERROR := 'Ok';
    
     if PI_ID_EVENTO is null then
      o_COD_ERROR := 1;
      o_MSG_ERROR := 'NO SE HA INGRESADO CODIGO DEL EVENTO' ;
      cProceso    := 'Validacion Datos';
      return;
    end if;

        
    -- VALIDA SI EXISTE EVENTO
    BEGIN
      select GSTR_INFO_EVENTO.INFO_CODIGO
      INTO CIDEVENTO
      from SCOTT.GSTR_INFO_EVENTO 
      where GSTR_INFO_EVENTO.INFO_CODIGO = PI_ID_EVENTO;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        o_COD_ERROR := 1;
        o_MSG_ERROR := 'El evento ingresado no se encuentra registrado.';
        RETURN;
      WHEN OTHERS THEN
        o_COD_ERROR := SQLCODE;
        o_MSG_ERROR := SQLERRM;
        RETURN;
    END;
    
  OPEN PO_TEMAS FOR
     
     SELECT 
         GSTR_TEMAS.TEMA_CODIGO COD_TEMA,
         GSTR_TEMAS.TEMA_NOMBRE TEMA,
         GSTR_TEMAS.USU_COD_EXPOSITOR,
         (SELECT GSTR_USUARIO.USU_NOMBRE FROM SCOTT.GSTR_USUARIO WHERE GSTR_USUARIO.USU_CODIGO = GSTR_TEMAS.USU_COD_EXPOSITOR AND GSTR_USUARIO.PARM_COD_TIPO_USUARIO='0003') EXPOSITOR,
         (SELECT GSTR_USUARIO.USU_CARGO FROM SCOTT.GSTR_USUARIO WHERE GSTR_USUARIO.USU_CODIGO = GSTR_TEMAS.USU_COD_EXPOSITOR AND GSTR_USUARIO.PARM_COD_TIPO_USUARIO='0003') CARGO,
         (SELECT GSTR_USUARIO.USU_DETALLE FROM SCOTT.GSTR_USUARIO WHERE GSTR_USUARIO.USU_CODIGO = GSTR_TEMAS.USU_COD_EXPOSITOR AND GSTR_USUARIO.PARM_COD_TIPO_USUARIO='0003') DETALLE,
         TO_CHAR(GSTR_TEMAS.TEMA_FECHA,'DD/MM/YYYY HH24:MI') FECHA,
         GSTR_TEMAS.TEMA_HORA_INICIO HORA_INI,
         GSTR_TEMAS.TEMA_HORA_FIN HORA_FIN
     FROM 
         SCOTT.GSTR_TEMAS     
     WHERE
         GSTR_TEMAS.INFO_CODIGO = 2--cIdEvento
         AND NVL(PI_ID_TEMA,0) IN (GSTR_TEMAS.TEMA_CODIGO,0)
         ORDER BY GSTR_TEMAS.TEMA_FECHA,TO_DATE(GSTR_TEMAS.TEMA_HORA_INICIO,'HH24:MI:SS'); 
         

EXCEPTION
 WHEN OTHERS THEN
  o_COD_ERROR := -1;
  o_MSG_ERROR := cProceso || ': ' || SQLERRM;

End SP_wsGetTemasG;

PROCEDURE SP_wsGetParticipacionG
--Devuelve preguntas hechas respecto a un tema
( 
  PI_ID_TEMA IN INTEGER,
  PI_ID_USUARIO IN INTEGER,
  PI_ID_PREGUNTA IN INTEGER,
  PO_TEMA  OUT SYS_REFCURSOR, 
  o_COD_ERROR   OUT INTEGER,
  o_MSG_ERROR   OUT VARCHAR2 -- HASTA 250 caracteres*/
)
AS
  cProceso        VARCHAR2(100);
  V_MSG_ERROR     VARCHAR2(4000);   
  
BEGIN
    cProceso    := 'Consulta preguntas.';
    o_COD_ERROR := 0;
    o_MSG_ERROR := 'Ok';
      
    OPEN PO_TEMA FOR
     
     SELECT 
          GSTR_PARTICIPACION.TEMA_CODIGO COD_TEMA,
         (SELECT GSTR_TEMAS.TEMA_NOMBRE FROM SCOTT.GSTR_TEMAS WHERE GSTR_TEMAS.TEMA_CODIGO = GSTR_PARTICIPACION.TEMA_CODIGO) TEMA,
         (SELECT GSTR_TEMAS.USU_COD_EXPOSITOR FROM SCOTT.GSTR_TEMAS WHERE GSTR_TEMAS.TEMA_CODIGO = GSTR_PARTICIPACION.TEMA_CODIGO) COD_EXPOSITOR,
         (SELECT (SELECT GSTR_USUARIO.USU_NOMBRE FROM SCOTT.GSTR_USUARIO WHERE GSTR_USUARIO.USU_CODIGO = GSTR_TEMAS.USU_COD_EXPOSITOR) 
          FROM SCOTT.GSTR_TEMAS WHERE GSTR_TEMAS.TEMA_CODIGO = GSTR_PARTICIPACION.TEMA_CODIGO) EXPOSITOR,
         GSTR_PARTICIPACION.USU_COD_INVITADO COD_INVITADO,
         (SELECT GSTR_USUARIO.USU_NOMBRE FROM SCOTT.GSTR_USUARIO WHERE GSTR_USUARIO.USU_CODIGO = GSTR_PARTICIPACION.USU_COD_INVITADO) INVITADO,
         GSTR_PARTICIPACION.PART_CODIGO COD_PREGUNTA,
         GSTR_PARTICIPACION.PART_PREGUNTA PREGUNTA,
         TO_CHAR(GSTR_PARTICIPACION.PART_FEC_PREGUNTA,'DD/MM/YYYY HH24:MI') FEC_PREG, 
         NVL(GSTR_PARTICIPACION.PART_RESPUESTA,'') RESPUESTA, 
         NVL(TO_CHAR(GSTR_PARTICIPACION.PART_FEC_RESPUESTA,'DD/MM/YYYY HH24:MI'),'00/00/0000 00:00') FEC_RESP,
         NVL(GSTR_PARTICIPACION.PART_FLAG_RESPONDIDO,0) FLAG_RESPONDIDO,
         NVL(GSTR_PARTICIPACION.PART_FLAG_ANULADO,0) FLAG_ANULADO         
     FROM 
         SCOTT.GSTR_PARTICIPACION    
     WHERE
         NVL(PI_ID_TEMA,0) IN (GSTR_PARTICIPACION.TEMA_CODIGO,0)
         AND NVL(PI_ID_USUARIO,0) IN (GSTR_PARTICIPACION.USU_COD_INVITADO,0)
         AND NVL(PI_ID_PREGUNTA,0) IN (GSTR_PARTICIPACION.PART_CODIGO,0)
         AND NVL(GSTR_PARTICIPACION.PART_FLAG_ANULADO,0) NOT IN (1)
         ORDER BY 
         (SELECT GSTR_TEMAS.TEMA_FECHA FROM GSTR_TEMAS WHERE GSTR_TEMAS.TEMA_CODIGO = GSTR_PARTICIPACION.TEMA_CODIGO),
         GSTR_PARTICIPACION.PART_FEC_PREGUNTA DESC;
                  
EXCEPTION
 WHEN OTHERS THEN
  o_COD_ERROR := -1;
  o_MSG_ERROR := cProceso || ': ' || SQLERRM;

END SP_WSGETPARTICIPACIONG;
end P_GASTRO_APP;
/
