CREATE PACKAGE PackF_Cursorvar_Found
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Cursorvar_Found 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Cursorvar_Found
AS BEGIN
   FUNCTION PF_Cursorvar_Found
   RETURNS VARCHAR(32765)
   AS
    /*
      [-unconvertible c1 SYS_REFCURSOR];
      DECLARE v1 TYPE OF TABLE employees;
      [-unconvertible TYPE t_c2 IS REF CURSOR];
      c2 [-unconvertible t_c2];
      DECLARE v2 TYPE OF TABLE test_table;
      DECLARE res INTEGER = 0;
    */
    BEGIN
    /*
       OPEN [-unconvertible c1] FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
       FETCH [-unconvertible c1] INTO v1;
       OPEN [-unconvertible c2] FOR SELECT * FROM test_table;
       FETCH [-unconvertible c2] INTO v2;
       IF [-unconvertible c1]%FOUND THEN res := res + 1;
       END IF;
       IF [-unconvertible c2]%FOUND THEN res := res + 10;
       END IF;
       CLOSE [-unconvertible c1];
       CLOSE [-unconvertible c2];
       RETURN '';
    */
   END
END;