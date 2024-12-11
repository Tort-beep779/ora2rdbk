CREATE FUNCTION degree
   RETURN NUMBER
   authid definer
   IS
BEGIN
    null;
END;

-- если атрибут authid не указан , по умолчанию в ORACLE стоит definer. В РБД invoker
-- соответственно если атрибут authid не указан, при конвертации надо прописать SQL SECURITY DEFINER