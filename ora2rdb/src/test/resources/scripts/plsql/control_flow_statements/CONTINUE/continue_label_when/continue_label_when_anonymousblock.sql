DECLARE
  x NUMBER := 0;
BEGIN
  <<while1>>
  WHILE (x != 5) LOOP
    x := x + 1;
    CONTINUE while1 WHEN x < 3;
  END LOOP;
END; 