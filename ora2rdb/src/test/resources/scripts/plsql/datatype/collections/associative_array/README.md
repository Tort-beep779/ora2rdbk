## Associative arrays
### Описание
В Oracle PL/SQL Associative Arrays, также известные как индексные таблицы, в которых для значений индекса используя произвольные числа и строки. Associative Arrays - это набор пар ключ-значение, где каждый ключ уникален и используется для нахождения соответствующего значения в массиве
### Объявление ассоциативного массива
    TYPE POPULATION IS TABLE OF NUMBER
    INDEX BY VARCHAR2(64);

    CITY_POPULATION  POPULATION;
В Ред База Данных возможно преобразовать в таблицу

    CREATE GLOBAL TEMPORARY TABLE CITY_POPULATION (
    K VARCHAR(64),
    VAL NUMERIC(34, 8),
    CONSTRAINT PK_CITY_POPULATION PRIMARY KEY (K)
    );

### Инициализация ассоциативного массива в блоке объявления
Пример в ORACLE Database

    DECLARE
    TYPE SalaryMap IS TABLE OF NUMBER INDEX BY VARCHAR2(100);

    salaries SalaryMap := SalaryMap('John' => 50000, 'Alice' => 60000, 'Bob' => 55000);
    BEGIN
        NULL;   
    END;

Пример реализации в Ред База Данных

    CREATE GLOBAL TEMPORARY TABLE SALARIES (
    K VARCHAR(64),
    VAL NUMERIC(34, 8),
    CONSTRAINT PK_CITY_POPULATION PRIMARY KEY (K)
    );

    EXECUTE BLOCK
    AS
    /*TYPE SalaryMap IS TABLE OF NUMBER INDEX BY VARCHAR2(100);*/

    /*salaries SalaryMap := SalaryMap('John' => 50000, 'Alice' => 60000, 'Bob' => 55000);*/
    BEGIN
    UPDATE OR INSERT INTO CITY_POPULATION VALUES ('John', 50000);
    UPDATE OR INSERT INTO CITY_POPULATION VALUES ('Alice', 60000);
    UPDATE OR INSERT INTO CITY_POPULATION VALUES ('Bob', 55000);

    END;

### Добавление значений в ассоциативный массив

    CITY_POPULATION('SMALLVILLE')  := 2000;
    CITY_POPULATION('MIDLAND')     := 750000;
    CITY_POPULATION('MEGALOPOLIS') := 1000000;

В Ред База Данных можно использовать оператор `UPDATE OR INSERT`

    UPDATE OR INSERT INTO CITY_POPULATION VALUES ('SMALLVILLE', 2000);
    UPDATE OR INSERT INTO CITY_POPULATION VALUES ('MIDLAND', 750000);
    UPDATE OR INSERT INTO CITY_POPULATION VALUES ('MEGALOPOLIS', 1000000);

### Методы ассоциативного массива
#### FIRST
Возвращает ключ первой пары элементов

    I := CITY_POPULATION.FIRST;

В Ред База Данных можно заменить на

    I = (SELECT FIRST 1 K FROM CITY_POPULATION ORDER BY K ASC);

#### LAST
Возвращает ключ последней пары элементов

    I := CITY_POPULATION.LAST;

В Ред База Данных можно заменить на

    I = (SELECT FIRST 1 K FROM CITY_POPULATION ORDER BY K DESC);
#### COUNT
Возвращает количество элементов в коллекции

    I := CITY_POPULATION.COUNT();

В Ред База Данных можно заменить на

    I = (SELECT COUNT(*) FROM CITY_POPULATION);

#### PRIOR(value)
Возвращает индекс элемента, предшествующий заданному

    I := CITY_POPULATION.PRIOR('MIDLAND');

В Ред База Данных можно заменить на

    I = (SELECT FIRST 1 K FROM CITY_POPULATION WHERE K > 'MIDLAND' ORDER BY K DESC);

#### NEXT(value)
Возвращает индекс элемента, следующий за заданным

    I := CITY_POPULATION.NEXT('MIDLAND');

В Ред База Данных можно заменить на

     I = (SELECT FIRST 1 K FROM CITY_POPULATION WHERE K > 'MIDLAND' ORDER BY K ASC);

#### EXISTS
Проверяет, что элемент существует в коллекции

    bool_val := CITY_POPULATION.EXISTS('MIDLAND');

В Ред База Данных можно заменить на

    bool_var = (SELECT COUNT(*) > 0 FROM CITY_POPULATION WHERE K = 'MIDLAND');

#### DELETE
Удаляет элемент по переданному ключу

    CITY_POPULATION.DELETE('MIDLAND');

В Ред База Данных можно заменить на

    DELETE FROM CITY_POPULATION WHERE K = 'MIDLAND';
#### IS NOT NULL 

