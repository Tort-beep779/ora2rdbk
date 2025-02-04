/* Процедура */
CREATE PROCEDURE P_Grade_meaning6 (grade CHAR, res OUT CHAR)
IS
  pass BOOLEAN := TRUE;
BEGIN
    IF grade = 'A' THEN
      res := 'Excellent';
      pass := TRUE;
    ELSE
      IF (grade = 'B') THEN
        res := 'Very Good';
        pass := TRUE;
      ELSE
        IF grade = 'C' THEN
          res := 'Good';
          pass := TRUE;
        ELSE
          IF grade = 'D' THEN
            res := 'Fair';
            pass := FALSE;
          ELSE
            IF grade = 'F' THEN
              res := 'Poor';
              pass := FALSE;
            ELSE
              res := 'Error';
              pass := FALSE;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
END; 

/* Функция */
CREATE FUNCTION F_Grade_meaning6 (grade CHAR)
RETURN VARCHAR2
IS
  pass BOOLEAN := TRUE;
  res  CHAR(15) := '';
BEGIN
    IF grade = 'A' THEN
      res := 'Excellent';
      pass := TRUE;
    ELSE
      IF (grade = 'B') THEN
        res := 'Very Good';
        pass := TRUE;
      ELSE
        IF grade = 'C' THEN
          res := 'Good';
          pass := TRUE;
        ELSE
          IF grade = 'D' THEN
            res := 'Fair';
            pass := FALSE;
          ELSE
            IF grade = 'F' THEN
              res := 'Poor';
              pass := FALSE;
            ELSE
              res := 'Error';
              pass := FALSE;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
    RETURN res;
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Grade_meaning6
AS 
   FUNCTION PF_Grade_meaning6 (grade CHAR) 
   RETURN VARCHAR2;
   PROCEDURE PP_Grade_meaning6 (grade CHAR, res OUT CHAR); 
END Pack_Grade_meaning6; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning6
AS 
   FUNCTION PF_Grade_meaning6 (grade CHAR) 
   RETURN VARCHAR2
   IS
     pass BOOLEAN := TRUE;
     res  CHAR(15) := '';
   BEGIN
       IF grade = 'A' THEN
         res := 'Excellent';
         pass := TRUE;
       ELSE
         IF (grade = 'B') THEN
           res := 'Very Good';
           pass := TRUE;
         ELSE
           IF grade = 'C' THEN
             res := 'Good';
             pass := TRUE;
           ELSE
             IF grade = 'D' THEN
               res := 'Fair';
               pass := FALSE;
             ELSE
               IF grade = 'F' THEN
                 res := 'Poor';
                 pass := FALSE;
               ELSE
                 res := 'Error';
                 pass := FALSE;
               END IF;
             END IF;
           END IF;
         END IF;
       END IF;
       RETURN res;
   END; 

   PROCEDURE PP_Grade_meaning6 (grade CHAR, res OUT CHAR)
   IS
     pass BOOLEAN := TRUE;
   BEGIN
       IF grade = 'A' THEN
         res := 'Excellent';
         pass := TRUE;
       ELSE
         IF (grade = 'B') THEN
           res := 'Very Good';
           pass := TRUE;
         ELSE
           IF grade = 'C' THEN
             res := 'Good';
             pass := TRUE;
           ELSE
             IF grade = 'D' THEN
               res := 'Fair';
               pass := FALSE;
             ELSE
               IF grade = 'F' THEN
                 res := 'Poor';
                 pass := FALSE;
               ELSE
                 res := 'Error';
                 pass := FALSE;
               END IF;
             END IF;
           END IF;
         END IF;
       END IF;
   END; 
END Pack_Grade_meaning6; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Grade_meaning6
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
    grade CHAR;
    pass CHAR(1) := 'T';
    res  CHAR(15) := '';
BEGIN
   grade := :NEW.mark;
   IF grade = 'A' THEN
     res := 'Excellent';
     pass := 'T';
   ELSE 
     IF (grade = 'B') THEN
       res := 'Very Good';
       pass := 'T';
     ELSE
       IF grade = 'C' THEN
         res := 'Good';
         pass := 'T';
       ELSE
         IF grade = 'D' THEN
           res := 'Fair';
           pass := 'F';
         ELSE 
           IF grade = 'F' THEN
             res := 'Poor';
             pass := 'F';
           ELSE
             res := 'Error';
             pass := 'F';
           END IF;
         END IF;
       END IF;
     END IF;
   END IF;        
END T_Grade_meaning6;

/* Анонимный блок */
DECLARE
   pass BOOLEAN := TRUE;
   res  CHAR(15) := '';
   grade  CHAR(1) := 'B';
BEGIN
    IF grade = 'A' THEN
      res := 'Excellent';
      pass := TRUE;
    ELSE
      IF (grade = 'B') THEN
        res := 'Very Good';
        pass := TRUE;
      ELSE
        IF grade = 'C' THEN
          res := 'Good';
          pass := TRUE;
        ELSE
          IF grade = 'D' THEN
            res := 'Fair';
            pass := FALSE;
          ELSE
            IF grade = 'F' THEN
              res := 'Poor';
              pass := FALSE;
            ELSE
              res := 'Error';
              pass := FALSE;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
END; 