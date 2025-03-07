CREATE SEQUENCE seq_for_recs_NestTable_1;
CREATE GLOBAL TEMPORARY TABLE recs_NestTable_1 (ID BIGINT COMPUTED(GEN_ID(seq_for_recs_NestTable_1, 1)), last_name VARCHAR(15), salary NUMERIC(10,2)) ON COMMIT PRESERVE ROWS;

EXECUTE BLOCK
AS
  DECLARE c1 CURSOR FOR (SELECT last_name, salary FROM employees WHERE salary > 10000 ORDER BY last_name);
  
  /* TYPE RecList IS TABLE OF c1%ROWTYPE; */
  /* recs RecList; */
  DECLARE recs_var TYPE OF TABLE c1;
BEGIN
  DELETE FROM recs_NestTable_1 WHERE ID <> 0;  
  execute  statement ('SET GENERATOR seq_for_recs_NestTable_1 TO 0') WITH AUTONOMOUS TRANSACTION;
  OPEN c1;
  FETCH c1 INTO recs_var;  
  WHILE ( ROW_COUNT != 0 ) DO 
  BEGIN
    INSERT INTO recs_NestTable_1 (last_name, salary) VALUES (recs_var.last_name, recs_var.salary);
    FETCH c1 INTO recs_var;
  END
  CLOSE c1;
END;