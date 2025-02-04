/* Процедура */
CREATE PROCEDURE P_Grade_meaning7(score NUMERIC(34, 8), subject VARCHAR(32765))
AS
  DECLARE pass BOOLEAN = TRUE;
  DECLARE res  CHAR(15) = '';
BEGIN
    IF (:score > 50) THEN
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
        ELSE 
          IF (:subject = 'Физика') THEN
          BEGIN
            res = 'Good';
            pass = TRUE;
          END
          ELSE 
            IF (:subject = 'Информатика') THEN
            BEGIN
              res = 'Good';
              pass = TRUE;
            END
    ELSE
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Poor';
            pass = FALSE;
        END
        ELSE 
          IF (:subject = 'Физика') THEN
          BEGIN
            res = 'Poor';
            pass = FALSE;
          END     
END;

/* Функция */
CREATE FUNCTION P_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR(32765))
RETURNS VARCHAR(32765)
AS
   DECLARE pass BOOLEAN = TRUE;
   DECLARE res  CHAR(15) = '';
BEGIN
    IF (:score > 50) THEN
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
        ELSE 
          IF (:subject = 'Физика') THEN
          BEGIN
            res = 'Good';
            pass = TRUE;
          END
          ELSE 
            IF (:subject = 'Информатика') THEN
            BEGIN
              res = 'Good';
              pass = TRUE;
            END
    ELSE
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Poor';
            pass = FALSE;
        END
        ELSE 
          IF (:subject = 'Физика') THEN
          BEGIN
            res = 'Poor';
            pass = FALSE;
          END
    RETURN res;
END;

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Grade_meaning7
AS 
BEGIN 
   FUNCTION PF_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR(32765))
   RETURNS VARCHAR(32765);  
   PROCEDURE PP_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR(32765));  
  END /*Pack_Grade_meaning7*/;

/* Тело пакета */
RECREATE PACKAGE BODY Pack_Grade_meaning7
AS 
BEGIN 
   FUNCTION PF_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR(32765))
   RETURNS VARCHAR(32765)
   AS
     DECLARE pass BOOLEAN = TRUE;
     DECLARE res  CHAR(15) = '';
   BEGIN
     IF (:score > 50) THEN
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
        ELSE 
          IF (:subject = 'Физика') THEN
          BEGIN
            res = 'Good';
            pass = TRUE;
          END
          ELSE 
          IF (:subject = 'Информатика') THEN
          BEGIN
            res = 'Good';
            pass = TRUE;
          END
     ELSE
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Poor';
            pass = FALSE;
        END
        ELSE 
          IF (:subject = 'Физика') THEN
          BEGIN
            res = 'Poor';
            pass = FALSE;
          END      
     RETURN res;
   END  

   PROCEDURE PP_Grade_meaning7(score NUMERIC(34, 8), subject VARCHAR(32765))
   AS
      DECLARE pass BOOLEAN = TRUE;
      DECLARE res  CHAR(15) = '';
   BEGIN
     IF (:score > 50) THEN
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
        ELSE 
          IF (:subject = 'Физика') THEN
          BEGIN
            res = 'Good';
            pass = TRUE;
          END
     ELSE 
       IF (:subject = 'Информатика') THEN
       BEGIN
         res = 'Good';
         pass = TRUE;
       END
       ELSE
         IF (:subject = 'Математика') THEN
         BEGIN
           res = 'Poor';
           pass = FALSE;
         END
         ELSE 
           IF (:subject = 'Физика') THEN
           BEGIN
             res = 'Poor';
             pass = FALSE;
           END      
   END  
END /*Pack_Grade_meaning7*/;

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Grade_meaning7
  AFTER INSERT
  ON students
AS
    DECLARE score NUMERIC(34, 8);
    DECLARE pass CHAR(1) = 'T';
    DECLARE res  CHAR(15) = '';
    DECLARE subject VARCHAR(50) = 'Математика';
BEGIN
   score = NEW.score;
   IF (:score > 50) THEN
      IF (:subject = 'Математика') THEN
      BEGIN
          res = 'Good';
          pass = 'T';
      END
      ELSE 
        IF (:subject = 'Физика') THEN
        BEGIN
          res = 'Good';
          pass = 'T';
        END
        ELSE 
          IF (:subject = 'Информатика') THEN
          BEGIN
            res = 'Good';
            pass = 'T';
          END 
   ELSE
      IF (:subject = 'Математика') THEN
      BEGIN
          res = 'Poor';
          pass = 'F';
      END
      ELSE 
        IF (:subject = 'Физика') THEN
        BEGIN
          res = 'Poor';
          pass = 'F';
        END
END /*T_Grade_meaning7*/;

/* Анонимный блок */
EXECUTE BLOCK 
AS 
   DECLARE pass BOOLEAN = TRUE;
   DECLARE res  CHAR(15) = '';
   DECLARE score NUMERIC(34, 8) = '40';
   DECLARE subject VARCHAR(50) = 'Математика';
BEGIN
   IF (:score > 50) THEN
      IF (:subject = 'Математика') THEN
      BEGIN
          res = 'Good';
          pass = TRUE;
      END
      ELSE 
        IF (:subject = 'Физика') THEN
        BEGIN
          res = 'Good';
          pass = TRUE;
        END
        ELSE 
          IF (:subject = 'Информатика') THEN
          BEGIN
            res = 'Good';
            pass = TRUE;
          END
   ELSE
      IF (:subject = 'Математика') THEN
      BEGIN
          res = 'Poor';
          pass = FALSE;
      END
      ELSE 
        IF (:subject = 'Физика') THEN
        BEGIN
          res = 'Poor';
          pass = FALSE;
        END    
END;
