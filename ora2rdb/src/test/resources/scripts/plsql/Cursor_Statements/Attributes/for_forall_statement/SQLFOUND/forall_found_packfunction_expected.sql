CREATE PACKAGE PackF_Forall_Found
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Forall_Found 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Forall_Found
AS BEGIN
   FUNCTION PF_Forall_Found
   RETURNS VARCHAR(32765)
   AS
      /*
        TYPE NumList IS VARRAY(3) OF NUMBER;
        depts NumList := NumList(10,20,40);
        DECLARE tmp BOOLEAN; 
      */
      BEGIN
      /*
        FORALL i IN 1..3  
          UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
        tmp := SQL%FOUND;
      */
     RETURN '';
   END
END;