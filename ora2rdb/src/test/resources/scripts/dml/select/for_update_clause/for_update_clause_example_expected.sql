/* В настоящее время оператор FOR UPDATE не делает то, что от него ожидается. См. документацию */
SELECT emp_no, last_name from employee
    FOR UPDATE;