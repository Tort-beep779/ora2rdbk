CREATE PROCEDURE combine_and_format_names
AUTHID DEFINER
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('procedure triggered');
END;
-- если атрибут authid не указан , по умолчанию в ORACLE стоит definer. В РБД invoker
-- соответственно если атрибут authid не указан, при конвертации надо прописать SQL SECURITY DEFINER