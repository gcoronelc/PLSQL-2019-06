
create or replace procedure scott.pr115 
is 
  cursor c_emp is select * from scott.emp; 
  r scott.emp%rowtype; 
begin 
  open c_emp; 
  
  loop 
  
    fetch c_emp into r; 
    
    exit when c_emp%notfound; 
    
    dbms_output.put_line(r.empno || ' - ' || r.ename); 
    
  end loop; 
  
  close c_emp; 
end; 
/


call scott.pr115();


create or replace procedure scott.pr115 
( p_cursor out nocopy sys_refcursor )
is 
begin
  open p_cursor for
  select * from scott.emp;
end;
/


declare
  v_cursor sys_refcursor;
  r        scott.emp%rowtype; 
begin 
  scott.pr115 ( v_cursor );
  loop 
    fetch v_cursor into r; 
    exit when v_cursor%notfound; 
    dbms_output.put_line(r.empno || ' - ' || r.ename); 
  end loop; 
  close v_cursor; 
end; 
/

