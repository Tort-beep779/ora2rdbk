CREATE PACKAGE PackF_Sqlbulk_Rowcount_Stepped
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Sqlbulk_Rowcount_Stepped 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Sqlbulk_Rowcount_Stepped
AS BEGIN
   FUNCTION PF_Sqlbulk_Rowcount_Stepped
   RETURNS VARCHAR(32765)
   AS
      /*
        TYPE NumList IS VARRAY(3) OF NUMBER;
        depts NumList := NumList(10,20,30);
        DECLARE tmp INTEGER; 
      */
      BEGIN
      /*
        FORALL i IN 1..3  
          UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
        tmp := SQL%BULK_ROWCOUNT(3);
      */
     RETURN '';
   END
END;