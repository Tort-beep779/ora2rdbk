CREATE GLOBAL TEMPORARY TABLE sals_T_Fetch_Bulk_Collect_Limit (
    K INTEGER,
    VAL NUMERIC(10,2),
    CONSTRAINT PK_sals PRIMARY KEY (K)
) ON COMMIT PRESERVE ROWS;

CREATE TRIGGER T_Fetch_Bulk_Collect_Limit
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
AS
  /* TYPE numtab IS TABLE OF employees.salary%TYPE INDEX BY PLS_INTEGER; */

  DECLARE c1 CURSOR FOR (SELECT salary FROM employees WHERE salary > 10000 ORDER BY last_name);
  
  /* sals numtab; */
  DECLARE sals_var TYPE OF COLUMN employees.salary;
  DECLARE seq_fetch integer;
  DECLARE limit_fetch integer;
BEGIN
  DELETE FROM sals_T_Fetch_Bulk_Collect_Limit WHERE K <> 0;  
  OPEN c1;
  FETCH c1 INTO sals_var;  
  seq_fetch = 1;
  limit_fetch = 4;
  WHILE ( ROW_COUNT != 0 ) DO 
  BEGIN
    INSERT INTO sals_T_Fetch_Bulk_Collect_Limit(K, VAL) VALUES (seq_fetch, sals_var);
    seq_fetch = seq_fetch + 1;
    if (seq_fetch > limit_fetch) then leave;
    FETCH c1 INTO sals_var;
  END
  CLOSE c1;
END;