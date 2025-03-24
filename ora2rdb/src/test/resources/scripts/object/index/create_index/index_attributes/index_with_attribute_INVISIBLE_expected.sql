CREATE INDEX emp_name_dpt_ix
    ON employees(last_name, department_id)  IN TABLESPACE PRIMARY ;
ALTER INDEX EMP_NAME_DPT_IX INACTIVE;