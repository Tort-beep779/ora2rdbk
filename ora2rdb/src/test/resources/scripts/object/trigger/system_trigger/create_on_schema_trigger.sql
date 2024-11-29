CREATE TRIGGER trg_after_create_table
AFTER CREATE ON SCHEMA
BEGIN
    DBMS_OUTPUT.PUT_LINE('Создана новая ddl в схеме hr: ' || ORA_DICT_OBJ_NAME);  -- конвертация системных переменных: https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-triggers.html#GUID-266DBF6D-AA74-490C-ADE5-962C10708C2D:~:text=Table%2010%2D5%20System%2DDefined%20Event%20Attributes
END;
/