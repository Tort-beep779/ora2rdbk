### [returning_clause.sql](returning_clause.sql)

    { RETURN | RETURNING } ( [ OLD | NEW ] expr [ , [ OLD | NEW ] expr ]... )
    INTO  data_item [ , data_item ]...

Согласно [статье](https://oracle-base.com/articles/23/dml-returning-clause-enhancements-23) 

RETURNING clause появился в версии 23ai. 
Однако на 21 версии возможно выполнить RETURNING , но не дает выполнить
RETURNING OLD/NEW value

-------------------------------------------------

### [error_log.sql](error_log.sql)

    LOG ERRORS
    [ INTO [schema.] table ]
    [ (simple_expression) ]
    [ REJECT LIMIT { integer | UNLIMITED } ]

----------------------------------------------

### [order_by_clause.sql](order_by_clause.sql)

    ORDER [ SIBLINGS ] BY
        { expr | position | c_alias }
        [ ASC | DESC ]
        [ NULLS FIRST | NULLS LAST ]
        [, { expr | position | c_alias }
        [ ASC | DESC ]
        [ NULLS FIRST | NULLS LAST ]
        ]...

