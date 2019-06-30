-- Desbloquear SCOTT

connect system/oracle

alter user scott 
identified by tiger
account unlock;


connect scott/tiger


-- Desbloquear HR

connect system/oracle

alter user hr 
identified by hr
account unlock;


connect hr/hr


