-- Warning: this is a row trigger
create or ALTER trigger tr_turtles_bue
before insert
on turtles
AS
BEGIN
    IF (new.name = 'Сплинтер' and old.essence = 'Крыса' and new.essence = 'Сэнсэй') THEN
        DBMS_OUTPUT.PUT_LINE('update turtles');
END;