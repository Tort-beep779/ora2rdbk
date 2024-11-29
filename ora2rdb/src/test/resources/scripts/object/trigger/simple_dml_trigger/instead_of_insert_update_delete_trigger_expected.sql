-- Warning: this is a row trigger
CREATE OR ALTER TRIGGER t
  BEFORE
    INSERT OR
    UPDATE OR
    DELETE
ON v
AS BEGIN
    IF (INSERTING) THEN
      RDB$TRACE_MSG('insert into orders' , false);
    IF (UPDATING) THEN
     RDB$TRACE_MSG('update orders' , false);
    IF (DELETING) THEN
      RDB$TRACE_MSG('delete from orders' , false);
END;