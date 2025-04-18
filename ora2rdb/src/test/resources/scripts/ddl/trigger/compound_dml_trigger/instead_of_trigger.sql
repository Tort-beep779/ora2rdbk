-- compound instead of trigger. Можно создать только для пресдтавления
-- и только с разделом instead of
CREATE OR REPLACE TRIGGER "HR"."COMP_TEST"
FOR INSERT OR UPDATE OR DELETE
    ON V
    COMPOUND TRIGGER
    INSTEAD OF EACH ROW IS BEGIN
        NULL;
    END INSTEAD OF EACH ROW;
END;