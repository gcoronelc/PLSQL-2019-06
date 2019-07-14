/*
¿Que es una TX?


*/


select * from eureka.cuenta where chr_cuencodigo='00100002';

select * from eureka.movimiento where chr_cuencodigo='00100002';


call EUREKA.usp_egcc_retiro('00100002', 4100.00, '0001', '123456' );





