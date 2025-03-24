CREATE TRIGGER T_Sqlbulk_Rowcount_Values
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
AS
/*
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  depts intvec_t := intvec_t(30 => 10, 10 => 20, 20 => 30);
  DECLARE tmp INTEGER;
*/
BEGIN
/*
  FORALL i IN VALUES OF depts  
    UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
  tmp := SQL%BULK_ROWCOUNT(30);
*/
END;