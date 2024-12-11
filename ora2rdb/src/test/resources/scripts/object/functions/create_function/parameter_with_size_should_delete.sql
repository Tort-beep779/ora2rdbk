CREATE OR REPLACE FUNCTION degree(value_in IN NUMBER)
   RETURN NUMBER
   IS res NUMBER(11,2);
BEGIN
      res := value_in * value_in;
RETURN(res);
END;