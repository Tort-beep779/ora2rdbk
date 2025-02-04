EXECUTE block  AS
    declare dream_salary type of column employee.salary;
	declare full_name varchar(50) ; -- подмуать каким типом инитиализировать подобные переменные
BEGIN
FOR
    SELECT first_name || ' ' || last_name AS full_name,
       salary * 10                    AS dream_salary
    FROM employee
    into :full_name, :dream_salary  DO BEGIN
        full_name = 'UNKNOWN';
        dream_salary = 0;
    END
END;