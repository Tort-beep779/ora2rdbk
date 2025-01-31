## ALL / FIRST / ELSE clauses

### ALL 

Значение по умолчанию. Если указан **ALL** , то бд выполнит каждый **WHEN**, который удовлетворяет условию 

Пример конвертации в тесте [insert_ALL_with_conditional.sql](insert_ALL_with_conditional.sql)

-------------------

### FIRST 

Если указан этот идентификатор, то бд выполнит только первый when, который удоавлетворяет условию 

Пример в тесте [insert_FIRST.sql](insert_FIRST.sql)

-----------

### ELSE 

Выполнится , если не один из WHEN не удовлетворяет условию 

Пример в тесте [insert_ALL_ELSE.sql](insert_ALL_ELSE.sql)







