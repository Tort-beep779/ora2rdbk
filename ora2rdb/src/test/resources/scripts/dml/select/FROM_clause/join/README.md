## JOIN
Средства соединения таблиц (JOIN) позволяют выбрать данные из нескольких источников (таб-лиц, представлений, хранимых процедур и др.).

### [cross_apply_clause.sql](cross_apply_clause.sql)

Соединяет таблицу с подзапросом. 
Запрос **CROSS APPLY**  из примера вернет 

     DEPARTMENT_NAME                EMPLOYEE_ID LAST_NAME
    ------------------------------ ----------- -------------------------
    Marketing                      201         Hartstein
    Marketing                      202         Fay
    Public Relations               204         Baer 

**OUTER APPLY** запрос вернет 

    DEPARTMENT_NAME                EMPLOYEE_ID LAST_NAME
    ------------------------------ ----------- -------------------------
    Marketing                      201         Hartstein
    Marketing                      202         Fay
    Operations
    Public Relations               204         Baer

### [join_with_query_partition_clause.sql](join_with_query_partition_clause.sql)

The result of a partitioned outer join is a UNION of the outer joins of each of the partitions in the partitioned result set and the table on the other side of the join. This type of result is useful for filling gaps in sparse data, which simplifies analytic calculations.

[ссылка](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/SELECT.html#GUID-CFA006CA-6FF1-4972-821E-6996142A51C6__I2177515:~:text=999%20Zeuss%0A%20%20%20%20%20%20%20%20%20%20%20%20Grant-,Using%20Partitioned%20Outer%20Joins%3A%20Examples,-The%20following%20example) на пример из документации 



