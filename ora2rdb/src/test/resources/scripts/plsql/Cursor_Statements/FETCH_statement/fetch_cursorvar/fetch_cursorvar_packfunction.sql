CREATE PACKAGE PackF_Fetch_Cursorvar
AS
   FUNCTION PF_Fetch_Cursorvar 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Fetch_Cursorvar
AS
   FUNCTION PF_Fetch_Cursorvar
   RETURN VARCHAR2
   IS
     c1 SYS_REFCURSOR;   
     v1 employees%ROWTYPE;
     TYPE t_c2 IS REF CURSOR;
     c2 t_c2; 
     v2 test_table%ROWTYPE;
   BEGIN
     OPEN c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
     FETCH c1 INTO v1;
     CLOSE c1;
     OPEN c2 FOR SELECT * FROM test_table;
     FETCH c2 INTO v2;
     CLOSE c2;
     RETURN '';
   END;
END;