/* Процедура */
CREATE PROCEDURE P_Primitive_Repeat
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REPEAT 1
  LOOP
      if summa > 10 then exit; end if;
      summa := summa + i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Primitive_Repeat
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REPEAT 1
  LOOP
      if summa > 10 then exit; end if;
      summa := summa + i;
  END LOOP;
  RETURN summa;
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Primitive_Repeat
AS 
   FUNCTION PF_Primitive_Repeat
   RETURN PLS_INTEGER;
   PROCEDURE PP_Primitive_Repeat; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Primitive_Repeat
AS 
   FUNCTION PF_Primitive_Repeat
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN REPEAT 1
     LOOP
       if summa > 10 then exit; end if;
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Primitive_Repeat
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN REPEAT 1
     LOOP
       if summa > 10 then exit; end if;
       summa := summa + i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Primitive_Repeat
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REPEAT 1
  LOOP
    if summa > 10 then exit; end if;
    summa := summa + i;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REPEAT 1 
  LOOP
    if summa > 10 then exit; end if;
    summa := summa + i;
  END LOOP;
END;