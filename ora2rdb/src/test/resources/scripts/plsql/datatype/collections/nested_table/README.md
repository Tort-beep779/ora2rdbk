## NESTED TABLES
In the database, a nested table is a column type that stores an unspecified number of rows in no particular order.

### Important Differences Between Nested Tables and Arrays
[различия между nested table и varray](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-B8683EF9-B9E5-4DE4-92F3-42C4000B0EF9:~:text=nt.(4)%20%3D%2058%0A%2D%2D%2D-,6.4.1%20Important%20Differences%20Between%20Nested%20Tables%20and%20Arrays,-Conceptually%2C%20a%20nested)

Conceptually, a nested table is like a one-dimensional array with an arbitrary number of elements. However, a nested table differs from an array in these important ways:

An array has a declared number of elements, but a nested table does not. The size of a nested table can increase dynamically.

An array is always dense. A nested array is dense initially, but it can become sparse, because you can delete elements from it.
 
**Отличия от varray:**
- нет ограничения на размер 
- можно удалить элемент из середины (индекс не будет пересчитан). То есть массив становится разреженным

### Методы для работы с коллекцией NESTED TABLE 

#### DELETE 
[документация]( https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-E43509F6-5044-4B17-9516-2EB4BDDD5173:~:text=Example%206%2D23%20DELETE%20Method%20with%20Nested%20Table)

    names.DELETE(2) -- delete second element
    names.DELETE(2,4) -- delete range of element (со второго по четвертый)
    names.DELETE() - delete all elements

#### TRIM 
[документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-6AF582B1-9C50-4858-AE6C-B14DD051ACD1:~:text=Example%206%2D25%20TRIM%20Method%20with%20Nested%20Table)
    
    DECLARE
    nt nt_type := nt_type(11, 22, 33, 44, 55, 66);
    BEGIN
    
    nt.TRIM;       -- Trim last element

    nt.DELETE(4);  -- Delete fourth element

    nt.TRIM(2);    -- Trim last two elements
    
    END;

#### EXTEND
[документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-03F74821-BC33-4544-9304-5FBBE6EFE450:~:text=Example%206%2D26%20EXTEND%20Method%20with%20Nested%20Table)

    DECLARE
    nt nt_type := nt_type(11, 22, 33);
    BEGIN
    print_nt(nt);
    
    nt.EXTEND(2,1);  -- Append two copies of first element
    print_nt(nt);
    
    nt.DELETE(5);    -- Delete fifth element
    print_nt(nt);
    
    nt.EXTEND;       -- Append one null element
    print_nt(nt);
    END;

#### EXISTS
[документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-31E27176-042B-4BA8-8FBC-14CCEDC33095:~:text=Example%206%2D27%20EXISTS%20Method%20with%20Nested%20Table)

    DECLARE
    TYPE NumList IS TABLE OF INTEGER;
    n NumList := NumList(1,3,5,7);
    BEGIN
    n.DELETE(2); -- Delete second element
    
    FOR i IN 1..6 LOOP
    IF n.EXISTS(i) THEN
    DBMS_OUTPUT.PUT_LINE('n(' || i || ') = ' || n(i));
    ELSE
    DBMS_OUTPUT.PUT_LINE('n(' || i || ') does not exist');
    END IF;
    END LOOP;
    END;

#### FIRST AND LAST
[документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-33E18BC6-C0A8-456B-A47C-A4504240D962:~:text=6.10.5.3%20FIRST%20and%20LAST%20Methods%20for%20Nested%20Table)

    DECLARE
    TYPE team_type IS TABLE OF VARCHAR2(15);
    team team_type;
    
    PROCEDURE print_team (heading VARCHAR2) IS
    BEGIN
          FOR i IN team.FIRST..team.LAST LOOP
            ...
            END IF;
          END LOOP;
    END;
    BEGIN
        NULL;
    END;

#### COUNT 
[документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-5700158F-FF45-4964-89B3-1EF614BA3B7D:~:text=Example%206%2D33%20COUNT%20and%20LAST%20Values%20for%20Nested%20Table)

    DECLARE
    TYPE NumList IS TABLE OF INTEGER;
    n NumList := NumList(1,3,5,7);
    
    PROCEDURE print_count_and_last IS
    BEGIN
        DBMS_OUTPUT.PUT('n.COUNT = ' || n.COUNT || ', ');
    END  print_count_and_last;
    
    BEGIN
        NULL;
    END;

#### LIMIT 
 [документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-1E0E1010-FFC5-4F4A-AD87-58BE9CE8146D:~:text=does%20not%20exist-,6.10.7%20LIMIT%20Collection%20Method,-LIMIT%20is%20a)
 
коллекция nested table не имеет лимита 

#### PRIOR AND NEXT 

[документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-FB1216B3-2DC3-48D6-BCEC-243F995BFB09:~:text=Example%206%2D35%20PRIOR%20and%20NEXT%20Methods)

    DECLARE
    TYPE nt_type IS TABLE OF NUMBER;
    nt nt_type := nt_type(18, NULL, 36, 45, 54, 63);
    
    BEGIN
    nt.DELETE(4);
    DBMS_OUTPUT.PUT_LINE('nt(4) was deleted.');
    
    FOR i IN 1..7 LOOP
    DBMS_OUTPUT.PUT('nt.PRIOR(' || i || ') = ');
    DBMS_OUTPUT.PUT_LINE(NVL(TO_CHAR(nt.PRIOR(i)), 'NULL'));
    
        DBMS_OUTPUT.PUT('nt.NEXT(' || i || ')  = ');
        DBMS_OUTPUT.PUT_LINE(NVL(TO_CHAR(nt.NEXT(i)), 'NULL'));
    END LOOP;
    END;
