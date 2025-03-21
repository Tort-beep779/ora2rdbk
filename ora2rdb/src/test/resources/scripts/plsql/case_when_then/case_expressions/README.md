### Синтаксис case_expressions

```sql
Синтаксис СУБД Oracle 23
case_expressions:= 
    { simple_case_expressions | searched_case_expressions }

simple_case_expressions:=
    CASE selector
        WHEN { selector_value | dangling_predicate }[ ,{ selector_value | dangling_predicate }... ] THEN result
       [WHEN { selector_value | dangling_predicate }[ ,{ selector_value | dangling_predicate }... ] THEN result ...]
       [ELSE else_result]
    END
  
searched_case_expressions:=
    CASE
        WHEN boolean_expression THEN result
       [WHEN boolean_expression THEN result ...]
       [ELSE result]
    END
```

Пример использования Simple CASE Expression c Dangling Predicates (Доступно только в версии 23):
```sql
DECLARE
    data_val NUMBER := 30;
    status VARCHAR2(20);
BEGIN
    status :=
	CASE data_val/2
		WHEN < 0, > 50 THEN 'outlier'
		WHEN BETWEEN 10 AND 30 THEN 'good'
		ELSE 'bad'
	END;
	DBMS_OUTPUT.PUT_LINE('The data status is: ' || status);
END;
```
Пример использования Simple CASE Expression cо списком выражений (Доступно только в версии 23):
```sql
DECLARE
    salary NUMBER := 7000;
    salary_level VARCHAR2(20);
BEGIN
    salary_level :=
	CASE salary
		WHEN 1000, 2000 THEN 'low'
		WHEN 3000, 4000, 5000 THEN 'normal'
		WHEN 6000, 7000, 8000 THEN 'high'
		ELSE 'executive pay'
	END;
	DBMS_OUTPUT.PUT_LINE('Salary level is: ' || salary_level);
END;
```
----------------------------------------------------------------

### [simple_case_list_dangling_predicate](simple_case_list_dangling_predicate)

```sql
CASE selector
    WHEN { selector_value | dangling_predicate }[ ,{ selector_value | dangling_predicate }... ] THEN result
```
```sql
CASE salary
  WHEN < 10, 20, 30, 40, > 50 THEN 'outlier'
```
Операторы selector_values и dangling_predicates оцениваются последовательно. Если значение a selector_value равно значению selector   
или dangling_predicate равно true, то выполняется statement связанный с этим оператор selector_value или dangling_predicate, и CASE оператор завершается.  
Любые последующие операторы selector_values и dangling_predicates не оцениваются.

Для эмуляции ораклового поведения, необходимо преобразовать простое выражение CASE в поисковое выражение, как показано в тестах: 
*  [simple_case_list_dangling_predicate](simple_case_list_dangling_predicate)
*  [simple_case_list_dangling_predicate_and_selector_value](simple_case_list_dangling_predicate_and_selector_value)
*  [simple_case_list_selector_value](simple_case_list_selector_value)

Синтаксис обновился относительно недавно, поэтому в грамматике отсутствует такая конструкция, из-за чего парсер не может обработать строку.  
Нужно обновить грамматику для `case when then`

----------------------------------------------------------------
