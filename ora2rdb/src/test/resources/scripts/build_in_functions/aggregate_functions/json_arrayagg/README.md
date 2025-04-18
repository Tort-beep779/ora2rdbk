    JSON_ARRAYAGG
        ( expr [ FORMAT JSON ]  [ order_by_clause ]
            [ JSON_on_null_clause ] [ JSON_agg_returning_clause ]
            [ STRICT ]
        )

Функция **JSON_ARRAYAGG** позволяет создать массив JSON путём агрегирования данных SQL

----------------------------------

**FORMAT JSON**

Use this optional clause to indicate that the input string is JSON, and will therefore not be quoted in the output.

------------------------------------------

**order_by_clause**

This clause allows you to order the JSON values within the JSON array returned by the statement. Refer to the order_by_clause in the documentation on SELECT for the full semantics of this clause.

------------------------------------------

**NULL ON NULL** - If you specify this clause, then the function returns the JSON null value.

**ABSENT ON NULL** - If you specify this clause, then the function omits the value from the JSON array. This is the default.

ABSENT ON NULL - по умолчанию в обеих СУБД

------------------------------------------

**STRICT**

Specify the STRICT clause to verify that the output of the JSON generation function is correct JSON. If the check fails, a syntax error is raised.