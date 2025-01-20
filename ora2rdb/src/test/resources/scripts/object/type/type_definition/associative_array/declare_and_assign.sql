DECLARE
TYPE SalaryMap IS TABLE OF NUMBER INDEX BY VARCHAR2(100);

    salaries SalaryMap := SalaryMap('John' => 50000, 'Alice' => 60000, 'Bob' => 55000);
BEGIN
    NULL;
END;