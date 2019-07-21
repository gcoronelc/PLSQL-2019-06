CREATE OR REPLACE PACKAGE BODY PKG_OPERACIONES IS
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
)

is
 
Begin

   v_id_paciente := sec_pacientes.nextval;
   insert into sig_tm_pacientes
          (id_paciente,tip_documento,num_documento,nombres,ape_paterno,ape_materno,sexo,direccion)
   values
          (v_id_paciente, v_ti_documento, v_nu_documento,v_nombres ,v_ap_paterno, v_ap_materno, v_sexo,v_direccion);

v_error:='0';
Exception
      When others then
   v_error:= SQLERRM;
End;


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
  )  
  is
Begin

 update sig_tm_pacientes
    set nombres = v_nombres,
        ape_paterno = v_ap_paterno,
        ape_materno = v_ap_materno,
        num_documento=v_nu_documento,
        tip_documento=v_ti_documento,
        sexo=v_sexo,
        direccion=v_direccion      
  where id_paciente = v_id_paciente;
 

v_error:='0';
Exception
      When others then
   v_error:= '1';
End;

PROCEDURE sp_elimina_paciente(v_id_paciente in number,v_error out varchar2)
is
Begin
delete sig_tm_pacientes
 where id_paciente = v_id_paciente;
  

v_error:='0';
Exception
      When others then
   v_error:= '1';
End;
/*
FUNCTION fn_get_doc_paciente(v_nu_documento IN VARCHAR2) RETURN NUMBER IS
ID number;
BEGIN
  SELECT nombres,ape_paterno,ape_materno,direccion INTO ID
  FROM sig_tm_pacientes
  WHERE num_documento=v_nu_documento; 
RETURN ID; 
EXCEPTION 
  WHEN OTHERS THEN 
    RETURN 0;
END fn_get_doc_paciente;
*/

PROCEDURE fn_get_sexo_paciente(v_sexo       NUMBER,
                               v_error      OUT VARCHAR2,
                               p_cursor     OUT SYS_REFCURSOR) IS 
BEGIN
  OPEN p_cursor FOR
  SELECT nombres,ape_paterno,ape_materno,direccion
  FROM sig_tm_pacientes
  WHERE sexo = v_sexo;
  v_error:='0000';
  EXCEPTION
        WHEN OTHERS THEN
        v_error:=SQLERRM;
END fn_get_sexo_paciente;



END PKG_OPERACIONES; 