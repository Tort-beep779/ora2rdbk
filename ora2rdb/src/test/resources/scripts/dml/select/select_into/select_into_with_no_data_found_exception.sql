CREATE OR REPLACE PROCEDURE "PROCEDURE_1"
as
    v_employee_name VARCHAR2(100);
    v_employee_salary NUMBER;
begin
     SELECT employee_name, salary
     INTO v_employee_name, v_employee_salary
     FROM employees;
end PROCEDURE_1;