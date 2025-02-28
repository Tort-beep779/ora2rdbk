### [returning_clause.sql](returning_clause.sql)

    { RETURN | RETURNING } ( [ OLD | NEW ] expr [ , [ OLD | NEW ] expr ]... )
    INTO  data_item [ , data_item ]...

-------------------------------------------------

### [error_log.sql](error_log.sql)

    LOG ERRORS
    [ INTO [schema.] table ]
    [ (simple_expression) ]
    [ REJECT LIMIT { integer | UNLIMITED } ]

