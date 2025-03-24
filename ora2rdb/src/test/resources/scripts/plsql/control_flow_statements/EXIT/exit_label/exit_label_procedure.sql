CREATE PROCEDURE P_Exit_Label
IS
  x NUMBER := 0;
BEGIN
  <<loop1>>
  LOOP
    x := x + 1;
    IF x > 4 THEN
      EXIT loop1;
    END IF;
  END LOOP;
END;