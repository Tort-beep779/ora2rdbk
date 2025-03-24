### Синтаксис  

    SET
    { { (column [, column ]...) = (subquery)
        | column = { expr | (subquery) | DEFAULT }
    }
    [, { (column [, column]...) = (subquery)
        | column = { expr | (subquery) | DEFAULT }
    }
    ]...
        | VALUE (t_alias) = { expr | (subquery) }
    }

----------------------------------------------------------

### [set_multiple_values_using_subquery.sql](set_multiple_values_using_subquery.sql)

Присваивает нескольким столбцам (указанным через запятую) значение из запроса 

----------------------------------------------------------

### [set_DEFAULT_value.sql](set_DEFAULT_value.sql)

Устанавливает значение по умолчанию 

Для таблицы books (синтаксис указан в директории dml_table_expression_clause)
устанавливается значение NULL

