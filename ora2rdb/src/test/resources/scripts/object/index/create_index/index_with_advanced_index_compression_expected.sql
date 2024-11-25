CREATE INDEX emp_mndp_ix
    ON employees(manager_id, department_id)
     IN TABLESPACE PRIMARY ;