-- Warning: this is a row trigger
create or alter TRIGGER t
  before
    INSERT
  ON TURTLES
  position 1
as BEGIN
      RDB$TRACE_MSG('trigger t is worked'  , false);
END;
-- Warning: this is a row trigger
create or alter TRIGGER t2
  before
    INSERT
  ON TURTLES
  position 0
as BEGIN
      RDB$TRACE_MSG('trigger t2 is worked'  , false);
END;
-- обязательно задать подицию для каждого триггера