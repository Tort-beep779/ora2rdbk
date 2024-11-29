create or replace TRIGGER t
  before INSERT
ON TURTLES
  follows t2
BEGIN
      DBMS_OUTPUT.PUT_LINE('trigger t is worked');
END;

create or replace TRIGGER t2
  before INSERT
ON TURTLES
BEGIN
    DBMS_OUTPUT.PUT_LINE('trigger t2 is worked');
END;