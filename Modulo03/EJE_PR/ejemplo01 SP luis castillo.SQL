create or replace 
procedure       sp_ImporteCuota(p_prestamo in number, p_interes in number, p_cuota out number)

is
begin 
--proceso
p_cuota := (p_prestamo * (p_interes/100)) + p_prestamo;

end;