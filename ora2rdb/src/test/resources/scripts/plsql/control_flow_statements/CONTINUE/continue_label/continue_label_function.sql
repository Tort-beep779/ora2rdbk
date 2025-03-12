CREATE FUNCTION F_Continue_Label
RETURN VARCHAR2
IS
  x NUMBER := 0;
BEGIN
  <<loop1>>
  LOOP
    x := x + 1;
    IF x < 3 THEN
      CONTINUE loop1;
    END IF;
    EXIT WHEN x = 5;
  END LOOP;
  RETURN '';
END;