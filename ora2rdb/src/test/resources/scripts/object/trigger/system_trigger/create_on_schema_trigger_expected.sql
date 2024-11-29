create or alter TRIGGER trg_after_create_table
  AFTER ANY DDL STATEMENT
as BEGIN
	IF (RDB$GET_CONTEXT ('DDL_TRIGGER','EVENT_TYPE') = 'CREATE')
	THEN BEGIN
     	 RDB$TRACE_MSG('Создана новая ddl в схеме hr: ' ||  RDB$GET_CONTEXT ('DDL_TRIGGER','OBJECT_NAME'), false);
    END
END;

-- аналогично alter / drop