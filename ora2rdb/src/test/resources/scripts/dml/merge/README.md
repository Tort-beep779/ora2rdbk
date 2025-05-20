## MERGE

Оператор MERGE объединяет данные по условию из одного или нескольких источников для обновления или вставки в таблицу или представление. 

```
    MERGE [ hint ]
        INTO [ schema. ] { table | view } [ t_alias ]
        USING { [ schema. ] { table | view }
                | ( subquery )
                } [ t_alias ]
        ON ( condition )
        [ merge_update_clause ]
        [ merge_insert_clause ]
        [ error_logging_clause ] ;

    merge_update_clause ::= WHEN MATCHED THEN
                                UPDATE SET column = { expr | DEFAULT }
                                        [, column = { expr | DEFAULT } ]...
                                [ WHERE condition ]
                                [ DELETE where_clause ]

    merge_insert_clause ::= WHEN NOT MATCHED THEN
                                INSERT [ (column [, column ]...) ]
                                VALUES ({ expr | DEFAULT }
                                        [, { expr | DEFAULT } ]...
                                       )
                                [ WHERE condition ]
    
    error_logging_clause ::= LOG ERRORS 
                                [ INTO [schema.] table ]
                                [ (simple_expression) ]
                                [ REJECT LIMIT { integer | UNLIMITED } ]           
```

Аналогичный оператор есть в РБД (подредактиронный для конвертации):

```
    MERGE INTO { table | view } [t_alias]
        USING { { table | view }
                | ( subquery )
               } [ t_alias ]
        ON <join-condition>
        <предложение WHEN> [<предложение WHEN> ...]

    
    <предложение WHEN> ::= <предложение WHEN MATCHED>
                         | <предложение WHEN NOT MATCHED>

    <предложение WHEN MATCHED> ::=
            WHEN MATCHED [ AND <доп.условие> ]
            THEN {UPDATE SET <список назначений> | DELETE}

    <предложение WHEN NOT MATCHED> ::=
            WHEN NOT MATCHED [ AND <доп.условие> ]
            THEN INSERT [(<столбцы>)] VALUES (<значения>)
```

<!--
Для тестирования были созданы таблицы:
CREATE TABLE bonuses (employee_id NUMBER, bonus NUMBER DEFAULT 100);
CREATE TABLE bonuses2 (employee_id NUMBER, bonus NUMBER DEFAULT 200);

insert into bonuses(employee_id) values (153);
insert into bonuses(employee_id) values (155);
insert into bonuses(employee_id) values (157);
insert into bonuses(employee_id) values (159);
insert into bonuses(employee_id) values (161);

insert into bonuses2(employee_id) values (153);
insert into bonuses2(employee_id) values (154);
insert into bonuses2(employee_id) values (155);
insert into bonuses2(employee_id) values (156);
insert into bonuses2(employee_id) values (157);
insert into bonuses2(employee_id) values (158);
insert into bonuses2(employee_id) values (159);
insert into bonuses2(employee_id) values (160);
insert into bonuses2(employee_id) values (161);
insert into bonuses2(employee_id) values (162);
insert into bonuses2(employee_id) values (163);
-->

# error_logging.sql

Тестирование предложения LOG ERRORS. Оно позволяет фиксировать ошибки DML и значения столбцов затронутых строк, а также сохранять их в таблице регистрации ошибок.

В РБД предложения, аналогичного LOG ERRORS нет. При конвертации это предложение комментируется.

# using_subquery.sql

Тестирование MERGE с источником - оператором SELECT.

```
    MERGE INTO ...
    USING ( subquery )
    ON ...
```

Конвертация не требуется.

# when_matched_delete.sql

Тестирование MERGE с предложением WHEN MATCHED и дополнительным условием WHERE и DELETE WHERE.

DELETE WHERE указывается, чтобы очистить данные в таблице при ее заполнении или обновлении. **Единственными строками, на которые влияет это предложение, являются те строки в целевой таблице, которые обновляются операцией MERGE**. Условие DELETE WHERE оценивает обновленное значение, а не исходное значение, которое было оценено условием UPDATE SET ... WHERE. Если строка целевой таблицы соответствует условию DELETE, но не включена в соединение, определенное предложением ON, то она не удаляется. 

Корректно конвертировать MERGE с DELETE не получится, не смотря на то, что в РБД тоже доступна операция удаления. Всё дело в том, что для предложений WHEN MATCHED UPDATE и MERGE WHEN NOT MATCHED неуточненные имена столбцов или уточнённые именами таблиц или их псевдонимами понимаются как столбцы с префиксом NEW, для предложений MERGE WHEN MATCHED DELETE – с префиксом OLD.
Таким образом удаляться могут разные множества. Поэтому пересматривать условие удаления лучше вручную.

# when_matched_not_matched.sql

Тестирование MERGE с предложениями WHEN MATCHED и WHEN NOT MATCHED.

# when_matched_where.sql

Тестирование MERGE с предложением WHEN MATCHED и дополнительным условием WHERE.

# when_matched.sql

Тестирование MERGE с предложением WHEN MATCHED 

Если столбец указан без алиаса или названия таблицы, то лучше приписать (соответственно это относится к алиасу цели). Иначе может возьникнуть ошибка на РБД.

# when_not_matched_where.sql

Тестирование MERGE с предложением WHEN NOT MATCHED и дополнительным условием WHERE.

# when_not_matched.sql

Тестирование MERGE с предложением WHEN NOT MATCHED.
Конвертация не требуется.

# with_hint.sql

Тестирование MERGE с подсказкой

```
    MERGE /*+ hint */
        INTO ...
```

или

```
    MERGE --+ hint
        INTO ...
```

Конвертация не требуется потому что подсказки воспринимаются как комментарии
















