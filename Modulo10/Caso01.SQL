
CREATE OR REPLACE PACKAGE scott.testpackage as 
 
  function suma( n1 in number, n2 in number ) return number; 
  
  function suma( n1 in number, n2 in number, n3 in number ) return number; 
 
END testpackage;
/



CREATE OR REPLACE PACKAGE BODY scott.testpackage as 
 
  function suma( n1 in number, n2 in number ) return number 
  as 
    rtn number; 
  begin 
    rtn := n1 + n2; 
    return rtn; 
  end; 
  
  function suma( n1 in number, n2 in number, n3 number ) return number 
  as 
    rtn number; 
  begin 
    rtn := n1 + n2; 
    return rtn; 
  end; 
  
END testpackage; 




select scott.testpackage.suma( 12,13) from dual; 

select scott.testpackage.suma( 12,13,10) from dual; 




