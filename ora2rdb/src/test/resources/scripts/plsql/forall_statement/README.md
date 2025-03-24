## FORALL 

BULK COLLECT ускоряет выполнение запросов на выборку. **FORALL** делает то же самое для
операций вставки, обновления, удаления и слияния (FORALL с командой MERGE поддерживается только в Oracle11g). FORALL приказывает ядру PL/SQL выполнить массовую
привязку всех элементов одной или нескольких коллекций перед отправкой команд
ядру SQL.

--------------------
### Синтаксис 

    FORALL индекс IN
    [   нижняя_граница ... верхняя_граница |
        INDICES OF коллекция |
        VALUES OF коллекция
    ]
    [ SAVE EXCEPTIONS ]
    команда_sql;

Здесь **индекс** — целочисленная переменная, неявно объявляемая Oracle;

**нижняя_граница** — начальное значение индекса (строка или элемент коллекции); 

**верхняя_граница** — конечное значение индекса (строка или элемент коллекции); команда_sql — команда
SQL, выполняемая для каждого элемента коллекции; 

**коллекция** — коллекция PL/SQL, используемая для выборки индексов в массиве, упоминаемом в команде_sql. 

Конструкции **INDICES** **OF** и **VALUES** **OF** поддерживаются начиная с Oracle 10g. 

Необязательная секция **SAVE EXCEPTIONS** указывает FORALL на необходимость обработки всех строк данных с сохранением всех возникающих исключений.


-----------------------

До Oracle Database 11g ссылки на поля в коллекциях записей в командах DML
были запрещены. Вместо этого можно было ссылаться только на строку коллекции
в целом, независимо от того, были ли ее поля коллекциями скалярных значений или
коллекциями более сложных объектов. Например, следующий код:

    DECLARE
         employee_aat IS TABLE OF employees%ROWTYPE
        INDEX BY PLS_INTEGER;
        l_employees employee_aat;
    BEGIN
        FORALL l_index IN l_employees.FIRST .. l_employees.LAST
            INSERT INTO employee (employee_id, last_name)
                VALUES (l_employees (l_index).employee_id
                , l_employees (l_index).last_name
    );

в версиях, предшествующих Oracle Database 11g, приводил к выдаче ошибки ком-
пилятора (PLS-00436).

в Oracle Database 11g  это ограничение было снято.


-----------------------

Индекс коллекции, используемый в команде DML, может быть выражением.
Например

    DECLARE
        names name_varray := name_varray ();
    BEGIN
        FORALL indx IN names.FIRST .. names.LAST
        DELETE FROM emp WHERE ename = names(indx+10);
    END;

----------------------------

### Пример использования оператора forall 

Изменение количества страниц для всех книг, коды ISBN которых присутствуют
в коллекции isbns_in:

    PROCEDURE order_books (
        isbns_in IN name_varray,
        new_counts_in IN number_varray)
    IS
    BEGIN
        FORALL indx IN isbns_in.FIRST .. isbns_in.LAST
        UPDATE books
            SET page_count = new_counts_in (indx)
            WHERE isbn = isbns_in (indx);
    END;

Полный пример приведен в файле [example_of_using_forall_statement.example](example_of_using_forall_statement.example)


----------------------

Следующий пример показывает, что команда DML может содержать ссылки на несколько коллекций. 
В данном случае используются три коллекции: denial, 
patient_name. 

    FORALL indx IN denial.FIRST .. denial.LAST
        INSERT INTO health_coverage
        VALUES (denial(indx), patient_name(indx));

----------------------------------


Использование секции RETURNING в команде FORALL для получения информации
о каждой отдельной операции DELETE. Обратите внимание на необходимость ис-
пользования **BULK COLLECT INTO** в секции RETURNING:

    FUNCTION remove_emps_by_dept (deptlist IN dlist_t)
        RETURN enolist_t
    IS
        enolist enolist_t;
    BEGIN
        FORALL aDept IN deptlist.FIRST..deptlist.LAST
            DELETE FROM employees WHERE department_id IN deptlist(aDept)
            RETURNING employee_id BULK COLLECT INTO enolist;
        RETURN enolist;
    END;


Полный пример приведен в файле [example_of_using_forall_statement.example](example_of_using_forall_statement.example)


---------------------------

Использование индексов, определяемых в одной коллекции, для определения строк
данных коллекции, которые должны использоваться динамической командой INSERT:

    FORALL indx IN INDICES OF l_top_employees
        EXECUTE IMMEDIATE
            'INSERT INTO ' || l_table || ' VALUES (:emp_pky, :new_salary)'
            USING l_new_salaries(indx).employee_id,
            l_new_salaries(indx).salary;


---------------------


### Атрибуты курсоров для FORALL

Вы можете использовать атрибуты курсоров после выполнения команды FORALL для
получения информации об операции DML, выполняемой в FORALL. Oracle также предоставляет
дополнительный атрибут %BULK_ROWCOUNT для получения более детализирован-
ной информации о результатах массовой команды DML.

Неявные атрибуты курсоров для команд FORALL

| Имя                                            |                                                                                                                                        Описание                                                                                                                                        | 
|:-----------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| SQL%FOUND                                      |                                                                                       Возвращает TRUE, если при последнем выполнении команды SQL была        модифицирована хотя бы одна строка                                                                                        
 SQL%NOTFOUND                                   |                                                                                                          Возвращает TRUE, если команда DML не модифицировала ни одной строки                                                                                                           
| SQL%ROWCOUNT                                   |                                                                                                               Возвращает количество строк, модифицированных командой DML                                                                                                               | 
|          SQL%ISOPEN                                       |                                                                                                                       Всегда возвращает FALSE (не используется)                                                                                                                        |
|          SQL%BULK_ROWCOUNT                                       | Возвращает псевдоколлекцию, которая сообщает количество строк, обработанных каждой соответствующей командой SQL, выполненной через FORALL. <br/> Обратите внимание: если значение %BULK_ROWCOUNT(j) равно нулю, то атрибуты %FOUND и %NOTFOUND будут равны FALSE и TRUE соответственно |
|          SQL%BULK_EXCEPTIONS                                     |                                                                                Возвращает псевдоколлекцию с информацией обо всех исключениях, инициированных в команде FORALL с секцией SAVE EXCEPTIONS                                                                                |


------------------------------------

### Пример использования %BULK_ROWCOUNT (а также общего атрибута %ROWCOUNT)



    DECLARE
        TYPE isbn_list IS TABLE OF VARCHAR2(13);
        my_books isbn_list
            := isbn_list (
            '1-56592-375-8', '0-596-00121-5', '1-56592-849-0',
            '1-56592-335-9', '1-56592-674-9', '1-56592-675-7',
            '0-596-00180-0', '1-56592-457-6'
            );
    BEGIN
        FORALL book_index IN
        my_books.FIRST..my_books.LAST
            UPDATE books
            SET page_count = page_count / 2
            WHERE isbn = my_books (book_index);

        -- Было ли обновлено ожидаемое число строк?
        IF SQL%ROWCOUNT != 8
            THEN
            DBMS_OUTPUT.PUT_LINE (
                'We are missing a book!');
        END IF;
        -- 4-я команда UPDATE изменила какие-либо строки?
        IF SQL%BULK_ROWCOUNT(4) = 0
            THEN
                DBMS_OUTPUT.PUT_LINE (
                'What happened to Oracle PL/SQL Programming?');
        END IF;
    END;


----------------------------

### Поведение ROLLBACK для FORALL

Команда FORALL позволяет передать ядру SQL несколько команд SQL. Это означает,
что переключение контекста всего одно — но каждая команда выполняется ядром SQL
отдельно от других.

Что случится, если в одной из этих команд SQL произойдет ошибка?
1. Команда DML, инициировавшая исключение, откатывается от неявной точки
   сохранения, созданной ядром PL/SQL перед выполнением команды. Изменения
   во всех строках, модифицированных этой командой, отменяются.
2. Все предшествующие операции DML в этой команде FORALL, уже завершенные
   без ошибок, не отменяются.
3. Если вы не приняли специальных мер (добавив секцию SAVE EXCEPTIONS в FORALL —
   см. далее), выполнение FORALL останавливается, и остальные команды вообще не
   выполняются.

-------------------------

### Продолжение после исключений и секция SAVE EXCEPTIONS

Добавляя в заголовок FORALL секцию SAVE EXCEPTIONS, вы приказываете Oracle продолжить
обработку даже при возникновении ошибки. База данных «сохраняет исключение» (или
несколько исключений, если ошибок было несколько). 

При завершении команды DML инициируется исключение ORA-24381. Далее в разделе исключений можно обратиться
к псевдоколлекции SQL%BULK_EXCEPTIONS для получения информации об ошибке.

Пример использования в файле [example_of_using_forall_statement.example](example_of_using_forall_statement.example)

---------------------------


### [the_lower limit_the_upper_limit.sql](the_lower limit_the_upper_limit.sql)

В тесте демонстируется пример испольования верхней и нижней границы

    IN l_denials.FIRST .. l_denials.LAST

**Нижняя_граница и верхняя_граница** должны задавать допустимый диапазон смежных индексов для коллекции, используемой в команде SQL. Для разреженных
коллекций выдается сообщение об ошибке (ORA-22160).
























