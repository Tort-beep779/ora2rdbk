-- создание таблицы вместе с error loging table
-- https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/INSERT.html#GUID-903F8043-0254-4EE9-ACC1-CB8AC0AF3423__BCEGDJDJ:~:text=WHERE%20commission_pct%20%3E%200.25%3B-,Inserting%20Into%20a%20Table%20with%20Error%20Logging%3A%20Example,-The%20following%20statements
CREATE TABLE raises (emp_id NUMBER, sal NUMBER
    CONSTRAINT check_sal CHECK(sal > 8000));

EXECUTE DBMS_ERRLOG.CREATE_ERROR_LOG('raises', 'errlog');

-- пример update with error logging
UPDATE raises
SET emp_id = 100, sal = 8001
    LOG ERRORS INTO errlog ('my_bad') REJECT LIMIT 10;