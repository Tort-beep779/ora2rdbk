## Set Operators

[ссылка](https://oracle-base.com/articles/misc/sql-for-beginners-set-operators) на статью с описанием 


[Официальная докумнетация](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/The-UNION-ALL-INTERSECT-MINUS-Operators.html#GUID-B64FE747-586E-4513-945F-80CB197125EE)

### UNION

The UNION set operator returns all distinct rows selected by either query. That means any duplicate rows will be removed.

### UNION ALL

The UNION ALL set operator returns all rows selected by either query. That means any duplicates will remain in the final result set.

### INTERSECT

The INTERSECT set operator returns all distinct rows selected by both queries. That means only those rows common to both queries will be present in the final result set

### MINUS

The MINUS set operator returns all distinct rows selected by the first query but not the second. 

### EXCEPT 

You can use EXCEPT or MINUS when you want to exclude a result set from the final result set. In this example, the result of the second query is ignored.
