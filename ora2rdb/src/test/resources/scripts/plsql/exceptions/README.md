## Обработка исключений 

[Официальная документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-error-handling.html#GUID-E91802C5-02CB-477F-8A58-89982BBBA5FF)


### Обьявление именованных исключений 

    PROCEDURE calc_annual_sales
    (company_id_in IN company.company_id%TYPE)
    IS
        invalid_company_id EXCEPTION;
        negative_balance EXCEPTION;

        duplicate_company BOOLEAN;
    BEGIN
        ... исполняемые команды ...
    EXCEPTION
        WHEN NO_DATA_FOUND -- системное исключение
        THEN
        ...
        WHEN invalid_company_id
        THEN
        WHEN negative_balance
        THEN

Ссылаться на исключения можно двумя способами 

- в команде RAISE

      RAISE invalid_company_id;

- в секции WHEN раздела исключений

        WHEN invalid_company_id THEN


----------------------------------------------------

### Связывание имени исключения с кодом ошибки

Пример обработки ошибки ORA-01843 , связанной с данными 

    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1843 THEN

С помощью директивы **EXCEPTION INIT** можно связать идентификатор с внутренним кодом ошибки 

    PROCEDURE my_procedure
    IS
        invalid_month EXCEPTION;
        PRAGMA EXCEPTION_INIT (invalid_month, −1843);
    BEGIN
        ...
    EXCEPTION
        WHEN invalid_month THEN

Пример объявления exceptions внутри пакета 

    CREATE OR REPLACE PACKAGE dynsql
    IS
        invalid_table_name EXCEPTION;
            PRAGMA EXCEPTION_INIT (invalid_table_name, -903);
        invalid_identifier EXCEPTION;
            PRAGMA EXCEPTION_INIT (invalid_identifier, -904);

---------------------------------------

### Именованные системные исключения 

[Ссылка](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-error-handling.html#GUID-8C327B4A-71FA-4CFB-8BC9-4550A23734D6:~:text=Table%2012%2D3%20PL/SQL%20Predefined%20Exceptions) 
на официальную документацию 

--------------------------------------


### Инициирование исключений


Исключение может быть инициировано приложением в трех случаях:
- Oracle инициирует исключение при обнаружении ошибки;
- приложение инициирует исключение командой RAISE;
- исключение инициируется встроенной процедурой RAISE_APPLICATION_ERROR.

#### Команда RAISE

* RAISE имя_исключения;
* RAISE имя_пакета.имя_исключения;
* RAISE;


    DECLARE
    invalid_id EXCEPTION; -- Все идентификаторы должны начинаться с буквы 'X'.
    id_value VARCHAR2(30);
    BEGIN
    id_value := id_for ('SMITH');
    IF SUBSTR (id_value, 1, 1) != 'X'
    THEN
    RAISE invalid_id;
    END IF;
    ...
    END;


Третья форма **RAISE;**

Используйте эту форму для повторного инициирования (передачи) перехваченного
исключения:

    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
        -- Используем общий пакет для сохранений всей контекстной
        -- информации: код ошибки, имя программы и т. д.
        errlog.putline (company_id_in);
        -- А теперь исключение NO_DATA_FOUND передается
        -- в родительский блок без обработки.
    RAISE;

----------------------------------------------


### Процедура RAISE_APPLICATION_ERROR


Ее преимущество перед командой RAISE (которая тоже может инициировать специфические для приложения явно объявленные исключения) заключается
в том, что она позволяет связать с исключением сообщение об ошибке.

    RAISE_APPLICATION_ERROR (code_in, l_message);


-----------------------------------------------
### Обработка исключений


Чтобы обработать или перехватить исключение, нужно написать для него обработчик.
Обработчики исключений располагаются после всех исполняемых команд блока, но
перед завершающим ключевым словом END . Начало раздела исключений отмечает
ключевое слово EXCEPTION:

    DECLARE
    ... объявления ...
    BEGIN
    ... исполняемые команды ...
    [ EXCEPTION
    ... обработчики исключений ... ]
    END;

Синтаксис обработчика исключений может быть таким:

    WHEN имя_исключения [ OR имя_исключения ... ]
    THEN
        исполняемые команды

или таким:

    WHEN OTHERS
    THEN
        исполняемые команды



------------------------------------

### Встроенные функции ошибок 

- SQLCODE

Функция SQLCODE возвращает код ошибки последнего исключения, инициированного
в блоке. При отсутствии ошибок SQLCODE возвращает 0.

В РБД существует аналог. Тоже SQLCODE. 
- SQLERRM

Функция SQLERRM возвращает сообщение об ошибке для заданного кода ошибки

    BEGIN
    DBMS_OUTPUT.put_line (SQLERRM (-1403));
    END;

 Прямого аналога в РБД нет. 

--------------------------

### Объединение нескольких исключений в одном обработчике

В одном условии WHEN можно оператором OR объединить несколько исключений — по-
добно тому, как этим оператором объединяются логические выражения:


    WHEN invalid_company_id OR negative_balance
    THEN


-----------------------------


### Аналоги системных ошибок ORACLE в Ред База Данных

| ORACLE                  | РБД                                                             |
|-------------------------|-----------------------------------------------------------------|
| ACCESS_INTO_NULL        |                                                                 |
| CASE_NOT_FOUND          |                                                                 |
| COLLECTION_IS_NULL      |                                                                 |
| CURSOR_ALREADY_OPEN     | CURSOR_ALREADY_OPEN                                             |
| DUP_VAL_ON_INDEX        |                                                                 |
| INVALID_CURSOR          |                                                                 |
| INVALID_NUMBER          |                                                                 |
| LOGIN_DENIED            |                                                                 |
| NO_DATA_FOUND           | -                                                               |
| NO_DATA_NEEDED          |                                                                 |
| NOT_LOGGED_ON           |                                                                 |
| PROGRAM_ERROR           |                                                                 |
| ROWTYPE_MISMATCH        |                                                                 |
| SELF_IS_NULL            |                                                                 |
| STORAGE_ERROR           |                                                                 |
| SUBSCRIPT_BEYOND_COUNT  |                                                                 |
| SUBSCRIPT_OUTSIDE_LIMIT |                                                                 |
| SYS_INVALID_ROWID       |                                                                 |
| TIMEOUT_ON_RESOURCE     |                                                                 |
| TOO_MANY_ROWS           | SING_SELECT_ERR                                                 |
| VALUE_ERROR             |                                                                 |
| ZERO_DIVIDE             | EXCEPTION_FLOAT_DIVIDE_BY_ZERO EXCEPTION_INTEGER_DIVIDE_BY_ZERO |

