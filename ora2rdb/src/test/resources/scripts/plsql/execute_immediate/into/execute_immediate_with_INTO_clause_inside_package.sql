CREATE OR REPLACE PACKAGE call_pckg
AS
    PROCEDURE test_p;
    FUNCTION test_f RETURN BOOLEAN;
END;

CREATE OR REPLACE PACKAGE BODY call_pckg
AS
    FUNCTION test_f
            RETURN BOOLEAN
        IS
        emp_name VARCHAR2(50);
        emp_salary NUMBER;
    BEGIN
        EXECUTE IMMEDIATE 'SELECT first_name, salary FROM employees WHERE employee_id = 142'
        INTO emp_name, emp_salary;
        return true;
    END;

    PROCEDURE test_p
    IS
        emp_name VARCHAR2(50);
        emp_salary NUMBER;
    BEGIN
        EXECUTE IMMEDIATE 'SELECT first_name, salary FROM employees WHERE employee_id = 142'
        INTO emp_name, emp_salary;
    END;
END;
