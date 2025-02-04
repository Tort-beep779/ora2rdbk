/* Процедура */
CREATE PROCEDURE P_Grade_meaning6 (grade CHAR)
RETURNS (res CHAR)
AS
  DECLARE pass BOOLEAN = TRUE;
BEGIN
    IF (:grade = 'A') THEN
    BEGIN
      res = 'Excellent';
      pass = TRUE;
    END
    ELSE
      IF (:grade = 'B') THEN
      BEGIN
        res = 'Very Good';
        pass = TRUE;
      END
      ELSE
        IF (:grade = 'C') THEN
        BEGIN
          res = 'Good';
          pass = TRUE;
        END
        ELSE
          IF (:grade = 'D') THEN
          BEGIN
            res = 'Fair';
            pass = FALSE;
          END
          ELSE
            IF (:grade = 'F') THEN
            BEGIN
              res = 'Poor';
              pass = FALSE;
            END
            ELSE
            BEGIN
              res = 'Error';
              pass = FALSE;
            END
END;

/* Функция */
CREATE FUNCTION F_Grade_meaning6 (grade CHAR)
RETURNS VARCHAR(32765)
AS
  DECLARE pass BOOLEAN = TRUE;
  DECLARE res  CHAR(15) = '';
BEGIN
    IF (:grade = 'A') THEN
    BEGIN
      res = 'Excellent';
      pass = TRUE;
    END
    ELSE
      IF (:grade = 'B') THEN
      BEGIN
        res = 'Very Good';
        pass = TRUE;
      END
      ELSE
        IF (:grade = 'C') THEN
        BEGIN
          res = 'Good';
          pass = TRUE;
        END
        ELSE
          IF (:grade = 'D') THEN
          BEGIN
            res = 'Fair';
            pass = FALSE;
          END
          ELSE
            IF (:grade = 'F') THEN
            BEGIN
              res = 'Poor';
              pass = FALSE;
            END
            ELSE
            BEGIN
              res = 'Error';
              pass = FALSE;
            END
    RETURN res;
END;

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Grade_meaning6
AS 
BEGIN 
   FUNCTION PF_Grade_meaning6 (grade CHAR)
   RETURNS VARCHAR(32765);  
   PROCEDURE PP_Grade_meaning6 (grade CHAR)
   RETURNS (res CHAR);
END /*Pack_Grade_meaning6*/;

/* Тело пакета */
RECREATE PACKAGE BODY Pack_Grade_meaning6
AS 
BEGIN 
   FUNCTION PF_Grade_meaning6 (grade CHAR)
   RETURNS VARCHAR(32765)
   AS
     DECLARE pass BOOLEAN = TRUE;
     DECLARE res  CHAR(15) = '';
   BEGIN
       IF (:grade = 'A') THEN
       BEGIN
         res = 'Excellent';
         pass = TRUE;
       END
       ELSE
         IF (:grade = 'B') THEN
         BEGIN
           res = 'Very Good';
           pass = TRUE;
         END
         ELSE
           IF (:grade = 'C') THEN
           BEGIN
             res = 'Good';
             pass = TRUE;
           END
           ELSE
             IF (:grade = 'D') THEN
             BEGIN
               res = 'Fair';
               pass = FALSE;
             END
             ELSE
               IF (:grade = 'F') THEN
               BEGIN
                 res = 'Poor';
                 pass = FALSE;
               END
               ELSE
               BEGIN
                 res = 'Error';
                 pass = FALSE;
               END
       RETURN res;
   END  

   PROCEDURE PP_Grade_meaning6 (grade CHAR)
   RETURNS (res CHAR)
   AS
     DECLARE pass BOOLEAN = TRUE;
   BEGIN
       IF (:grade = 'A') THEN
       BEGIN
         res = 'Excellent';
         pass = TRUE;
       END
       ELSE
         IF (:grade = 'B') THEN
         BEGIN
           res = 'Very Good';
           pass = TRUE;
         END
         ELSE
           IF (:grade = 'C') THEN
           BEGIN
             res = 'Good';
             pass = TRUE;
           END
           ELSE
             IF (:grade = 'D') THEN
             BEGIN
               res = 'Fair';
               pass = FALSE;
             END
             ELSE
               IF (:grade = 'F') THEN
               BEGIN
                 res = 'Poor';
                 pass = FALSE;
               END
               ELSE
               BEGIN
                 res = 'Error';
                 pass = FALSE;
               END
   END  
END /*Pack_Grade_meaning6*/;

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Grade_meaning6
  AFTER INSERT
  ON students
AS
    DECLARE grade CHAR;
    DECLARE pass CHAR(1) = 'T';
    DECLARE res  CHAR(15) = '';
BEGIN
   grade = NEW.mark;
   IF (:grade = 'A') THEN
   BEGIN
     res = 'Excellent';
     pass = 'T';
   END
   ELSE
     IF (:grade = 'B') THEN
     BEGIN
       res = 'Very Good';
       pass = 'T';
     END
     ELSE
       IF (:grade = 'C') THEN
       BEGIN
         res = 'Good';
         pass = 'T';
       END
       ELSE
         IF (:grade = 'D') THEN
         BEGIN
           res = 'Fair';
           pass = 'F';
         END
         ELSE
           IF (:grade = 'F') THEN
           BEGIN
             res = 'Poor';
             pass = 'F';
           END
           ELSE
           BEGIN
             res = 'Error';
             pass = 'F';
           END
END /*T_Grade_meaning6*/;

/* Анонимный блок */
EXECUTE BLOCK 
AS 
   DECLARE pass BOOLEAN = TRUE;
   DECLARE res  CHAR(15) = '';
   DECLARE grade  CHAR(1) = 'B';
BEGIN
    IF (:grade = 'A') THEN
    BEGIN
      res = 'Excellent';
      pass = TRUE;
    END
    ELSE
      IF (:grade = 'B') THEN
      BEGIN
        res = 'Very Good';
        pass = TRUE;
      END
      ELSE
        IF (:grade = 'C') THEN
        BEGIN
          res = 'Good';
          pass = TRUE;
        END
        ELSE
          IF (:grade = 'D') THEN
          BEGIN
            res = 'Fair';
            pass = FALSE;
          END
          ELSE
            IF (:grade = 'F') THEN
            BEGIN
              res = 'Poor';
              pass = FALSE;
            END
            ELSE
            BEGIN
              res = 'Error';
              pass = FALSE;
            END
END;
