CREATE SEQUENCE seq_for_names_PP_Fetch_Bulk_Collect;
CREATE GLOBAL TEMPORARY TABLE names_PP_Fetch_Bulk_Collect (ID BIGINT COMPUTED(GEN_ID(seq_for_names_PP_Fetch_Bulk_Collect, 1)), VAL VARCHAR(15)) ON COMMIT PRESERVE ROWS;

CREATE SEQUENCE seq_for_sals_PP_Fetch_Bulk_Collect;
CREATE GLOBAL TEMPORARY TABLE sals_PP_Fetch_Bulk_Collect (ID BIGINT COMPUTED(GEN_ID(seq_for_sals_PP_Fetch_Bulk_Collect, 1)), VAL NUMERIC(10,2)) ON COMMIT PRESERVE ROWS;

CREATE PACKAGE PackP_Fetch_Bulk_Collect
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Fetch_Bulk_Collect;
END;

CREATE PACKAGE BODY PackP_Fetch_Bulk_Collect
AS BEGIN
   PROCEDURE PP_Fetch_Bulk_Collect
   AS
     /* TYPE NameList IS TABLE OF employees.last_name%TYPE; */
     /* TYPE SalList IS TABLE OF employees.salary%TYPE; */

     DECLARE c1 CURSOR FOR (SELECT last_name, salary FROM employees WHERE salary > 10000 ORDER BY last_name);
    
     /* names  NameList; */
     /* sals   SalList; */
     DECLARE names_var TYPE OF COLUMN employees.last_name;
     DECLARE sals_var TYPE OF COLUMN employees.salary;
   BEGIN
     DELETE FROM names_PP_Fetch_Bulk_Collect WHERE ID <> 0;  
     execute  statement ('SET GENERATOR seq_for_names_PP_Fetch_Bulk_Collect TO 0') WITH AUTONOMOUS TRANSACTION;
     DELETE FROM sals_PP_Fetch_Bulk_Collect WHERE ID <> 0;  
     execute  statement ('SET GENERATOR seq_for_sals_PP_Fetch_Bulk_Collect TO 0') WITH AUTONOMOUS TRANSACTION;
     OPEN c1;
     FETCH c1 INTO names_var, sals_var;  
     WHILE ( ROW_COUNT != 0 ) DO 
     BEGIN
       INSERT INTO names_PP_Fetch_Bulk_Collect(VAL) VALUES (names_var);
       INSERT INTO sals_PP_Fetch_Bulk_Collect(VAL) VALUES (sals_var);
       FETCH c1 INTO names_var, sals_var;
     END
     CLOSE c1;
   END
END;