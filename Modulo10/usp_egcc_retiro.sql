----------------------------------------------------
-- Autor:   Eric Gustavo Coronel Castillo
-- Blog:    gcoronelc.blogspot.com
-- Email:   gcoronelc@gmail.com
-- Youtube: https://goo.gl/9GFBaC
----------------------------------------------------

-- Procedimiento

create or replace procedure EUREKA.usp_egcc_retiro
(  p_cuenta varchar2,   p_importe number, 
   p_empleado varchar2, p_clave varchar2  )
as
  v_msg varchar2(1000);
  v_saldo number(12,2);
  v_moneda char(2);
  v_cont number(5,0);
  v_estado varchar2(15);
  v_costoMov number(12,2);
  v_clave varchar2(10);
  v_excep1 Exception;
begin
	select 	dec_cuensaldo, chr_monecodigo, 
	        vch_cuenestado, chr_cuenclave
	into v_saldo, v_moneda, v_estado, v_clave
	from eureka.cuenta
	where chr_cuencodigo = p_cuenta
	for update;
  -- Pausa (solo para la demostraci�n)
  APEX_UTIL.PAUSE(5);  
  -- Verificaci�n
	if v_estado != 'ACTIVO' then
		raise_application_error(-20001,'Cuenta no esta activa.');
	end if;
	if v_clave != p_clave then
		--raise_application_error(-20001,'Datos incorrectos.');
    raise v_excep1;
	end if;
	select dec_costimporte
		into v_costoMov
		from eureka.costomovimiento
		where chr_monecodigo = v_moneda;
	v_saldo := v_saldo - p_importe - v_costoMov;
	if v_saldo < 0.0 then
		raise_application_error(-20001,'Saldo insuficiente.');
	end if;
  -- Lee el contador
  select  int_cuencontmov into v_cont
	from eureka.cuenta
	where chr_cuencodigo = p_cuenta
	for update;
  -- Actualiza la cuenta
  update eureka.cuenta
		set dec_cuensaldo = v_saldo,
		int_cuencontmov = int_cuencontmov + 2
		where chr_cuencodigo = p_cuenta;
  -- Movimiento de retiro
	v_cont := v_cont + 1;
	insert into eureka.movimiento(chr_cuencodigo,int_movinumero,dtt_movifecha,
		chr_emplcodigo,chr_tipocodigo,dec_moviimporte,chr_cuenreferencia)
		values(p_cuenta,v_cont,sysdate,p_empleado,'004',p_importe,null);
  -- Novimiento Costo
	v_cont := v_cont + 1;
	insert into eureka.movimiento(chr_cuencodigo,int_movinumero,dtt_movifecha,
		chr_emplcodigo,chr_tipocodigo,dec_moviimporte,chr_cuenreferencia)
		values(p_cuenta,v_cont,sysdate,p_empleado,'010',v_costoMov,null);
	-- Confirmar la Tx
	commit;
exception
  when v_excep1 then
    rollback; -- cancelar transacción
    raise_application_error(-20001,'Clave incorrecta.');
  when others then
    v_msg := sqlerrm; -- capturar mensaje de error
    rollback; -- cancelar transacción
    raise_application_error(-20001,v_msg);
end;
/

/*
select * from eureka.cuenta where chr_cuencodigo='00100001';
select * from eureka.movimiento where chr_cuencodigo='00100001';


call EUREKA.usp_egcc_retiro('00100001', 100, '0002', '123456' );


*/