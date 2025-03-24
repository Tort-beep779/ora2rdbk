CREATE PACKAGE PackP_Rowcount_Primitive
AS
    PROCEDURE PP_Rowcount_Primitive;
END;

CREATE PACKAGE BODY PackP_Rowcount_Primitive
AS
    PROCEDURE PP_Rowcount_Primitive
    IS
      CURSOR c1 IS
        SELECT last_name, salary
        FROM employees
        WHERE salary > 10000
        ORDER BY last_name;

     recs c1%ROWTYPE;
     res BOOLEAN := FALSE;
   BEGIN
     OPEN c1;
     FETCH c1 INTO recs;  
     IF c1%ROWCOUNT > 0 THEN res := TRUE;
     end if;
     CLOSE c1;
   END;
END;