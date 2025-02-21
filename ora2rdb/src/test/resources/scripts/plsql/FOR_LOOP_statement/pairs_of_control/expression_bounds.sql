/* Процедура */
CREATE PROCEDURE P_Expr_Bounds
IS
  reslt PLS_INTEGER := 0; 
  TYPE nested_typ IS TABLE OF varchar2(20); 
  nt1 nested_typ := nested_typ('альфа','бета','гамма'); 
  nt2 nested_typ := nested_typ('бета','гамма','альфа');  
BEGIN 
  FOR i, j IN PAIRS OF nt1 MULTISET UNION nt2 
  LOOP
    reslt := reslt + i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Expr_Bounds
RETURN varchar2(100)
IS
  reslt PLS_INTEGER := 0; 
  TYPE nested_typ IS TABLE OF varchar2(20); 
  nt1 nested_typ := nested_typ('альфа','бета','гамма'); 
  nt2 nested_typ := nested_typ('бета','гамма','альфа');  
BEGIN 
    FOR i, j IN PAIRS OF nt1 MULTISET UNION nt2 
    LOOP
      reslt := reslt + i;
    END LOOP;
    RETURN reslt; 
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Expr_Bounds
AS 
   FUNCTION PF_Expr_Bounds
   RETURN varchar2(100);
   PROCEDURE PP_Expr_Bounds; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Expr_Bounds
AS 
   FUNCTION PF_Expr_Bounds
   RETURN varchar2(100)
   IS
     reslt PLS_INTEGER := 0; 
     TYPE nested_typ IS TABLE OF varchar2(20); 
     nt1 nested_typ := nested_typ('альфа','бета','гамма'); 
     nt2 nested_typ := nested_typ('бета','гамма','альфа');  
   BEGIN 
     FOR i, j IN PAIRS OF nt1 MULTISET UNION nt2 
     LOOP
       reslt := reslt + i;
     END LOOP;
     RETURN reslt;
   END;

   PROCEDURE PP_Expr_Bounds
   IS
     reslt PLS_INTEGER := 0; 
     TYPE nested_typ IS TABLE OF varchar2(20); 
     nt1 nested_typ := nested_typ('альфа','бета','гамма'); 
     nt2 nested_typ := nested_typ('бета','гамма','альфа');  
   BEGIN 
     FOR i, j IN PAIRS OF nt1 MULTISET UNION nt2 
     LOOP
      reslt := reslt + i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Expr_Bounds
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
    reslt PLS_INTEGER := 0; 
    TYPE nested_typ IS TABLE OF varchar2(20); 
    nt1 nested_typ := nested_typ('альфа','бета','гамма'); 
    nt2 nested_typ := nested_typ('бета','гамма','альфа');  
BEGIN 
    FOR i, j IN PAIRS OF nt1 MULTISET UNION nt2 
    LOOP
      reslt := reslt + i;
    END LOOP;
END;

/* Анонимный блок */
DECLARE
    reslt PLS_INTEGER := 0; 
    TYPE nested_typ IS TABLE OF varchar2(20); 
    nt1 nested_typ := nested_typ('альфа','бета','гамма'); 
    nt2 nested_typ := nested_typ('бета','гамма','альфа');  
BEGIN 
    FOR i, j IN PAIRS OF nt1 MULTISET UNION nt2 
    LOOP
      reslt := reslt + i;
  END LOOP;
END; 
