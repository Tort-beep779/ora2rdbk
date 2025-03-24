CREATE EXCEPTION CUSTOM_EXCEPTION 'error';

CREATE TRIGGER T_Isopen
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
AS
  DECLARE c1 CURSOR FOR
    (SELECT last_name, salary
     FROM employees
     WHERE salary > 10000
     ORDER BY last_name);

  DECLARE tmp INTEGER;
  DECLARE c1_isopen BOOLEAN = FALSE;
BEGIN
  OPEN c1;
  c1_isopen = TRUE;
  IF (:tmp is NULL)
  THEN
    EXCEPTION CUSTOM_EXCEPTION( 'Неправильное целочисленное значение');
  CLOSE c1;
  c1_isopen = FALSE;
  /*EXCEPTION*/
  WHEN ANY DO
  BEGIN
    IF (c1_isopen)
    THEN CLOSE c1; 
  END
END;