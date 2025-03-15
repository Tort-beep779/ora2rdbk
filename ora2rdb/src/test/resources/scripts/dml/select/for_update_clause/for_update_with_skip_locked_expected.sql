/* В настоящее время оператор FOR UPDATE не делает то, что от него ожидается. См. документацию */
SELECT employee_id, last_name from employees
    FOR UPDATE /*skip locked*/;
