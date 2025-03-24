CREATE TRIGGER T_Sqlbulk_Rowcount_Indices
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  depts intvec_t := intvec_t(3 => 10, 22 => 20, 55 => 30);
  tmp PLS_INTEGER;
BEGIN
  FORALL i IN INDICES OF depts  
    UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
  tmp := SQL%BULK_ROWCOUNT(55);
END;