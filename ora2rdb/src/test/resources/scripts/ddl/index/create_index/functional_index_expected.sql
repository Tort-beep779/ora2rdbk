CREATE INDEX emp_total_sal_idx
    ON employees  COMPUTED BY ( 12 * salary * commission_pct ) IN TABLESPACE PRIMARY ;