create or replace procedure scott.sp_importe_cuota(
  p_capital in number,
  p_tasa in number,
  p_tiempo in number,
  p_importe out number
)
is
begin
  --proceso
  p_importe := (p_capital*p_tasa*p_tiempo)/100;
end;