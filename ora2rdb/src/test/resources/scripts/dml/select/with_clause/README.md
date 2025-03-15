## CTE (COMMON TABLE EXPRESSIONS)

Предложение **WITH** позволяет задать общее общее  табличное  выражение  (CTE). CTE описаны как виртуальные таблицы или представления, определённые в преамбуле основного запроса, которые участвуют в основном запросе.

### [with_clause.sql](with_clause.sql)

Пример стандартного табличного выражения
При конвертации не изменяется

### [with_clause_with_declaration.sql](with_clause_with_declaration.sql)

В ORACLE Database внутри табличного выражения можно объявить процедуру/функцию 

При конвертации функция/процедура создается отдельно 

### [recursive_subquery.sql](recursive_subquery.sql)

[Статья](https://citforum.ru/database/oracle/recursive/)  про рекурсивные запросы в ORACLE DB 
Общее табличное выражение может быть рекурсивным 

При конвертации необходимо добавить ключевое слово **RECURSIVE**

### [search_clause.sql](search_clause.sql)

Для придания порядка строкам результата в запросах