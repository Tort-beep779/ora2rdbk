CREATE TRIGGER TR_TURTLES_BUE
AFTER DELETE
ON TURTLES
FOR EACH ROW
BEGIN
 NULL;
END;