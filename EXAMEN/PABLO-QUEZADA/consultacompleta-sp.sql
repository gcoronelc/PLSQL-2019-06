create or replace procedure listaticket
(                             
v_error             OUT VARCHAR2,
p_cursor            OUT SYS_REFCURSOR) IS 
BEGIN
  OPEN p_cursor FOR
  SELECT tk.num_ticket,tk.fec_emision,et.nom_establecimiento,pc.nombres,pc.ape_paterno,pc.ape_materno,tp.nombre,tk.precio from sig_tc_tickets tk 
inner join sig_tm_establecimientos et on et.id_establecimiento=tk.id_establecimiento
inner join sig_tm_pacientes pc on pc.id_paciente=tk.id_paciente
inner join sig_tm_tipo_pago tp on tp.id_tipo_pago=tk.id_tipo_pago;
  v_error:='0000';
  EXCEPTION
        WHEN OTHERS THEN
        v_error:=SQLERRM;

end;
/

call listaticket;


create or replace procedure sp_inserta_det_ticket(      
                                      v_num_ticket          NUMBER,
                                      v_id_consultorio      NUMBER,
                                      v_precio              NUMBER,
                                      v_error            OUT VARCHAR2)
is

Begin

   insert into sig_td_detalles
          (id_detalle,num_ticket,id_consultorio,precio)
   values
          (sec_det_tickets.nextval, v_num_ticket, v_id_consultorio,
          v_precio);
   v_error:='0000';   

COMMIT;
Exception
      When others then
   v_error:= SQLERRM;
      COMMIT;
End;


select * from sig_td_detalles