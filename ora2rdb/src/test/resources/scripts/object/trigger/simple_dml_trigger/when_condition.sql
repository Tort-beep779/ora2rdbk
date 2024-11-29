create or replace trigger tr_turtles_bue
before insert
on turtles
when (
 new.name = 'Сплинтер' and old.essence = 'Крыса' and new.essence = 'Сэнсэй'
)
begin
 DBMS_OUTPUT.PUT_LINE('update turtles');
end;