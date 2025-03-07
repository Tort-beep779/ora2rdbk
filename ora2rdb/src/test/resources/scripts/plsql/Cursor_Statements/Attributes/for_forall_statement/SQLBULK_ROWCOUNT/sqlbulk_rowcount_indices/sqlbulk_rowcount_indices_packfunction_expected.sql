CREATE PACKAGE PackF_Sqlbulk_Rowcount_Indices
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Sqlbulk_Rowcount_Indices 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Sqlbulk_Rowcount_Indices
AS BEGIN
   FUNCTION PF_Sqlbulk_Rowcount_Indices
   RETURNS VARCHAR(32765)
   AS
     /*
       TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
       depts intvec_t := intvec_t(3 => 10, 22 => 20, 55 => 30);
       DECLARE tmp INTEGER;
     */
   BEGIN
     /*
       FORALL i IN INDICES OF depts  
         UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
       tmp := SQL%BULK_ROWCOUNT(55);
     */
     RETURN '';
   END
END;