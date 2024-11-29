-- compound instead of trigger. Можно создать только для пресдтавления
-- и только с разделом instead of
CREATE OR REPLACE TRIGGER "HR"."COMP_TEST"
for insert or update or delete
              on v
                  compound trigger
    INSTEAD OF EACH ROW IS BEGIN
        DBMS_OUTPUT.PUT_LINE('instead of  each row');
    END INSTEAD OF EACH ROW;
end;