### [assoc_array_type_definition.sql](assoc_array_type_definition.sql)
Associative Arrays — это набор пар ключ-значение.  
[Документация Oracle Associative Arrays](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/plsql-collections-and-records.html#GUID-8060F01F-B53B-48D4-9239-7EA8461C2170:~:text=collection%2Dtyped%20value.-,5.2%20Associative%20Arrays,-An%20associative%20array)
```sql
TYPE type IS TABLE OF datatype [ NOT NULL ]
INDEX BY { PLS_INTEGER | BINARY_INTEGER | VARCHAR2 ( v_size ) | data_type }
```
Ассоциативный массив может быть индексирован либо строковым типом, либо PLS_INTEGER и BINARY_INTEGER.  
Создать переменную-коллекцию можно одним из следующих способов:
* Определите тип коллекции, а затем объявите переменную этого типа.
```sql
 TYPE type_assoc_array IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(100);
 
 assoc_array_variable type_assoc_array;
```

* Используется %TYPE для объявления переменной коллекции того же типа, что и ранее объявленная переменная коллекции.
```sql
TYPE type_assoc_array IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(100);

assoc_array_variable type_assoc_array;

another_assoc_array_variable assoc_array_variable%TYPE;
```

----------------------------------------------------------------
### [constant_declaration.sql](constant_declaration.sql)
```sql 
constant CONSTANT datatype [NOT NULL] { := | DEFAULT } expression ;
```
[Документация Oracle Constant Declaration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/constant-declaration.html#GUID-C6DA65F8-3F0C-43F3-8BC6-231064E8C1B6__CJAEHEBD)
Константа содержит значение, которое не изменяется. В объявлении константы указывается имя, тип данных и значение константы. Объявление также может иметь ограничение NOT NULL.  
При попытке изменить значение будет получена ошибка:
`PLS-00363: выражение 'CONSTANT_NAME' не м.б. использовано как адресат назначения`


----------------------------------------------------------------
### [cursor_declaration.sql](cursor_declaration.sql)

```sql
CURSOR cursor
  [( cursor_parameter_dec [, cursor_parameter_dec ]... )]
    RETURN rowtype;
```
[Документация Oracle Explicit Cursor Declaration and Definition](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/explicit-cursor-declaration-and-definition.html#GUID-38C5DBA3-9DEC-4AF2-9B5E-7B721D11A77C__CHDHEFBB)
Объявление курсора без тела, обязательно должен иметь возвращаемый тип.
Также у курсора могут быть входные параметры. Пример:
```sql
DECLARE
  CURSOR c (job VARCHAR2, max_sal NUMBER) IS
    SELECT last_name, first_name, (salary - max_sal) overpayment
    FROM employees
    WHERE job_id = job
    AND salary > max_sal
    ORDER BY salary;
 
  PROCEDURE print_overpaid IS
    last_name_   employees.last_name%TYPE;
    first_name_  employees.first_name%TYPE;
    overpayment_      employees.salary%TYPE;
  BEGIN
    LOOP
      FETCH c INTO last_name_, first_name_, overpayment_;
      EXIT WHEN c%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(last_name_ || ', ' || first_name_ ||
        ' (by ' || overpayment_ || ')');
    END LOOP;
  END print_overpaid;
 
BEGIN
  DBMS_OUTPUT.PUT_LINE('----------------------');
  DBMS_OUTPUT.PUT_LINE('Overpaid Stock Clerks:');
  DBMS_OUTPUT.PUT_LINE('----------------------');
  OPEN c('ST_CLERK', 5000);
  print_overpaid; 
  CLOSE c;
 
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  DBMS_OUTPUT.PUT_LINE('Overpaid Sales Representatives:');
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  OPEN c('SA_REP', 10000);
  print_overpaid; 
  CLOSE c;
END;
/
```

----------------------------------------------------------------
### [cursor_definition.sql](cursor_definition.sql)

```sql
CURSOR cursor
 [ ( cursor_parameter_dec [, cursor_parameter_dec ]... )]
   [ RETURN rowtype] IS select_statement ;
```
[Документация Oracle Explicit Cursor Declaration and Definition](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/explicit-cursor-declaration-and-definition.html#GUID-38C5DBA3-9DEC-4AF2-9B5E-7B721D11A77C__CHDHEFBB)

Также у курсора могут быть входные параметры.
```sql
DECLARE
  CURSOR c (job VARCHAR2, max_sal NUMBER) IS
    SELECT last_name, first_name, (salary - max_sal) overpayment
    FROM employees
    WHERE job_id = job
    AND salary > max_sal
    ORDER BY salary;
 
  PROCEDURE print_overpaid IS
    last_name_   employees.last_name%TYPE;
    first_name_  employees.first_name%TYPE;
    overpayment_      employees.salary%TYPE;
  BEGIN
    LOOP
      FETCH c INTO last_name_, first_name_, overpayment_;
      EXIT WHEN c%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(last_name_ || ', ' || first_name_ ||
        ' (by ' || overpayment_ || ')');
    END LOOP;
  END print_overpaid;
 
BEGIN
  DBMS_OUTPUT.PUT_LINE('----------------------');
  DBMS_OUTPUT.PUT_LINE('Overpaid Stock Clerks:');
  DBMS_OUTPUT.PUT_LINE('----------------------');
  OPEN c('ST_CLERK', 5000);
  print_overpaid; 
  CLOSE c;
 
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  DBMS_OUTPUT.PUT_LINE('Overpaid Sales Representatives:');
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  OPEN c('SA_REP', 10000);
  print_overpaid; 
  CLOSE c;
END;
/
```

----------------------------------------------------------------
### [exception_declaration.sql](exception_declaration.sql)
```sql
exception EXCEPTION;
```
[Документация Oracle Exception Declaration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/exception-declaration.html#GUID-AAC8C54F-775C-4E65-B531-0350CFF5B1BD__CJACJGFH)
Пример использования:
```sql
 CREATE PROCEDURE account_status (
  due_date DATE,
  today    DATE
) AUTHID DEFINER
IS
  past_due  EXCEPTION;  -- declare exception
BEGIN
  IF due_date < today THEN
    RAISE past_due;  -- explicitly raise exception
  END IF;
EXCEPTION
  WHEN past_due THEN  -- handle exception
    DBMS_OUTPUT.PUT_LINE ('Account past due.');
END;
/
 
BEGIN
  account_status (TO_DATE('01-JUL-2010', 'DD-MON-YYYY'),
                  TO_DATE('09-JUL-2010', 'DD-MON-YYYY'));
END;
/
 ```

----------------------------------------------------------------
### [function_declaration.sql](function_declaration.sql)



----------------------------------------------------------------
### [function_procedure_overload.sql](function_procedure_overload.sql)



----------------------------------------------------------------
### [nested_table_type_definition.sql](nested_table_type_definition.sql)
Nested table — это тип столбца, в котором хранится неопределенное количество строк в произвольном порядке.  
[Документация Oracle Nested Table](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/plsql-collections-and-records.html#GUID-5ADB7EE2-71F6-4172-ACD8-FFDCF2787A37)
```sql
TYPE type IS TABLE OF datatype [ NOT NULL ]
```
Пример использования:
```sql
DECLARE
  TYPE Roster IS TABLE OF VARCHAR2(15);  -- nested table type
 
  -- nested table variable initialized with constructor:
 
  names Roster := Roster('D Caruso', 'J Hamil', 'D Piro', 'R Singh');
 
  PROCEDURE print_names (heading VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(heading);
 
    FOR i IN names.FIRST .. names.LAST LOOP  -- For first to last element
      DBMS_OUTPUT.PUT_LINE(names(i));
    END LOOP;
 
    DBMS_OUTPUT.PUT_LINE('---');
  END;
  
BEGIN 
  print_names('Initial Values:');
 
  names(3) := 'P Perez';  -- Change value of one element
  print_names('Current Values:');
 
  names := Roster('A Jansen', 'B Gupta');  -- Change entire table
  print_names('Current Values:');
END;
/

```


----------------------------------------------------------------
### [procedure_declaration.sql](procedure_declaration.sql)



----------------------------------------------------------------
### [record_type_definition.sql](record_type_definition.sql)

```sql
TYPE record_type IS RECORD  ( <field_definition> [, <field_definition>]... ) ;

<field_definition> ::=
    field datatype [ [ NOT NULL ] { := | DEFAULT } expression ]
```
Аналогом record type является row типы, но их нельзя объявить в заголовке пакета.   
Возможно придется переносить объявление типа в тело функции или процедуры, где используется этот тип.  
[Документация Oracle Record Variable Declaration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/record-variable-declaration.html#GUID-704FC014-561E-422C-9636-EDCA3B996AAD__CJAEHFDE)  
Пример использования:
```sql
DECLARE
  TYPE DeptRecTyp IS RECORD (
    dept_id    NUMBER(4) NOT NULL := 10,
    dept_name  VARCHAR2(30) NOT NULL := 'Administration',
    mgr_id     NUMBER(6) := 200,
    loc_id     NUMBER(4) := 1700
  );
 
  dept_rec DeptRecTyp;
BEGIN
  DBMS_OUTPUT.PUT_LINE('dept_id:   ' || dept_rec.dept_id);
  DBMS_OUTPUT.PUT_LINE('dept_name: ' || dept_rec.dept_name);
  DBMS_OUTPUT.PUT_LINE('mgr_id:    ' || dept_rec.mgr_id);
  DBMS_OUTPUT.PUT_LINE('loc_id:    ' || dept_rec.loc_id);
END;
/
```

----------------------------------------------------------------
### [ref_cursor_type_definition.sql](ref_cursor_type_definition.sql)
```sql
TYPE type IS REF CURSOR
  [ RETURN
    { {db_table_or_view | cursor | cursor_variable}%ROWTYPE
    | record%TYPE
    | record_type
    | ref_cursor_type
    }
  ] ;
```
[Документация Oracle Cursor Variable Declaration](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/cursor-variable-declaration.html#GUID-CE884B31-07F0-46AA-8067-EBAF73821F3D__CJAIGBFF)

----------------------------------------------------------------
### [subtype_definition.sql](subtype_definition.sql)
```sql
SUBTYPE subtype IS base_type [ constraint | CHARACTER SET character_set ]
  [ NOT NULL ]
```
Подтип создается на основе стандартного типа СУБД с дополнительными ограничениями.  
По сути `SUBTYPE` очень похож на Домен в РБД

----------------------------------------------------------------
### [variable_declaration.sql](variable_declaration.sql)


----------------------------------------------------------------
### [varray_type_definition.sql](varray_type_definition.sql)

Varray (Variable-Size Arrays) — это массив, количество элементов которого может варьироваться от нуля (пустой) до заявленного максимального размера.  
[Документация Oracle Varray (Variable-Size Arrays)](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/plsql-collections-and-records.html#GUID-E932FC04-C7AD-4562-9555-8BA05446C0B8)  
Пример использования:

```sql 
DECLARE
  TYPE Foursome IS VARRAY(4) OF VARCHAR2(15);  -- VARRAY type
 
  -- varray variable initialized with constructor:
 
  team Foursome := Foursome('John', 'Mary', 'Alberto', 'Juanita');
 
  PROCEDURE print_team (heading VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(heading);
 
    FOR i IN 1..4 LOOP
      DBMS_OUTPUT.PUT_LINE(i || '.' || team(i));
    END LOOP;
 
    DBMS_OUTPUT.PUT_LINE('---'); 
  END;
  
BEGIN 
  print_team('2001 Team:');
 
  team(3) := 'Pierre';  -- Change values of two elements
  team(4) := 'Yvonne';
  print_team('2005 Team:');
 
  -- Invoke constructor to assign new values to varray variable:
 
  team := Foursome('Arun', 'Amitha', 'Allan', 'Mae');
  print_team('2009 Team:');
END;
/

```

----------------------------------------------------------------