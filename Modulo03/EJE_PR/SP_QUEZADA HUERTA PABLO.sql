create or replace procedure scott.sp_cuota(
p_prestamo in number,
p_interes in number,
p_cuota out number
)
is 
begin 
--Proceso
p_cuota:=(p_prestamo/p_interes)+ p_prestamo;
end;create or replace procedure scott.sp_cuota(
p_prestamo in number,
p_interes in number,create or replace procedure scott.sp_cuota(
p_prestamo in number,
p_interes in number,
p_cuota out number
)
is 
begin 
--Proceso
p_cuota:=((p_interes/100) * p_prestamo) + p_prestamo ;
end;
p_cuota out number
)
is 
begin 
--Proceso
p_cuota:=(100/p_interes)+ p_prestamo;
end;