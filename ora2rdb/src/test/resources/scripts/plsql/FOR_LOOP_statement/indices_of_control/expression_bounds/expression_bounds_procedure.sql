CREATE PROCEDURE P_Expr_Bounds
IS
  reslt PLS_INTEGER := 0; 
  TYPE nested_typ IS TABLE OF varchar2(20); 
  nt1 nested_typ := nested_typ('альфа','бета','гамма'); 
  nt2 nested_typ := nested_typ('бета','гамма','альфа');  
BEGIN 
  FOR i IN INDICES OF nt1 MULTISET UNION nt2 
  LOOP
    reslt := reslt + i;
  END LOOP;
END; 