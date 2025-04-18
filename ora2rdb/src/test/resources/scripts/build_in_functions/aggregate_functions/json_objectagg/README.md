
    JSON_OBJECTAGG
        ( [ KEY ] key_expr VALUE val_expr [ JSON_on_null_clause ]
            [ JSON_agg_returning_clause ] [ STRICT ] [ WITH UNIQUE KEYS ]
        )

Функция SQL/JSON **JSON_OBJECTS** - это агрегатная функция. Она принимает в качестве входных данных пару ключ-значение. 
Как правило, ключ и значение  являются столбцами выражений SQL. Эта функция создает объект для каждой пары ключ-значение и возвращает один объект JSON, содержащий эти элементы.

------------------------------------------

**JSON_on_null_clause**

**NULL ON NULL** - When NULL ON NULL is specified, then a JSON NULL value is used as a value for the given key.

**ABSENT ON NULL** - If you specify this clause, then the function omits the property key-value pair from the JSON object.

NULL ON NULL - по умолчанию в обеих СУБД

------------------------------------------

**[KEY] string VALUE expr**  - пара ключ-значение

------------------------------------------

**JSON_agg_returning_clause**

Use this clause to specify the data type of the character string returned by this function.

------------------------------------------

**STRICT**

Specify the STRICT clause to verify that the output of the JSON generation function is correct JSON. If the check fails, a syntax error is raised

------------------------------------------

**WITH UNIQUE KEYS**

Specify WITH UNIQUE KEYS to guarantee that generated JSON objects have unique keys.




