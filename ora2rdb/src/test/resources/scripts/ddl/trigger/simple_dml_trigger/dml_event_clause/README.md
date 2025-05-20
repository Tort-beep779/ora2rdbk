### Синтаксис    

    { DELETE | INSERT | UPDATE [ OF column [, column ]... ] }
    [ OR { DELETE | INSERT | UPDATE [ OF column [, column]... ] }...
    ON [ schema.] { table | view }

Триггер может сработать на следующие DML события: update/delete/insert

В ORACLE дополнительно можно указать столбец
**UPDATE OF column** 
при обновлении которого сработает триггер. 

В ред база данных это можно сконвртировать так 

    -- WARNING: THIS IS A ROW TRIGGER
    CREATE TRIGGER TR_TURTLES_BUE
    BEFORE UPDATE
    ON TURTLES
    SQL SECURITY DEFINER
    AS
    BEGIN
        IF (NEW.ESSENCE <> OLD.ESSENCE) THEN BEGIN
    
        END
    
    END;

То есть "обернуть" тело триггера в  оператор IF  

