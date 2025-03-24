CREATE TRIGGER TRG_DDL
AFTER CREATE OR ALTER OR DROP ON SCHEMA
DECLARE
  sql_text ora_name_list_t;
  n PLS_INTEGER;
  v_stmt VARCHAR2(2000);
BEGIN
  n := ora_sql_txt(sql_text);

  FOR i IN 1..n LOOP
    v_stmt := v_stmt || sql_text(i);
  END LOOP;
END;