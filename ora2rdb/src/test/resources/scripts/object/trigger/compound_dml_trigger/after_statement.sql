create or replace trigger comp_test
for insert or update or delete on emp_test
    compound trigger
    after statement is begin
        DBMS_OUTPUT.PUT_LINE('before statement');
    end after statement;
end;