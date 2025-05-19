/* The mixed index (functional and by column) is not supported in RDB
CREATE INDEX EMP_TOTAL_SAL_IDX
    ON EMPLOYEES (12 * SALARY * COMMISSION_PCT, SALARY, COMMISSION_PCT);*/