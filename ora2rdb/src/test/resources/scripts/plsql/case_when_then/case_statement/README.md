### Синтаксис case_statement

```sql
case_statement:= 
    {simple_case_statement | searched_case_statement}

simple_case_statement:=
    [ <<label>> ] 
    CASE selector 
        WHEN (selector_value | dangling_predicate) [, selector_value | dangling_predicate ...] THEN statement ; [statement ;...]; 
       [WHEN (selector_value | dangling_predicate) [, selector_value | dangling_predicate ...] THEN statement ; [statement ;...]...]
       [ELSE statement ; [statement;...]] 
    END CASE [label] ;
  
  
searched_case_statement:=
    [ <<label>> ] 
    CASE
        WHEN boolean_expression THEN statement ; [ statement ;... ]
       [WHEN boolean_expression THEN statement ; [ statement ;... ]...]
       [ELSE statement ; [ statement ;... ]]
    END CASE [label];
```

В RDB существует только CASE как условное выражение, которое дает возможность выбрать результирующее значение из множества различных выражений
Однако, в Oracle есть и CASE как условное выражение и CASE как switch case
----------------------------------------------------------------
### [searched_case](searched_case)

Для эмуляции ораклового поведения, необходимо преобразовать простое выражение CASE в IF ELSE:

RDB:
Если ни одного совпадения не было найдено, выбрасывается исключение CASE_NOT_FOUND
```sql
CREATE EXCEPTION CASE_NOT_FOUND
    'CASE not found while executing CASE statement';
```

```sql
	ELSE BEGIN
		EXCEPTION CASE_NOT_FOUND;
	END
```
----------------------------------------------------------------