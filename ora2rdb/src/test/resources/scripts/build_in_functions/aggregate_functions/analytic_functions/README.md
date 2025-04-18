**Аналитическая функция (оконная функция)** -  выполняет вычисления над списком строк в таблице, которые как-то относят-ся екущей строке. 
Это сравнимо с типом вычислений, которые могут быть выполнены с помощью какой-либо агрегатной функции. 
Но в отличие от обычных агрегатных функций, использование оконной функции не заставляет строки группироваться в одну; 
строки сохраняют свои отдельные значения. Другими словами, оконная функция позволяет получить доступ более чем только к текущей строке результата запроса

[Статья про оконные функции](https://thisisdata.ru/blog/uchimsya-primenyat-okonnyye-funktsii/)

[Документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/Analytic-Functions.html#:~:text=Index-,Analytic%20Functions,-Analytic%20functions%20compute)

------------------------------------------------------------

Окно определяется с помощью обязательной инструкции **OVER()**

**PARTITION BY**, которая определяет столбец, по которому будет производиться группировка и является ключевой в разделении набора строк на окна

    PARTITION BY
    { expr[, expr ]...
    | ( expr[, expr ]... )
    }

К предложению PARTITION BY можно добавить **ORDER BY**.

    ORDER [ SIBLINGS ] BY
    { expr | position | c_alias }
    [ ASC | DESC ]
    [ NULLS FIRST | NULLS LAST ]
    [, { expr | position | c_alias }
    [ ASC | DESC ]
    [ NULLS FIRST | NULLS LAST ]
    ]...

Таким образом мы указали, что хотим видеть сумму не всех значений в окне, а для каждого значения с которым работыет функция агрегирования

------------------------------------------------------------

### ROWS | RANGE | GROUPS

    { ROWS | RANGE | GROUPS }
    { BETWEEN
        { UNBOUNDED PRECEDING
        | CURRENT ROW
        | value_expr { PRECEDING | FOLLOWING }
        }
        AND
        { UNBOUNDED FOLLOWING
        | CURRENT ROW
        | value_expr { PRECEDING | FOLLOWING }
        }
    |   { UNBOUNDED PRECEDING
        | CURRENT ROW
        | value_expr PRECEDING
        }
    }
    [ EXCLUDE CURRENT ROW
        | EXCLUDE GROUPS
        | EXCLUDE TIES
        | EXCLUDE NO OTHERS ]


Инструкция **ROWS** позволяет ограничить строки в окне, указывая фиксированное количество строк, предшествующих или следующих за текущей.

Инструкция **RANGE**, в отличие от **ROWS**, работает не со строками, а с диапазоном строк в инструкции ORDER BY.


Обе инструкции **ROWS** и **RANGE** всегда используются вместе с **ORDER BY**.

------------------------------------------------------------

В выражении для ограничения строк ROWS или RANGE или GROUPS также можно использовать следующие ключевые слова:

* **UNBOUNDED PRECEDING** — указывает, что окно начинается с первой строки группы;
* **UNBOUNDED FOLLOWING** – с помощью данной инструкции можно указать, что окно заканчивается на последней строке группы;
* **CURRENT ROW** – инструкция указывает, что окно начинается или заканчивается на текущей строке;
* **BETWEEN** «граница окна» AND «граница окна» — указывает нижнюю и верхнюю границу окна;
* **«Значение» PRECEDING** – определяет число строк перед текущей строкой;
* **«Значение» FOLLOWING** — определяет число строк после текущей строки

------------------------------------------------------------

**GROUPS** разделяет данные по группам на основе предложения ORDER BY

Use GROUPS to specifiy the window frame extent with both ROWS and RANGE characteristics. Like ROWS a GROUPS window can have any number of sort keys, or any ordered types. Like RANGE, 
a GROUPS window does not make cutoffs between adjacent rows with the same values in the sort keys.
------------------------------------------------------------

**EXCLUDE**

You can remove rows, groups, and ties from the window frame with the EXCLUDE options:

* If you specify **EXCLUDE CURRENT ROW**, and the current row in in the window frame, then the current row is removed from the window frame.
* If you specify **EXCLUDE GROUP**, then the current row and any peers of the current row are removed from the window frame.
* If you specify **EXCLUDE TIES**, then the peers of the current row are removed from the window frame. The current row is retained. Note, that if the current row is previously removed from the window frame, it remains removed.
* If you specify **EXCLUDE NO OTHERS**, then no additional rows are removed from the window frame. This is the default option.

