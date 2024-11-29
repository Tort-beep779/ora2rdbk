create or replace trigger comp_test
for insert or update or delete on emp_test
compound trigger
  before statement is
    begin
      DBMS_OUTPUT.PUT_LINE('before statement');
    end  before statement;
end;