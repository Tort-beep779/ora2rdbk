CREATE OR REPLACE FUNCTION fDelete (
   file IN VARCHAR2) RETURN NUMBER
AS LANGUAGE JAVA
      NAME 'JDelete.delete (java.lang.String) return int';
