/*
 составным (compound) триггером, в котором можно написать обработчики для нескольких, или всех четырех, моментов времени:
BEFORE STATEMENT
AFTER STATEMENT
BEFORE EACH ROW
AFTER EACH ROW

Пример использования
 https://torofimofu.blogspot.com/2015/04/dml-oracle-11g.html

 Состаные триггеры не конвертируются явно в ред базу данных. Необходимо предложить пользователю сделать это самостоятельно



 -- В ред база всегда работает для каждой строки (row trigger)
 -- если в триггере не указан for each row - выдается предупреждение



trigger_ordering_clause.sql
 -- обязательно задать подицию для каждого триггера


 -- конвертация системных переменных: в разделе переменные
 https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-triggers.html#GUID-266DBF6D-AA74-490C-ADE5-962C10708C2D:~:text=Table%2010%2D5%20System%2DDefined%20Event%20Attributes

 - Для BEFORE LOGOFF аналог  ON DISCONNECT

 -- Для AFTER STARTUP/ BEFORE SHUTDOWN - TODO : подумать
 -- Для AFTER DB_ROLE_CHANGE / AFTER SERVERERROR / AFTER SUSPEND / AFTER CLONE / BEFORE UNPLUG / [ BEFORE | AFTER ] SET CONTAINER - закомментировать


 Для теста create_on_schema_trigger.sql :  аналогично alter / drop

Для теста : trigger_on_grant_statement.sql
 -- аналогично для TRUNCATE/REVOKE/RENAME/NOAUDIT/DISASSOCIATE STATISTICS/COMMENT/AUDIT/ASSOCIATE STATISTICS/ANALYZE

триггер instead of
 -- триггер созается чтобы сделать не обновляемое представвление обновляемым
 -- instead of триггер может быть создан только на представления

 */