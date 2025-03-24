CREATE PACKAGE PackF_Rowcount_Primitive
AS
   FUNCTION PF_Rowcount_Primitive 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Rowcount_Primitive
AS
   FUNCTION PF_Rowcount_Primitive
   RETURN VARCHAR2
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
     RETURN '';
   END;
END;