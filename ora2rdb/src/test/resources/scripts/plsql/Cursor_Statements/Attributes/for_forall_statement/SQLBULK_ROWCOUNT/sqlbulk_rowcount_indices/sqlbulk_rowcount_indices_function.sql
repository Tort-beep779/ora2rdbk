CREATE FUNCTION F_Sqlbulk_Rowcount_Indices
RETURN VARCHAR2
IS
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  depts intvec_t := intvec_t(3 => 10, 22 => 20, 55 => 30);
  tmp PLS_INTEGER;
BEGIN
  FORALL i IN INDICES OF depts  
    UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
  tmp := SQL%BULK_ROWCOUNT(55);
  RETURN '';
END;