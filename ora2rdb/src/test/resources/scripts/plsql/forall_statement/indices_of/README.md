**INDICES OF** — эта секция используется в том случае, если у вас имеется коллекция (назовем
ее индексным массивом), строки которой определяют, какие строки основного массива
(из команды DML FORALL) должны обрабатываться. Иначе говоря, если элемент в позиции N не определен в индексном массиве, то команда FORALL должна проигнорировать
элемент в позиции N основного массива.


### Пример использования INDICES OF

Допустим, я хочу обновить оклады некоторых работников значением 10 000. В настоящее
время таких значений в таблице нет:

    SQL> SELECT employee_id FROM employees WHERE salary = 10000;
    
    no rows selected

.

    DECLARE
        TYPE employee_aat IS TABLE OF employees.employee_id%TYPE
        INDEX BY PLS_INTEGER;
    
        l_employees           employee_aat;
    
        TYPE boolean_aat IS TABLE OF BOOLEAN
        INDEX BY PLS_INTEGER;
    
    l_employee_indices   boolean_aat;
    BEGIN
        l_employees (1) := 7839;
        l_employees (100) := 7654;
        l_employees (500) := 7950;
    --
        l_employee_indices (1) := TRUE;
        l_employee_indices (500) := TRUE;
        l_employee_indices (799) := TRUE;
    --
    FORALL l_index IN INDICES OF l_employee_indices
    BETWEEN 1 AND 500
        UPDATE employees
        SET salary = 10000
        WHERE employee_id = l_employees (l_index);
    END;

После выполнения кода я выдаю запрос, который показывает, что в таблице были обновлены всего две строки — строка работника с идентификатором 7654 была пропущена,
потому что в позиции 100 таблицы индексов элемент не определен:

    SQL> SELECT employee_id FROM employee
            WHERE salary = 10000;

    EMPLOYEE_ID
    -----------
        7839
        7950

