EXECUTE BLOCK
AS
  DECLARE c1 CURSOR FOR
    (SELECT last_name, salary
    FROM employees
    WHERE salary > 100000
    ORDER BY last_name);

  DECLARE c2 CURSOR FOR
    (SELECT last_name, salary
    FROM employees
    WHERE salary > 50000
    ORDER BY last_name);

  DECLARE c1_recs TYPE OF TABLE c1;
  DECLARE c2_recs TYPE OF TABLE c2;
  DECLARE res INTEGER = 0;
  DECLARE c1_found BOOLEAN = NULL;
  DECLARE c2_found BOOLEAN = NULL;
BEGIN
  OPEN c1;
  OPEN c2;
  IF ((NOT c1_found) is NULL AND (NOT c2_found) is NULL)
  THEN res = res + 1;
  FETCH c1 INTO c1_recs;  
  c1_found = DECODE(ROW_COUNT, 0, FALSE, TRUE);
  FETCH c2 INTO :c2_recs;  
  c2_found = DECODE(ROW_COUNT, 0, FALSE, TRUE);
  IF ((NOT c1_found) OR (NOT c2_found)) THEN res = res + 10;
  CLOSE c1;
  CLOSE c2;
END;