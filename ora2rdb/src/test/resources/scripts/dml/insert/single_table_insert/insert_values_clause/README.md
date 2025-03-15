### [insert_into_a_table_with_error_logging.sql](insert_into_a_table_with_error_logging.sql)

Позволяет логировать ошибки DML и сохранять их в отдельную таблицу 

    INSERT INTO table_name [(column1 [, column2, ...])]
    { VALUES (value1 [, value2, ...]) | subquery }
    [ LOG ERRORS [ INTO error_logging_table ]
    [ (simple_expression) ]
    [ REJECT LIMIT { integer | UNLIMITED } ]
    ];

--------------

### [insert_with_returning_clause.sql](insert_with_returning_clause.sql)

Оператор RETURNING позволяет вернуть значения вставленных столбцов 


    INSERT INTO table_name [(column1 [, column2, ...])]
    { VALUES (value1 [, value2, ...]) | subquery }
    RETURNING expression1 [, expression2, ...]
    INTO variable1 [, variable2, ...];



