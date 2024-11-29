CREATE OR REPLACE TRIGGER trg_after_create_table
AFTER GRANT ON SCHEMA
BEGIN
    DBMS_OUTPUT.PUT_LINE('Создана новая ddl в схеме hr: ' || ORA_DICT_OBJ_NAME);
END;
/