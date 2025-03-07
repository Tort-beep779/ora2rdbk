CREATE TRIGGER T_Cursorvar_Found
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
AS
  /* c1 SYS_REFCURSOR; */
  DECLARE v1 TYPE OF TABLE employees;
  /* TYPE t_c2 IS REF CURSOR; */
  /* c2 t_c2; */
  DECLARE v2 TYPE OF TABLE test_table;
  DECLARE res INTEGER = 0;
BEGIN
  /* OPEN c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER'; */
  /* FETCH c1 INTO v1; */
  /* OPEN c2 FOR SELECT * FROM test_table; */
  /* FETCH c2 INTO v2; */
  /* IF c1%FOUND THEN res := res + 1; */
  /* END IF; */
  /* IF c2%FOUND THEN res := res + 10; */
  /* END IF; */
  /* CLOSE c1; */
  /* CLOSE c2; */
END;