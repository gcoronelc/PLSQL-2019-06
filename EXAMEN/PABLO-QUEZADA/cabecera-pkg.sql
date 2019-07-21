CREATE OR REPLACE PACKAGE PKG_OPERACIONES IS
/*************************************************************************************************************/
-- Autor          :Pablo Queza Huerta
-- Revision       :
-- Version        : 0.1
-- ==========  ==============    ==============  =========================================================================

/***************************************************************************************************************************************/
PROCEDURE sp_inserta_paciente

(
  v_nombres         VARCHAR2,
  v_ap_paterno      VARCHAR2,
  v_ap_materno      VARCHAR2,
  v_nu_documento    NUMBER,
  v_ti_documento    NUMBER,
  v_sexo            CHAR,
  v_direccion      VARCHAR2,
  v_id_paciente    out NUMBER,
  v_error out varchar2
);



PROCEDURE sp_actualiza_paciente
 (
  v_nombres         VARCHAR2,
  v_ap_paterno      VARCHAR2,
  v_ap_materno      VARCHAR2,
  v_nu_documento    NUMBER,
  v_ti_documento    NUMBER,
  v_sexo            CHAR,
  v_direccion      VARCHAR2,
  v_id_paciente    out NUMBER,
  v_error out varchar2
  ); 

PROCEDURE sp_elimina_paciente(v_id_paciente in number,v_error out varchar2);

--FUNCTION fn_get_doc_paciente(v_nu_documento IN VARCHAR2) RETURN NUMBER;
PROCEDURE fn_get_sexo_paciente(v_sexo       NUMBER,
                               v_error      OUT VARCHAR2,
                               p_cursor     OUT SYS_REFCURSOR);




END PKG_OPERACIONES; 