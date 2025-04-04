-- если атрибут authid не указан , по умолчанию в ORACLE стоит definer. В РБД invoker
-- соответственно если атрибут authid не указан, при конвертации надо прописать SQL SECURITY DEFINER

language_c
-- удаляется

### [DETERMENISTIC.sql](DETERMENISTIC.sql)

**DETERMINISTIC** — определяет функцию как детерминированную, то есть возвраща-
емое значение полностью определяется значениями ее аргументов. Если вклю-
чить эту секцию, ядро SQL сможет оптимизировать выполнение функции при
ее вызове в запросах.

---------------------------------------------------

### [EDITIONABLE_function.sql](EDITIONABLE_function.sql)

    [ EDITIONABLE | NONEDITIONABLE ]

Specifies whether the function is an editioned or noneditioned object
**Default:** EDITIONABLE.

---------------------------------------------------

### [function_with_ACCESSIBLE_BY_clause.sql](function_with_ACCESSIBLE_BY_clause.sql)


ограничивает доступ к процедуре программными модулями, перечисленными в круглых скобках.

Ожидамеый результат для теста 

    /*
    THERE WAS ACCESSIBLE BY OPERATOR , WHICH IS NOT SUPPORTED IN RED DATABASE
    */
    CREATE FUNCTION TOP_PROTECTED_F RETURNS NUMERIC(34, 8)
    SQL SECURITY DEFINER
    AS
    BEGIN
    
    END;

---------------------------------------------------
## Права выполнения функции

### [function_with_authid_CURRENT_USER.sql](function_with_authid_CURRENT_USER.sql) и [function_with_authid_DEFINER.sql](function_with_authid_DEFINER.sql)

**AUTHID CURRENT_USER** определяет, что функция будет вызываться с правами вызывающего пользователя

Аналог в Ред База Данных

    SQL SECURITY INVOKER



**AUTHID DEFINER** определяет, что функция будет вызываться с правами создателя

    SQL SECURITY DEFINER

### Важно

По умолчанию функция в ORACLE вызывается с правами создателя (DEFINER) , а в Ред База Данных
с правами вызывающего пользователя (INVOKER)

Соответственно, если атрибут **AUTHID** не указан, то при конвертации надо добавить **SQL SECURITY DEFINER**


---------------------------------------------------

### [language_C.sql](language_C.sql)

Определяет фукнцию, написанную на языке С

---------------------------------------------------

### [language_java.sql](language_java.sql)

Определяет функцию, написанную на языке Java 

---------------------------------------------------

### [PARALLEL_ENABLE_clause.sql](PARALLEL_ENABLE_clause.sql)

**PARALLEL_ENABLE** — используется для оптимизации и позволяет функции выполнять-
ся параллельно в случае, когда она вызывается из команды SELECT

---------------------------------------------------
### [pipelined_function.sql](pipelined_function.sql)

**PIPELINED** — указывает, что результат табличной функции должен возвращаться
в итеративном режиме с помощью команды PIPE ROW.
---------------------------------------------------
### [RESULT_CACHE_function.sql](RESULT_CACHE_function.sql)

**RESULT_CACHE** — указывает, что входные значения и результат вызова функции дол-
жен быть сохранен в кэше результатов

---------------------------------------------------

### [function_with_aggregate_clause.sql](function_with_aggregate_clause.sql)

[AGGREGATE Clause](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/AGGREGATE-clause.html#GUID-2ED21240-E45A-4982-B674-CF0E1BE0985B__AGGREGATE_CLAUSE-4E74B298:~:text=14.2-,AGGREGATE%20Clause,-Identifies%20the%20function)

[Using User-Defined Aggregate Functions](https://docs.oracle.com/en/database/oracle/oracle-database/23/addci/using-user-defined-aggregate-functions.html#GUID-D7E77319-DC23-4CF0-B746-27ED7BE9240D:~:text=12-,Using%20User%2DDefined%20Aggregate%20Functions,-User%2Ddefined%20aggregate)

AGGREGATE — используется при определении агрегатных функций.

    AGGREGATE USING [ schema. ] implementation_type

### [function_with_default_collation_clause.sql](function_with_default_collation_clause.sql)


[DEFAULT COLLATION Clause](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/DEFAULT-COLLATION-clause.html#GUID-453FC0EA-7B83-407B-A991-87A48017B358__DEFAULT_COLLATION_CLAUSE-FE9CA794:~:text=14.20-,DEFAULT%20COLLATION%20Clause,-Collation%20(also%20called))

The default collation of a procedure, function, package, type, or trigger must be **USING_NLS_COMP**

The default_collation_clause explicitly declares the default collation of a PL/SQL unit to be USING_NLS_COMP. Without this clause, the unit inherits its default collation from the effective schema default collation. If the effective schema default collation is not USING_NLS_COMP, the unit is invalid.


[Пример](https://dbamarco.wordpress.com/2017/06/13/default-collation-and-plsql/)

