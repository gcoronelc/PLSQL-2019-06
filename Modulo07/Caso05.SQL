

begin

  -- create table scott.algo( field1 varchar2(100) );
  insert into scott.emp( empno, ename )
  values( 8888, 'Gustavo' );

end;
/

select * from scott.emp;


begin

  execute immediate 'create table scott.algo( field1 varchar2(100) )';
  
end;
/


create or replace procedure 
scott.pr107( cmd varchar2) 
is 
begin 
  execute immediate cmd; 
end; 
/


call scott.pr107('create view scott.v_demo as select * from scott.emp');




create or replace procedure scott.pr112(empno number) 
is 
begin 
  delete from scott.emp where empno = empno; 
end;
/


select * from scott.emp;

call scott.pr112( 567789 );

select * from scott.emp;


create or replace procedure scott.pr112(empno number) 
is 
begin 
  delete from scott.emp where empno = scott.pr112.empno; 
end;
/

select * from scott.emp;

call scott.pr112( 567789 );

select * from scott.emp;

call scott.pr112( 7839 );

select * from scott.emp;
