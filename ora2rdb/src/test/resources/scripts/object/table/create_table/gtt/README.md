**GLOBAL TEMPORARY TABLES** представляют собой таблицы, которые создаются для отдельных сессий или транзакций Oracle

---------------------------------------------------------

### [create_global_temporary_table_default_on_commit.sql](create_global_temporary_table_default_on_commit.sql)

По умолчанию стоит **ON COMMIT DELETE ROWS**

То есть данные удаляются после завершения транзакции или сессии 

---------------------------------------------------------


### [create_global_temporary_table_delete_rows.sql](create_global_temporary_table_delete_rows.sql)

**ON COMMIT DELETE ROWS** - данные удаляются после завершения транзакции или сессии 

---------------------------------------------------------

### [create_global_temporary_table_preserve_rows.sql](create_global_temporary_table_preserve_rows.sql)


**ON COMMIT PRESERVE ROWS** -  данные удалятся только после завершения сессии пользователем

---------------------------------------------------------
