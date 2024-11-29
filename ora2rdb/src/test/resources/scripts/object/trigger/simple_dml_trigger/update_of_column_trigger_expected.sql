-- Warning: this is a row trigger
create or ALTER trigger tr_turtles_bue
before update
        on turtles
AS
BEGIN
IF (NEW.essence <> OLD.essence) THEN
 DBMS_OUTPUT.PUT_LINE('update turtles');
END;