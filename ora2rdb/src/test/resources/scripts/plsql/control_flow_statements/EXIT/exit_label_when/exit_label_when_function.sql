CREATE FUNCTION F_Exit_Label_When
RETURN VARCHAR2
IS
  x NUMBER := 0;
BEGIN
  <<while1>>
  WHILE (x != 5) LOOP
    x := x + 1;
    EXIT while1 WHEN x > 4;
  END LOOP;
  RETURN '';
END;