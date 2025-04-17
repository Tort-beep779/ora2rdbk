CREATE PROCEDURE P_Cursorvar_Isopen
SQL SECURITY DEFINER
AS
/*
   [-unconvertible c1 SYS_REFCURSOR];
   [-unconvertible TYPE t_c2 IS REF CURSOR];
   c2 [-unconvertible t_c2];
   DECLARE tmp INTEGER;
*/
BEGIN
/*
   OPEN [-unconvertible c1] FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
   OPEN [-unconvertible c2] FOR SELECT * FROM test_table;
   IF (:tmp is NULL)
   THEN
      EXCEPTION CUSTOM_EXCEPTION( 'Неправильное целочисленное значение');
   CLOSE [-unconvertible c1];
   CLOSE [-unconvertible c2];
  EXCEPTION
    WHEN ANY DO
    BEGIN
     IF [-unconvertible c1]%ISOPEN
     THEN CLOSE [-unconvertible c1];
     END IF;
     IF [-unconvertible c2]%ISOPEN
     THEN CLOSE [-unconvertible c2];
     END IF;
   END
*/
END;