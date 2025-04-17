CREATE PROCEDURE P_Cursorvar_Notfound
IS
  c1 SYS_REFCURSOR;   
  v1 employees%ROWTYPE;
  TYPE t_c2 IS REF CURSOR;
  c2 t_c2; 
  v2 test_table%ROWTYPE;
  res PLS_INTEGER := 0;
BEGIN
    OPEN c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
    FETCH c1 INTO v1;
    OPEN c2 FOR SELECT * FROM test_table;
    FETCH c2 INTO v2;
    IF c1%NOTFOUND THEN res := res + 1;
    END IF;
    IF c2%NOTFOUND THEN res := res + 10;
    END IF;
    CLOSE c1;
    CLOSE c2;
END;