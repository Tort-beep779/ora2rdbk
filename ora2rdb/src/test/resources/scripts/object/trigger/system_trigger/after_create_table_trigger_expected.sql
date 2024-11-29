CREATE TRIGGER trg_after_create_table
    AFTER CREATE TABLE
AS BEGIN
    RDB$TRACE_MSG('Создана новая таблица: ' ||  RDB$GET_CONTEXT ('DDL_TRIGGER','OBJECT_NAME'), false);
END;