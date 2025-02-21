/* Процедура */
CREATE PROCEDURE P_For_With_When
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR power IN 2, REPEAT power*2 WHEN MOD(power, 32)= 0 
  LOOP
    if power > 64 then exit; end if;
    summa := summa + power;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_For_With_When
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR power IN 2, REPEAT power*2 WHEN MOD(power, 32)= 0 
  LOOP
    if power > 64 then exit; end if;
    summa := summa + power;
  END LOOP;
  RETURN summa;  
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_For_With_When
AS 
   FUNCTION PF_For_With_When
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_When; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_For_With_When
AS 
   FUNCTION PF_For_With_When
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR power IN 2, REPEAT power*2 WHEN MOD(power, 32)= 0 
     LOOP
       if power > 64 then exit; end if;
       summa := summa + power;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_When
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR power IN 2, REPEAT power*2 WHEN MOD(power, 32)= 0 
     LOOP
       if power > 64 then exit; end if;
       summa := summa + power;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_For_With_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR power IN 2, REPEAT power*2 WHEN MOD(power, 32)= 0 
  LOOP
    if power > 64 then exit; end if;
    summa := summa + power;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
   FOR power IN 2, REPEAT power*2 WHEN MOD(power, 32)= 0 
   LOOP
      if power > 64 then exit; end if;
      summa := summa + power;
   END LOOP;
END; 