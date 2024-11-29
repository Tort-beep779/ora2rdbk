create or replace trigger tr_turtles_bue
after delete
on turtles
begin
 DBMS_OUTPUT.PUT_LINE('update turtles');
end;