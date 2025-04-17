CREATE TABLE incremented_values (n NUMBER);

CREATE OR REPLACE TRIGGER compounder FOR
   UPDATE OR INSERT OR DELETE
   ON incremented_values
   COMPOUND TRIGGER
    v_global_var   NUMBER := 1;
   BEFORE STATEMENT
   IS
   BEGIN
      DBMS_OUTPUT.put_line ('Compound:BEFORE S:' || v_global_var);
      v_global_var := v_global_var + 1;
   END
   BEFORE STATEMENT;
   BEFORE EACH ROW
   IS
   BEGIN
      DBMS_OUTPUT.put_line ('Compound:BEFORE R:' || v_global_var);
      v_global_var := v_global_var + 1;
   END
   BEFORE EACH ROW;
   AFTER EACH ROW
   IS
   BEGIN
      DBMS_OUTPUT.put_line ('Compound:AFTER  R:' || v_global_var);
      v_global_var := v_global_var + 1;
   END
   AFTER EACH ROW;
   AFTER STATEMENT
   IS
   BEGIN
      DBMS_OUTPUT.put_line ('Compound:AFTER  S:' || v_global_var);
      v_global_var := v_global_var + 1;
   END
   AFTER STATEMENT;
END;