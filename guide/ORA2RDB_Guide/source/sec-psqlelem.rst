.. _sec:psqlelem:

Преобразование элементов процедурного языка PL/SQL
===================================================



.. _subsec:decl:

Блок объявлений
-------------------------

В процедурах, функциях, триггерах, пакетах или анонимных PSQL-блоках есть возможность 
объявлять необходимые элементы языка (переменные, курсоры, подпрограммы и т.д.).

Для примера представим синтаксис создания процедуры с блоком объявлений. 
Для остальных объектов синтаксис аналогичен:


.. color-block::
    :caption: Oracle
    
    :green:`CREATE [OR REPLACE]` :red:`[EDITIONABLE|NONEDITIONABLE]` :green:`PROCEDURE` :red:`[<схема>.]` :green:`<имя процедуры>`
        :green:`[ ( <IN|OUT параметр> [, <IN|OUT параметр>]... ) ]` 
        :green:`...`
    :green:`{ IS | AS } [` :greenbf:`<блок объявлений>` :green:`]`
    :green:`BEGIN`
        :green:`<блок операторов> ...`
    :green:`END` :red:`[<имя процедуры>]` :green:`;`    
    
    :greenbf:`<блок объявлений>` :green:`::=  { {<объявление_1>;... [<объявление_2>;]...}`
                           :green:`| <объявление_2>;...}`

    :green:`<объявление_1> ::= { <объявление типа коллекций>`
                       :green:`| <объявление типа RECORD>`
                       :red:`| <объявление типа REF CURSOR>`
                       :red:`| <объявление типа SUBTYPE>`
                       :green:`| <объявление курсора>`
                       :green:`| <объявление переменных>`
                       :green:`| <объявление функции>`
                       :green:`| <объявление процедуры> }`

    :green:`<объявление_2> ::= { <объявление функции> | <реализация функции>`
                       :green:`| <объявление процедуры> | <реализация процедуры>`
                       :green:`| <объявление курсора> | <задание курсора> }`

.. _subsec:collections:

Объявление типов коллекций
^^^^^^^^^^^^^^^^^^^^^^^^^^^

PL/SQL имеет три типа коллекций:

- Ассоциативный массив (Associative Array)
- Массив переменной длины (Varray)
- Вложенная таблица (Nested table).

Массивы переменной длины и вложенные таблицы не поддерживаются РБД и не могут быть преобразованы конвертером. 

Преобразование объявлений ассоциативных массивов и их переменных
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Синтаксис для объявления типа ассоциативного массива в Oracle:

.. color-block::
    :caption: Oracle
    
    :green:`TYPE <имя типа ассоц.массива>`
    :green:`IS TABLE OF <тип данных> [ NOT NULL ]`
    :green:`INDEX BY { VARCHAR2 (<размер>)`
             :green:`| BINARY_INTEGER`
             :green:`| PLS_INTEGER`
             :green:`| LONG`
             :red:`| <имя переменной>%TYPE`
             :red:`| <имя курсора/таблицы/представления>%ROWTYPE` :green:`};`
    
Объявление переменной типа ассоциативного массива в Oracle:

.. color-block::
    :caption: Oracle

    :green:`<имя переменной> <имя типа ассоц.массива>` 
      :red:`[:=<выражение> | :=<вызов функции> | :=<имя переменной коллекции>]`:green:`;`

При конвертации объявления ассоциативного массива выполняются следующие задачи:  

1. *Создание глобальных временных таблиц*
   
   В чистом виде ассоциативные массивы не поддерживаются РБД. Однако, вместо их прямого использования 
   можно создать глобальные временные таблицы (GTT).
   Для каждой переменной ассоциативного массива формируется отдельная GTT, состоящая из двух полей: ключа (``I1``) и значения (``VAL``). 
   При этом поле ``I1`` выполняет роль первичного ключа.
   Тип данных для ключа может быть представлен только в виде ``VARCHAR`` (если ассоциативный массив индексирован строкой) или ``INTEGER``
   (если ассоциативный массив индексирован целым числом). 
   Следует отметить, что атрибуты ``%TYPE`` и ``%ROWTYPE`` не поддерживаются в РБД.

   .. code-block:: 
    :greenlines: 1,2,3,4,5,6
    :caption: Rdb
    
    CREATE GLOBAL TEMPORARY TABLE <имя переменной> (
       I1 { VARCHAR(<размер>)
          | INTEGER },
       VAL <тип данных> [NOT NULL],
       CONSTRAINT <имя ограничения> PRIMARY KEY (I1)
    );
  
2. Объявление ассоциативного массива и объявление переменной типа ассоциативного массива *комментируются*. 

Также при конвертации выполняется преобразование следующих операций в теле PL/SQL блока:

- *Заполнение переменной типа ассоциативного массива значениями*

  Поскольку вместо ассоциативного массива будет создана глобальная временная таблица (GTT), 
  операции присваивания значений переменной типа ассоциативного массива будут заменены на 
  вставку или обновление данных в эту GTT таблицу. Например: 
  
  .. container:: twocol

    .. code-block:: sql
       :caption: Oracle
             
       city_population('Мегаполис') := 1000000;
       :addline:
             
    .. code-block:: sql
       :caption: toRdb
                  
       UPDATE OR INSERT INTO CITY_POPULATION VALUES ('Мегаполис', 1000000);
  
- *Обращение по ключу*

  Поскольку вместо ассоциативного массива будет создана глобальная временная таблица (GTT), 
  обращение по ключу к элементам ассоциативного массива будет заменено на операцию ``SELECT``. Например:

  .. container:: twocol
    
    .. code-block:: sql
      :caption: Oracle
             
      l_res := city_population('Деревня');
      :addline:
             
    .. code-block:: sql
      :caption: toRdb
        
      l_res = (SELECT VAL FROM CITY_POPULATION 
               WHERE I1 = 'Деревня');


Приведем пример конвертации функции с объявлением ассоциативного массива.

.. code-block:: sql
    :caption: Oracle
  
    CREATE OR REPLACE FUNCTION TEST_FUNCTION
    RETURN NUMERIC(34, 8)
    IS
      TYPE population IS TABLE OF NUMBER INDEX BY VARCHAR2(64);      
      city_population population; 
      l_res NUMERIC(34, 8);
    BEGIN
      city_population('Деревня')   := 2000;
      city_population('Райцентр')  := 750000;
      city_population('Мегаполис') := 1000000;
      city_population('Деревня')  := 2001;
      l_res := city_population('Деревня')+city_population('Райцентр')+city_population('Мегаполис');
      ... 
      return l_res;
    END TEST_FUNCTION;

.. code-block:: sql
    :caption: to Rdb
  
    CREATE GLOBAL TEMPORARY TABLE CITY_POPULATION (
        I1 VARCHAR(64), 
        VAL NUMERIC(34, 8),
        CONSTRAINT PK_CITY_POPULATION PRIMARY KEY (I1)
    );
    
    CREATE OR ALTER FUNCTION TEST_FUNCTION 
    RETURNS NUMERIC(34, 8)
    AS
      /*TYPE population IS TABLE OF NUMERIC(34, 8) INDEX BY VARCHAR(64);*/
      /*city_population  population;*/
      DECLARE l_res NUMERIC(34, 8);
    BEGIN
      UPDATE OR INSERT INTO CITY_POPULATION VALUES ('Деревня', 2000);
      UPDATE OR INSERT INTO CITY_POPULATION VALUES ('Райцентр', 750000);
      UPDATE OR INSERT INTO CITY_POPULATION VALUES ('Мегаполис', 1000000);
      UPDATE OR INSERT INTO CITY_POPULATION VALUES ('Деревня', 2001);
      l_res = (SELECT VAL FROM CITY_POPULATION WHERE I1 = 'Деревня')
              + (SELECT VAL FROM CITY_POPULATION WHERE I1 = 'Райцентр')
              + (SELECT VAL FROM CITY_POPULATION WHERE I1 = 'Мегаполис');
      ...
      return l_res;
    END /*TEST_FUNCTION*/;

.. _subsec:recordtype:

Объявление типа RECORD
^^^^^^^^^^^^^^^^^^^^^^^

Сравнение синтаксиса объявления типа Record:

.. container:: twocol
   
   .. color-block::
     :caption: Oracle
              
     :green:`TYPE <имя типа Record>`
     :green:`IS RECORD (<имя поля> <тип данных>` 
                :green:`[[NOT NULL]`
                :green:`{:=|DEFAULT} <выражение>]`
                :green:`[, <имя поля> <тип данных>...]);`

   .. code-block:: 
     :greenlines: 1, 2, 3, 4, 5
     :caption: Rdb
             
     DECLARE TYPE <имя типа Record> 
     (<имя поля> <тип данных>
      [DEFAULT <значение>]
      [NOT NULL]
      [, <имя поля> <тип данных>...]...);

При конвертации выполняются следующие задачи:  

1. *Добавление ключевого слова* ``DECLARE``

   В РБД объявление любого элемента (в том числе типа) начинается с ключевого слова ``DECLARE``.
   Оно добавляется перед ключевым словом ``TYPE``.

2. *Удаление ключевых слов* ``IS RECORD``

3. *Замена операции присваивания* 
   
   В РБД значение по умолчанию устанавливается с использованием ключевого слова ``DEFAULT``. Таким образом, знак присваивания ``:=`` 
   заменяется на ``DEFAULT``.

4. *Изменение в порядке ключевых слов*
   
   Если задано ограничение ``NOT NULL`` и значение по умолчанию, то при конвертации меняется порядок их задания.


.. code-block:: sql
    :caption: Oracle
  
    DECLARE
      TYPE DeptRecTyp IS RECORD (
         dept_id    NUMBER(4) NOT NULL := 10,
         dept_name  VARCHAR2(30) NOT NULL := 'Administration',
         mgr_id     NUMBER(6) := 200,
         loc_id     NUMBER(4) := 1700
      ); 
      dept_rec DeptRecTyp;
    BEGIN
       ...
    END;



.. code-block:: sql
    :caption: to Rdb
  
    EXECUTE BLOCK
    AS 
      DECLARE TYPE DeptRecTyp (
        dept_id    NUMERIC(4)  default 10 NOT NULL,
        dept_name  VARCHAR(30) default 'Administration' NOT NULL,
        mgr_id     NUMERIC(6)  default 200,
        loc_id     NUMERIC(4)  default 1700
      );
      DECLARE dept_rec DeptRecTyp;
    BEGIN
      ...
    END;

Описание конвертации объявления переменных типа Record можно найти в :numref:`подразделе %s< subsec:declrecordvar>`.

Объявление курсоров
^^^^^^^^^^^^^^^^^^^^^^

Синтаксис для объявления курсора в Oracle:
          
.. color-block::
    :caption: Oracle
    
    :red:`CURSOR <имя курсора>` :red:`[(<список параметров курсора>)]`
    :red:`RETURN <rowtype>;`

В РБД курсоры не требуют предварительного объявления; они задаются непосредственно с помощью оператора ``SELECT``. 
Таким образом, при конвертации строки с объявлением курсоров исключается, а конвертируется непосредственно задание курсора. 


.. _subsec:declcursor:

Задание курсоров
^^^^^^^^^^^^^^^^^^^^^

Синтаксис для задания курсора в Oracle:

.. container:: twocol
          
  .. code-block::
    :greenlines: 1,4
    :redlines: 2,3
    :caption: Oracle
              
    CURSOR <имя курсора>
    [(<список параметров курсора>)]
    [RETURN <rowtype>] 
    IS <SELECT-запрос> ;

  .. code-block:: 
    :greenlines: 1,4
    :caption: Rdb

    DECLARE <имя курсора>  


    CURSOR FOR (<SELECT-запрос>);

При конвертации выполняются следующие задачи:  

1. *Комментирование курсора с входными параметрами*
   
   В РБД не поддерживатся курсоры с входными параметрами. Поэтому при конвертации такие курсоры комментируются.

2. *Удаление конструкции* ``RETURN``

   В РБД конструкция ``RETURN`` отсутствует. Но её удаление никак не сказывается на работу курсора.

3. *Добавление ключевого слова* ``DECLARE``

   В РБД объявление любого элемента начинается с ключевого слова ``DECLARE``.
   
4. *Удаление ключевого слова* ``CURSOR``

5. Замена ключевого слова ``IS`` на ключевые слова ``CURSOR FOR``

6. *SELECT-запрос оборачивается в скобки*.
 


.. code-block:: sql
  :caption: Oracle

  DECLARE
    id testt.id%TYPE;
    num testt.num%TYPE;
    cursor c1 RETURN testt%ROWTYPE;
    cursor c1 RETURN testt%ROWTYPE is
      SELECT * FROM testt;
  BEGIN
    OPEN c1;
    LOOP
      FETCH c1 INTO id, num;
      EXIT WHEN c1%NOTFOUND;
    END LOOP;
    CLOSE c1;
  END;


.. code-block:: sql
  :caption: to Rdb

  EXECUTE BLOCK 
  AS
    DECLARE id TYPE OF COLUMN testt.id;
    DECLARE num TYPE OF COLUMN testt.num;
    DECLARE c1 CURSOR FOR
      (SELECT * FROM testt);
  BEGIN
    OPEN c1;
    WHILE (TRUE) DO 
    BEGIN
      FETCH c1 INTO :id, :num;
        IF( ROW_COUNT != 1 ) 
        THEN LEAVE;
    END 
    CLOSE c1;
  END;

Операторы для работы с курсорами и их преобразование описаны в следующем подразделе.


Объявление переменных
^^^^^^^^^^^^^^^^^^^^^^

В PL/SQL блоках можно объявлять различные переменные, каждая из которых конвертируется по своему. 
Ниже перечислены основные типы переменных, которые можно использовать в блоке объявления:

.. code-block::
    :redlines:  2,3,7
    :greenlines: 1,4,5,6,8
    :caption: Oracle

    <объявление переменных> ::= { <объявление переменных типа коллекций>
                                | <объявление констант>
                                | <объявление переменной типа REF CURSOR>
                                | <объявление исключений>
                                | <объявление переменной типа RECORD>
                                | <объявление скалярной переменной>
                                | [REF] <пользовательский объектный тип>
                                }

Далее рассмотрим синтаксис объявления каждой из них.

Объявление переменных типа коллекций
""""""""""""""""""""""""""""""""""""""

Перед объявлением переменной типа коллекции, сам тип должен быть ранее определен в том же блоке. 


.. code-block::
    :redlines:  2,3,4,5,6,7
    :greenlines: 1
    :caption: Oracle
        
    <имя переменной> { <имя типа ассоц.массива> 
                       [:=<выражение> | :=<вызов функции> | :=<имя переменной коллекции>]
                     | <имя типа Varray> 
                       [:= <имя типа Varray>([<список значений>]) | :=<имя переменной коллекции> ]
                     | <имя типа вложенных таблиц> 
                       [:= <имя вложенных таблиц>([<список значений>])|:=<имя перем-ой коллекции>]
                     | <имя переменной коллекции>%TYPE } ;    

Объявление типов коллекций было подробно рассмотрено в :numref:`подразделе %s<subsec:collections>`. 
В этом разделе отмечается, что в РБД аналогичные коллекции не поддерживаются, и что конвертер способен 
преобразовать только ассоциативные массивы (в GTT таблицы). Кроме того, в этом же разделе уже описано преобразование
объявления переменной ассоциативного массива. Поэтому в этом параграфе задачи преобразования рассматриваться не будут.  

..
   Объявление констант
   """""""""""""""""""""
         
   .. code-block::
      :redlines: 1
      
      <имя константы> CONSTANT <тип данных> [NOT NULL] { := | DEFAULT } <выражение> ;

.. _sub:userexception:

Объявление пользовательских исключений
"""""""""""""""""""""""""""""""""""""""

В Oracle существуют два вида исключений:

- системные исключения, объявленные в пакете ``STANDARD``. 
- пользовательские исключения, которые явно объявляются в анонимном блоке, процедуре, функции, триггере или пакете.

Рассмотрим синтаксис объявления пользовательских исключений:

.. code-block::
    :greenlines: 1
    :caption: Oracle
        
    <имя исключения> EXCEPTION;  

При конвертации объявлений пользовательских исключений выполняются следующие задачи:

1. *Создание нового исключения*
   
   В отличие от Oracle пользовательские исключения в РБД создаются глобально для всех подпрограмм.
   Поэтому вместо объявления исключения в конкретной подпрограмме, триггере, пакете или блоке, 
   добавляется оператор создания нового исключения. При этом важно, чтобы имя исключения было уникальным:

   .. code-block::
    :greenlines: 1
    :caption: Rdb
        
    CREATE EXCEPTION <имя исключения> '<текст сообщения>';

2. *Удаляется объявление исключения*

   В блоке объявление упоминание исключения удаляется.


.. code-block:: sql
  :caption: Oracle

  CREATE OR REPLACE PROCEDURE add_new_order
     (order_id_in IN NUMBER, sales_in IN NUMBER)
  IS
     no_sales EXCEPTION;
  BEGIN
      ...
  END;


.. code-block:: sql
  :caption: to Rdb

  CREATE EXCEPTION no_sales_EXCEPTION_add_new_order 'error';
  
  CREATE OR ALTER PROCEDURE add_new_order
     (order_id_in  NUMERIC(34, 8), sales_in  NUMERIC(34, 8))
  AS
  BEGIN
     ...
  END;



Инициирование и обработка исключений описаны в подразделе :ref:`sub:declare_exception`. 
   
.. _subsec:declrecordvar:

Объявление переменной типа RECORD
"""""""""""""""""""""""""""""""""""

Рассмотрим все различные способы объявления переменных типа Record и сравним синтаксис после преобразования:


:par:`c`

:par:`c`

.. container:: twocol
  
  .. code-block::
    :redlines: 4,7
    :greenlines: 1,2,3,5,6,8,9
    :caption: Oracle
              
    <имя переменной> 
          { <имя типа RECORD> 
          | <имя курсора>%ROWTYPE 
          | <имя переменной CURSOR REF>%ROWTYPE 
          | <имя таблицы>%ROWTYPE 
          | <имя представления>%ROWTYPE 
          | <имя переменной типа RECORD>%TYPE }
    [[NOT NULL] 
    {:= | DEFAULT} <выражение> ];

  .. code-block:: 
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9
    :caption: Rdb

    DECLARE [VARIABLE] <имя переменной> 
          { <имя типа RECORD> 
          | TYPE OF TABLE  <имя курсора>

          | TYPE OF TABLE <имя таблицы> 
          | TYPE OF TABLE <имя представления>
          }
    [NOT NULL] 
    [{ = | DEFAULT } <значение по умолчанию>];

При конвертации выполняются следующие задачи:

1. *Добавление ключевых слов* ``DECLARE VARIABLE``

   Перед именем переменной прописываются ключевые слова ``DECLARE VARIABLE``. 
   Причем ключевое слово ``VARIABLE`` прописывать необязательно.

2. *Преобразование переменной на основе типа Record*

   Тип Record должен быть предварительно объявлен. Описание конвертации объявления типа Record 
   можно найти в :numref:`подразделе %s<subsec:recordtype>`. При конвертации ничего не меняется.

3. *Преобразование переменной на основе курсора*

   Курсор должен быть предварительно объявлен. Описание конвертации объявления курсора
   можно найти в :numref:`подразделе %s<subsec:declcursor>`. При конвертации атрибут ``%ROWTYPE`` заменяется на конструкцию ``TYPE OF TABLE``.

4. *Преобразование переменной на основе таблицы или представления* 

    При конвертации атрибут ``%ROWTYPE`` заменяется на конструкцию ``TYPE OF TABLE``.

5. *Замена операции присваивания* 
   
   Операция присваивания значения по умолчанию ``":="`` заменяется на ``"="``.

6. *Преобразование инициализации с помощью конструктора*

   Если переменная типа Record инициализируется значением (по умолчанию или в теле программы) с помощью конструктора, например:

   .. code-block:: sql
    :caption: Oracle

    dept_rec DeptRecTyp := DeptRecType(10, 'Administration', 200, 1700);
  
   То при конвертации в конструкторе имя типа заменяется на ключевое слово ``ROW``:

   .. code-block:: sql
    :caption: to Rdb

    dept_rec DeptRecTyp = ROW(10, 'Administration', 200, 1700);



.. code-block:: sql
  :caption: Oracle

  DECLARE
    TYPE DeptRecTyp IS RECORD (
         dept_id    NUMBER(4) NOT NULL := 10,
         dept_name  VARCHAR2(30) NOT NULL := 'Administration',
         mgr_id     NUMBER(6) := 200,
         loc_id     NUMBER(4) := 1700
      );
    CURSOR c1 IS SELECT department_id, location_id FROM departments;
    dept_rec1 DeptRecTyp := DeptRecTyp (20, 'Ingineer', 300, 1200);
    dept_rec2 departments%ROWTYPE 
    dept_rec3 c1%ROWTYPE;
  BEGIN
    dept_rec2 := DeptRecTyp(10, 'Administration', 200, 1700);
  END;


.. code-block:: sql
  :caption: to Rdb

  EXECUTE BLOCK 
  AS 
    DECLARE TYPE DeptRecTyp   (
         dept_id    NUMERIC(4)  DEFAULT 10 NOT NULL,
         dept_name  VARCHAR(30) DEFAULT 'Administration' NOT NULL,
         mgr_id     NUMERIC(6)  DEFAULT 200,
         loc_id     NUMERIC(4)  DEFAULT 1700
    );
    DECLARE c1 CURSOR FOR (SELECT department_id, location_id FROM departments);
    DECLARE dept_rec1 DeptRecTyp = ROW(20, 'Ingineer', 300, 1200);
    DECLARE VARIABLE dept_rec2 TYPE OF TABLE departments not null;
    DECLARE VARIABLE dept_rec3 TYPE OF TABLE c1;  
  BEGIN
    dept_rec2 = ROW(10, 'Administration', 200, 1700);
  END;


Объявление скалярной переменной
""""""""""""""""""""""""""""""""

Рассмотрим синтаксис объявления скалярной переменной. В Oracle их можно объявить разными способами:

.. code-block::
    :greenlines: 1, 3, 4, 7
    :redlines: 5, 6
    
    <имя переменной> <тип данных> [ [NOT NULL] {:= | DEFAULT} <выражение> ];

    <тип данных> ::= { <тип данных SQL>
                     | <имя таблицы/представления>.<столбец>%TYPE
                     | <переменная типа RECORD>.<поле>%TYPE
                     | <скалярная переменная>%TYPE
                     }
  
При конвертации объявления скалярных переменных выполняются следующие задачи:

1. *Добавление ключевых слов* ``DECLARE VARIABLE``
 
   Перед именем переменной указываются ключевые слова ``DECLARE VARIABLE``. 
   Причем ключевое слово ``VARIABLE`` прописывать необязательно.

2. *Замена операции присваивания* 
   
   Операция присваивания значения по умолчанию ``":="`` заменяется на ``"="``.

3. *Преобразование переменной с типом данных SQL*

   Синтаксис объявления таких переменных практически идентичен:

   .. container:: twocol

    .. code-block::
      :greenlines: 1, 2, 3, 4
      :caption: Oracle
      
      :addline:
      <имя переменной> <тип данных SQL>     
      [[NOT NULL] 
      {:= | DEFAULT} <выражение> ] ;             
              	                                                        
    .. code-block:: 
      :greenlines: 1, 2, 3, 4
      :caption: Rdb
             
      DECLARE [VARIABLE] 
      <имя переменной> <тип данных SQL>
      [NOT NULL] 
      [{ = | DEFAULT } <выражение>] ;

4. *Преобразование переменной с типом данных столбца таблицы/представления*

   Сравним синтаксис объявления таких переменных:

   .. container:: twocol
    
    .. code-block::
      :greenlines: 1, 2, 3, 4
      :caption: Oracle
             
      <имя переменной>
            <имя таблицы>.<столбец>%TYPE     
      [[NOT NULL] 
      {:= | DEFAULT} <выражение> ] ;             
              	                                                          
    .. code-block:: 
      :greenlines: 1, 2, 3, 4
      :caption: Rdb
             
      DECLARE [VARIABLE] <имя переменной>
        TYPE OF COLUMN <имя таблицы>.<столбец>
      [NOT NULL] 
      [{ = | DEFAULT } <выражение>] ;

   Как видно, атрибут ``%TYPE`` удаляется и заменяется на конструкцию ``TYPE OF COLUMN``.

.. code-block:: sql
  :caption: Oracle

  DECLARE
    sql_stmt    VARCHAR2(200);
    dept_id     NUMBER(2) := 50;
    dept_name   dept.name%TYPE  := 'PERSONNEL';
    location    dept.location%TYPE default 'DALLAS';
  BEGIN
    sql_stmt := 'INSERT INTO dept VALUES (:1, :2, :3)';
    EXECUTE IMMEDIATE sql_stmt USING dept_id, dept_name, location;
  END;


.. code-block:: sql
  :caption: to Rdb

  EXECUTE BLOCK 
  AS 
    DECLARE sql_stmt    VARCHAR(200);
    DECLARE dept_id     NUMERIC(2) = 50;
    DECLARE dept_name   TYPE OF COLUMN dept.name  = 'PERSONNEL';
    DECLARE location    TYPE OF COLUMN dept.location default 'DALLAS';
  BEGIN
    sql_stmt = 'INSERT INTO dept VALUES (:A1, :A2, :A3)';
    EXECUTE STATEMENT (:sql_stmt) (A1:= :dept_id, A2:= :dept_name, A3:= :location);
  END;


    
.. _subsec:proc_decl:

Объявление подпроцедуры
^^^^^^^^^^^^^^^^^^^^^^^^

Синтаксис объявления подпроцедуры в СУБД Oracle выглядит следующим образом [1]_:

.. code-block::
    :redlines:  2, 3, 4
    :greenlines: 1
    :caption: Oracle
        
    PROCEDURE <процедура> [(<IN|OUT параметр>[,<IN|OUT параметр>])] 
    [ ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]...)
    | DEFAULT COLLATION <опция сортировки>
    | AUTHID { CURRENT_USER | DEFINER }]... ;

Данный синтаксис верен для блока объявления в *хранимой процедуре, функции, триггере, теле пакета, анонимном блоке*.
Для *заголовка пакета* синтаксис объявления пакетной процедуры немного отличается:

.. code-block::
    :redlines:  2
    :greenlines: 1
    :caption: Oracle
        
    PROCEDURE <процедура> [(<IN|OUT параметр>[,<IN|OUT параметр>])] 
    [ ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]...)];


Преобразование объявления (и определения) подпроцедур рассмотрено в подразделе :ref:`subsec:proc_defin`.

Речь там пойдет о подпроцедурах, однако для пакетных процедур преобразование будет аналогичным.




.. _subsec:func_decl:

Объявление подфункции 
^^^^^^^^^^^^^^^^^^^^^^^

Синтаксис объявления подфункции в СУБД Oracle выглядит следующим образом [2]_:

.. code-block::
    :redlines:  4,5,6 
    :greenlines: 1,2,3
    :caption: Oracle
    
    FUNCTION <имя функции> [(<IN|OUT параметр>[,<IN|OUT параметр>])]
    RETURN <тип данных> 
    [ DETERMINISTIC 
    | PIPELINED 
    | PARALLEL_ENABLE 
    | RESULT_CACHE ]... ; 

Данный синтаксис верен для блока объявления в *хранимой процедуре, функции, триггере, теле пакета, анонимном блоке*.
Для *заголовка пакета* синтаксис объявления пакетной функции немного отличается:

.. code-block::
    :redlines:  3, 5, 6, 7
    :greenlines: 1, 2, 4
    :caption: Oracle
        
    FUNCTION <имя функции> [(<IN|OUT параметр>[,<IN|OUT параметр>])]
    RETURN <тип данных> 
    [ ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]...) 
    | DETERMINISTIC 
    | PIPELINED ...  
    | PARALLEL_ENABLE [ (PARTITION <аргумент> BY ... )]
    | RESULT_CACHE [RELIES_ON ([ <источник данных> [, <источник данных>]... ] ) ] ] ;

Преобразование объявления (и определения) подфункций рассмотрено в подразделе :ref:`subsec:func_defin`.

Речь там пойдет о подфункциях, однако для пакетных функций преобразование будет аналогичным.


.. _subsec:proc_defin:

Определение подпроцедуры
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Синтаксис определения подпроцедуры в СУБД Oracle выглядит следующим образом [2]_:

.. color-block::
    :caption: Oracle
    
    :green:`PROCEDURE <имя процедуры>` :green:`[ ( <IN|OUT параметр> [, <IN|OUT параметр>]... ) ]` 
    :red:`[ ACCESSIBLE BY ( <средство доступа> [, <средство доступа> ]... ) ]`
    :red:`[ DEFAULT COLLATION <опция сортировки> ]`
    :red:`[ AUTHID { CURRENT_USER | DEFINER }]`
    :green:`{ { IS | AS } [ <блок объявлений> ]`
        :green:`BEGIN`
            :green:`<блок операторов> ...`
            :green:`[ EXCEPTION <обработка исключений> ]` 
        :green:`END` :red:`[<имя процедуры>]` :green:`;`
    :red:`| { IS | AS } <внешний модуль>`
    :green:`}`

    :green:`<IN-параметр> ::= <имя параметра>` :red:`[IN]` :green:`<тип данных> [{:=|DEFAULT} <выражение>]`

    :green:`<OUT-параметр> ::= <имя параметра>` :red:`{OUT|IN OUT} [NOCOPY]` :green:`<тип данных>`

**Замечания**

- Удаляется конструкция ``ACCESSIBLE BY``.
- Удаляется предложение ``DEFAULT COLLATION``.
- Комментируется предложение ``AUTHID``.
- Конструкция ``{ IS | AS } <внешний модуль>`` комментируется.

  На данный момент конвертер не способен преобразовывать хранимые процедуры, находящиеся во внешнем модуле. 
  Тем не менее, РБД поддерживает использование внешних хранимых процедур. В таком случае вместо тела процедуры 
  указывается её местоположение во внешнем модуле с помощью конструкции ``EXTERNAL NAME``.

- Имя процедуры после ключевого слова ``END`` комментируется.

Далее рассмотрим только те конструкции определения подпроцедур, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.

В подпроцедурах на Oracle все параметры являются входными, однако они подразделяются на IN и OUT. 
В СУБД Ред База Данных нет подобного разделения параметров. 
Поэтому подпроцедура может конвертироваться по-разному в зависимости от наличия OUT-параметров. 


Преобразование определения подпроцедуры без OUT-параметров
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Сравнение операторов определения подпроцедур *без параметров или только с IN-параметрами*:

.. container:: twocol
          
  .. code-block::
    :greenlines: 1, 2, 3, 4, 5
    :caption: Oracle
    
    PROCEDURE <имя> [(<IN-пар.>[,<IN-пар.>])]
    { IS | AS } [<блок объявлений>]
    BEGIN
        <блок операторов>
    END;
        
  .. code-block:: 
    :greenlines: 1, 2, 3, 4, 5
    :caption: Rdb
    
    DECLARE PROCEDURE <имя> [(<IN-пар.>[,...])]
    AS [<блок объявлений>]
    BEGIN
        <блок операторов>
    END

При конвертации определения подпроцедур без OUT-параметров выполняются следующие задачи:  

1. *Добавление ключевого слова* ``DECLARE``
   
   Перед объявлением подпроцедуры в РБД добавляется ключевое слово  ``DECLARE``.
2. *Преобразование IN-параметров* 

   Сравним синтаксис задания IN-параметров (Oracle) и входных параметров (РБД):

   .. container:: twocol
    
    .. color-block::
      :caption: Oracle
             
      :green:`<имя параметра>` :red:`[IN]` :green:`<тип данных>` 
            :green:`[{:=|DEFAULT} <значение>]`                  
  	                                                              
    .. code-block:: 
      :greenlines: 1, 2, 3
      :caption: Rdb

      <имя параметра> <тип данных> 
          [{=|DEFAULT} <значение>]     

   В Oracle входные параметры могут прописываться с модификатором ``IN`` (необязательным). 
   При конвертации модификатор ``IN`` удаляется. 

   IN-параметрам можно устанавливать значения по умолчанию. Как видно, различия заключаются лишь в операторе присваивания (``:=``). 
   
   .. note::

      В РБД параметры, для которых установлены значения по умолчанию, должны располагаться в самом конце списка, 
      тогда как в Oracle таких ограничений нет.

3. *Замена ключевого слова* ``IS`` 
   
   Данное ключевое слово заменяется на равнозначное ему ``AS``.

4. *Удаление* ``;`` 
   
   В конце тела процедуры после ключевого слова ``END`` в РБД точка с запятой не ставится.

.. code-block:: sql
   :caption: Oracle

   CREATE OR REPLACE PROCEDURE myproc
   IS
     PROCEDURE subproc (id IN int, name VARCHAR2);
     PROCEDURE subproc (id IN int, name IN VARCHAR2)
     IS 
     BEGIN
       INSERT INTO mytable (order_id, first_name ) VALUES ( id, name );
     END;
   BEGIN
     subproc(100, 'Oleg');
   END;


.. code-block:: sql
   :caption: to Rdb

   CREATE OR ALTER PROCEDURE myproc
   AS
     DECLARE PROCEDURE subproc (id int, name VARCHAR(32));
     DECLARE PROCEDURE subproc (id int, name  VARCHAR(32))
     AS 
     BEGIN
       INSERT INTO mytable (order_id, first_name ) VALUES ( :id, :name );
     END
   BEGIN
     EXECUTE PROCEDURE subproc(100, 'Oleg');
   END;

Преобразование определения подпроцедуры с OUT параметрами
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Сравнение синтаксиса определения подпроцедур *с хотя бы одним OUT-параметром*:

.. container:: twocol
          
  .. code-block::
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    :caption: Oracle
      
    PROCEDURE <имя> (<OUT-пар.> [,<IN|OUT-пар.>])


    { IS | AS } [<блок объявлений>]
    BEGIN
       <блок операторов>



    END;
        
  .. code-block:: 
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    :caption: Rdb
      
    DECLARE PROCEDURE <имя> (<OUT-пар.>
                             [,<IN|OUT-пар.>])
    RETURNS (<OUT-пар.>_OUT [,...])
    AS [<блок объявлений>]
    BEGIN
       <блок операторов>
       <OUT-параметр>_OUT = <OUT-параметр>; 
       [<OUT-параметр2>_OUT = <OUT-параметр2>;...]
       SUSPEND;
    END

При конвертации определения подпроцедур с OUT-параметрами выполняются следующие задачи:  

1. *Преобразование процедуры в селективную процедуру* 

   Если в процедуре присутствует хотя бы один OUT-параметр, она преобразуется в селективную процедуру в РБД. 
   Для этого выполняются следующие действия:
   
   .. unindented_list::

      - добавляется конструкция ``RETURNS (...)``, в которую дублируется список всех OUT-параметров с добавлением суффикса ``"_OUT"``.
      - перед завершением процедуры осуществляется присваивание значений выходным параметрам, после чего выполняется команда ``SUSPEND``.

2. *Добавление ключевого слова* ``DECLARE``
   
   Перед объявлением подпроцедуры в РБД добавляется ключевое слово  ``DECLARE``.

3. *Преобразование OUT-параметров*

   Сравним синтаксис задания OUT-параметров (Oracle) и входных параметров (РБД) [2]_:

   .. container:: twocol
    
    .. color-block::
      :caption: Oracle
             
      :green:`<имя параметра>` :red:`{OUT|IN OUT} [NOCOPY]` 
                            :green:`<тип данных>`
                 
  	                                                              
    .. code-block:: 
      :greenlines: 1, 2, 3
      :caption: Rdb
             
      <имя параметра> <тип данных> 
      :addline:

   Модификаторы ``OUT`` и ``IN OUT`` не используются и удаляются. Следует отметить, что в РБД отсутствует аналог модификатора ``NOCOPY``, 
   который также подлежит исключению.

4. *Преобразование IN-параметров* 

   Сравним синтаксис задания IN-параметров (Oracle) и входных параметров (РБД):

   .. container:: twocol
    
    .. color-block::
      :caption: Oracle

      :green:`<имя параметра>` :red:`[IN]` :green:`<тип данных>` 
            :green:`[{:=|DEFAULT} <значение>]`                  
  	                                                              
    .. code-block:: 
      :greenlines: 1, 2, 3
      :caption: Rdb
            
      <имя параметра> <тип данных> 
          [{=|DEFAULT} <значение>]     

   В Oracle входные параметры могут прописываться с модификатором ``IN`` (необязательным). 
   При конвертации модификатор ``IN`` удаляется. 

   IN-параметрам можно устанавливать значения по умолчанию. Как видно, различия заключаются лишь в операторе присваивания (``:=``). 
   
   .. note::

      В РБД параметры, для которых установлены значения по умолчанию, должны располагаться в самом конце списка, 
      тогда как в Oracle таких ограничений нет.

5. *Замена ключевого слова* ``IS`` 
   
   Данное ключевое слово заменяется на равнозначное ему ``AS``.

6. *Удаление* ``;`` 
   
   В конце тела процедуры после ключевого слова ``END`` в РБД точка с запятой не ставится.

.. code-block:: sql
   :caption: Oracle

   declare
       l_min_date date;
       l_max_date date;
       l_default_date date;
       procedure get_const_values (min_date out date,
                                   max_date out date,
                                   default_date out date )
       is
       begin
          min_date := to_date('1800-01-01', 'yyyy-mm-dd');
          max_date := to_date('4021-01-01', 'yyyy-mm-dd');
          default_date := sysdate;
       end;
   begin
       get_const_values(l_min_date, l_max_date, l_default_date);
   end;


. 

.. code-block:: sql
   :caption: to Rdb

   EXECUTE BLOCK 
   AS 
      declare l_min_date date;
      declare l_max_date date;
      declare l_default_date date;
      declare procedure get_const_values (min_date date,
                                          max_date date,
                                          default_date date)
              returns ( min_date_OUT date, 
                        max_date_OUT date, 
                        default_date_OUT date)
              as
              begin
                   min_date = CAST('1800-01-01' AS TIMESTAMP) ;
                   max_date = CAST('4021-01-01' AS TIMESTAMP) ;
                   default_date = CURRENT_TIMESTAMP;
                   MIN_DATE_OUT = MIN_DATE;
                   MAX_DATE_OUT = MAX_DATE;
                   DEFAULT_DATE_OUT = DEFAULT_DATE;
                   SUSPEND;
              end
   BEGIN
       SELECT MIN_DATE_OUT, MAX_DATE_OUT, DEFAULT_DATE_OUT 
       FROM get_const_values(:l_min_date, :l_max_date, :l_default_date) 
       INTO l_min_date, l_max_date, l_default_date;
   END;


.. _subsec:func_defin:

Определение подфункции
^^^^^^^^^^^^^^^^^^^^^^^^

Синтаксис определения подфункции в СУБД Oracle выглядит следующим образом [3]_:

.. color-block::
    :caption: Oracle
    
    :green:`FUNCTION <имя функции> [ ( <IN|OUT параметр> [, <IN|OUT параметр>]... ) ]`
    :green:`RETURN <тип возвращаемого значения>`
    :green:`[ DETERMINISTIC ]`
    :red:`[ PIPELINED ... ]`
    :red:`[ PARALLEL_ENABLE ... ]`
    :red:`[ RESULT_CACHE ... ]`
    :green:`{ { IS | AS } [ <блок объявлений> ]`
        :green:`BEGIN`
            :green:`<блок операторов> ...`
            :green:`[ EXCEPTION <обработка исключений> ]`
        :green:`END` :red:`[<имя функции>]` :green:`;`
    :red:`| { IS | AS } <внешний модуль> ;`
    :green:`}`

    :green:`<IN-параметр> ::= <имя параметра>` :red:`[IN]`  :green:`<тип данных> [{:=|DEFAULT} <выражение>]`

    :green:`<OUT-параметр> ::= <имя параметра>` :red:`{OUT|IN OUT} [NOCOPY]` :green:`<тип данных>`

**Замечания**

- Удаляется предложение ``PARALLEL_ENABLE``.
- Удаляется предложение ``RESULT_CACHE``.
- Удаляется предложение ``PIPELINED``.
- Конструкция ``{ IS | AS } <внешний модуль>`` комментируется.

  На данный момент конвертер не способен преобразовывать хранимые функции, находящиеся во внешнем модуле. 
  Тем не менее, РБД поддерживает использование внешних хранимых функций. В таком случае вместо тела функции 
  указывается её местоположение во внешнем модуле с помощью конструкции ``EXTERNAL NAME``.

- Имя функции после ключевого слова ``END`` комментируется.

Далее рассмотрим только те конструкции определения подфункций, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.

В подфункциях на Oracle все параметры являются входными, однако они подразделяются на IN и OUT. 
В СУБД Ред База Данных нет подобного разделения параметров. 
Поэтому подфункция может конвертироваться по-разному в зависимости от наличия OUT-параметров. 

Преобразование определения подфункции без OUT-параметров
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Сравнение операторов определения подфункций *без параметров или только с IN-параметрами*:

.. container:: twocol
          
  .. code-block::
    :greenlines: 1, 2, 3, 4, 5, 6, 7
    :caption: Oracle
    
    FUNCTION <имя> [(<IN-пар.>[,<IN-пар.>]...)]
    RETURN <тип возвращаемого значения> 
    [DETERMINISTIC]
    { IS | AS } [ <блок объявлений> ]
    BEGIN
        <блок операторов> ...
    END; 
        
  .. code-block:: 
    :greenlines: 1, 2, 3, 4, 5, 6, 7
    :caption: Rdb
    
    DECLARE FUNCTION <имя> [(<IN-пар.> [,...])]
    RETURNS <тип данных> 
    [DETERMINISTIC]
    AS [ <блок объявлений> ]
    BEGIN
       <блок операторов> ...
    END

При конвертации определения подфункций без OUT-параметров выполняются следующие задачи:  

1. *Добавление ключевого слова* ``DECLARE``
   
   Перед объявлением подфункции в РБД добавляется ключевое слово ``DECLARE``.
2. *Преобразование IN-параметров* 

   Сравним синтаксис задания IN-параметров (Oracle) и входных параметров (РБД):

   .. container:: twocol
    
    .. color-block::
      :caption: Oracle
             
      :green:`<имя параметра>` :red:`[IN]` :green:`<тип данных>` 
            :green:`[{:=|DEFAULT} <значение>]`                  
  	                                                              
    .. code-block:: 
      :greenlines: 1, 2, 3
      :caption: Rdb

      <имя параметра> <тип данных> 
          [{=|DEFAULT} <значение>]     

   В Oracle входные параметры могут прописываться с модификатором ``IN`` (необязательным). 
   При конвертации модификатор ``IN`` удаляется. 

   IN-параметрам можно устанавливать значения по умолчанию. Как видно, различия заключаются лишь в операторе присваивания (``:=``). 
   
   .. note::

      В РБД параметры, для которых установлены значения по умолчанию, должны располагаться в самом конце списка, 
      тогда как в Oracle таких ограничений нет.

3. *Замена ключевого слова* ``RETURN``

   Данное ключевое слово заменяется на равнозначное ему ``RETURNS``.

4. *Замена ключевого слова* ``IS`` 
   
   Данное ключевое слово заменяется на равнозначное ему ``AS``.

5. *Удаление* ``;`` 
   
   В конце тела функции после ключевого слова ``END`` в РБД точка с запятой не ставится.

.. code-block:: sql
   :caption: Oracle

   declare
     function getDiscount(pprice number)
       return number;
     l_discount number;
     l_price number := 25;
     function getDiscount(pprice number)
       return number
       is
       begin
         return round(pprice * (10 / 100), 2);
       end;
   begin
     l_discount :=  getDiscount(l_price);
   end;

.. code-block:: sql
   :caption: to Rdb

   EXECUTE BLOCK 
   AS 
     DECLARE function getDiscount(pprice NUMERIC(34, 8))
       RETURNS NUMERIC(34, 8);
     DECLARE l_discount NUMERIC(34, 8);
     DECLARE l_price NUMERIC(34, 8) = 25;
     DECLARE function getDiscount(pprice NUMERIC(34, 8))
       RETURNS NUMERIC(34, 8)
       AS
       begin
         return round(:pprice * (10 / 100), 2);
       end
   BEGIN
      l_discount =  getDiscount(:l_price);
   END;


Преобразование определения подфункции с OUT параметрами
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Сравнение операторов определения подфункций *с хотя бы одним OUT-параметром*:

  
.. container:: twocol
          
  .. code-block::
    :redlines: 3
    :greenlines: 1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12
    :caption: Oracle
    
    FUNCTION <имя> (<OUT-пар.>[,<IN|OUT-пар.>])
    RETURN <тип возвр.значения> 
    [DETERMINISTIC]
    { IS | AS } [<блок объявлений>]
    BEGIN
        <блок операторов>
        RETURN <результат>;




    END;

  .. code-block:: 
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
    :caption: Rdb
    
    DECLARE PROCEDURE <имя> (<OUT-пар.>[,...]);
    RETURNS (RET_VAL <тип возвр.знач.>,
             <OUT-параметр>_OUT [,...])
    AS [<блок объявлений>]
    BEGIN
        <блок операторов>
        RET_VAL = <результат>;
        <OUT-параметр>_OUT = <OUT-параметр>; 
        [<OUT-параметр2>_OUT =<OUT-параметр2>;...]
        SUSPEND;
        EXIT;
    END

При конвертации определения подфункций с OUT параметрами выполняются следующие задачи:

1. *Преобразование функции в селективную процедуру*
   
   Если в подфункции присутствует хотя бы один OUT-параметр, она преобразуется в селективную процедуру в РБД. 
   Для этого выполняются следующие действия:
   
   .. unindented_list::
      
      - ключевое слово ``FUNCTION`` заменяется на ключевое слово ``PROCEDURE``.
      - предложение ``RETURN <тип возвращаемого значения>`` заменяется конструкцией
        ``RETURNS`` со списком выходных параметров:

        - добавляется параметр ``RET_VAL``, который принимает тип возвращаемого значения;
        - дублируется список всех OUT-параметров с добавлением суффикса ``"_OUT"``.

      - перед завершением процедуры осуществляется присваивание значений переменной ``RET_VAL`` и остальным выходным параметрам. 
        После чего выполняется команда ``SUSPEND; EXIT;``.

2. *Добавление ключевого слова* ``DECLARE``
   
   Перед объявлением подпроцедуры в РБД добавляется ключевое слово  ``DECLARE``.

3. *Преобразование OUT-параметров*

   Сравним синтаксис задания OUT-параметров (Oracle) и входных параметров (РБД):

   .. container:: twocol
    
    .. color-block::
      :caption: Oracle
             
      :green:`<имя параметра>` :red:`{OUT|IN OUT} [NOCOPY]` 
                            :green:`<тип данных>`
                 
  	                                                              
    .. code-block:: 
      :greenlines: 1, 2, 3
      :caption: Rdb
             
      <имя параметра> <тип данных> 
      :addline:

   Модификаторы ``OUT`` и ``IN OUT`` не используются и удаляются. Следует отметить, что в РБД отсутствует аналог модификатора ``NOCOPY``, 
   который также подлежит исключению.

4. *Преобразование IN-параметров* 

   Сравним синтаксис задания IN-параметров (Oracle) и входных параметров (РБД):

   .. container:: twocol
    
    .. color-block::
      :caption: Oracle
             
      :green:`<имя параметра>` :red:`[IN]` :green:`<тип данных>` 
            :green:`[{:=|DEFAULT} <значение>]`                  
  	                                                              
    .. code-block:: 
      :greenlines: 1, 2, 3
      :caption: Rdb
             
      <имя параметра> <тип данных> 
          [{=|DEFAULT} <значение>]     

   В Oracle входные параметры могут прописываться с модификатором ``IN`` (необязательным). 
   При конвертации модификатор ``IN`` удаляется. 

   IN-параметрам можно устанавливать значения по умолчанию. Как видно, различия заключаются лишь в операторе присваивания (``:=``). 
   
   .. note::

      В РБД параметры, для которых установлены значения по умолчанию, должны располагаться в самом конце списка, 
      тогда как в Oracle таких ограничений нет.

5. *Удаление ключевого слова* ``DETERMINISTIC``
   
   В РБД процедуры не могут быть детерминированными.

6. *Замена ключевого слова* ``IS`` 
   
   Данное ключевое слово заменяется на равнозначное ему ``AS``.

7. *Удаление* ``;`` 
   
   В конце тела процедуры после ключевого слова ``END`` в РБД точка с запятой не ставится.

.. code-block:: sql
   :caption: Oracle

   declare
     x number := 10;
     y number;
     z number := 20;
     r number;
     function fun (a in number,b out number, c in out number)
       return number
       is
       begin
         b := a + 30;
         c := c + a;
         return(100);
       end;
   begin
     r:=fun(x,y,z);
   end;

.. code-block:: sql
   :caption: to Rdb

   EXECUTE BLOCK 
   AS 
     DECLARE x NUMERIC(34, 8) = 10;
     DECLARE y NUMERIC(34, 8);
     DECLARE z NUMERIC(34, 8) = 20;
     DECLARE r NUMERIC(34, 8);
     DECLARE PROCEDURE fun (a NUMERIC(34, 8), b NUMERIC(34, 8), c NUMERIC(34, 8))
       RETURNS (RET_VAL NUMERIC(34, 8), B_OUT NUMERIC(34, 8), C_OUT NUMERIC(34, 8))
       as
       begin
         b = :a + 30;
         c = :c + :a;
         RET_VAL = (100);
         B_OUT = B;
         C_OUT = C;
         SUSPEND;
         EXIT;
       end
     DECLARE FUN_RET_VAL NUMERIC(34, 8);
   BEGIN
     SELECT RET_VAL, B_OUT, C_OUT  
     FROM fun(:x,:y,:z) INTO FUN_RET_VAL, y, z;
     :r = FUN_RET_VAL;
   END;

Оператор ``IF`` 
------------------------

Оператор ``IF`` в Oracle имеет следующую структуру:

.. code-block::
    :greenlines: 1,2,3,4,5,6,7,8,9,10
    :caption: Oracle
    
    IF <условие_1> 
    THEN <группа_операторов_1>
    [ ELSIF <условие_2> 
      THEN <группа_операторов_2>]
    [ ELSIF <условие_3> 
      THEN <группа_операторов_3>]
    ...
    [ ELSE <группа_операторов_else> ]
    END IF;

Рассмотрим разные варианты применения оператора и сравним синтаксис с СУБД Ред База Данных.


Преобразование оператора ``IF`` без условия ``ELSIF``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Сравним синтаксис оператора ``IF-THEN-ELSE``:

.. container:: twocol
          
  .. code-block::
      :greenlines: 1,2,3,4
      :caption: Oracle
      
      IF <условие_1> 
      THEN <группа_операторов_1>
      [ELSE <группа_операторов_else>]
      END IF;
                  
  .. code-block:: 
      :greenlines: 1,2,3
      :caption: Rdb
      
      IF (<условие_1>)
      THEN [BEGIN] <группа_операторов_1> [END]
      [ELSE [BEGIN] <группа_операторов_else> [END]]
      :addline:

При конвертации оператора ``IF-THEN-ELSE`` выполняются следующие задачи:

1. *Условие заключается в скобки*
   
   В РБД условие ``IF`` должно быть заключено в круглые скобки.

2. *Объединение операторов в блок* ``BEGIN-END``

   Если в группе операторов, следующих за ключевым словом ``THEN`` или ``ELSE``, 
   содержится более одного оператора, то эта группа заключается в блок ``BEGIN-END``.

3. *Удаление* ``END IF;``
   
   В РБД ключевые слова ``END IF;`` отсутствуют в операторе ``IF``.

.. container:: twocol

  .. code-block:: sql
    :caption: Oracle

    DECLARE
      PROCEDURE p ( sales  NUMBER, 
                    quota  NUMBER, 
                    emp_id NUMBER)
      IS
        bonus  NUMBER := 0;
        updated  VARCHAR2(3) := 'No';
      BEGIN
        IF sales > (quota + 200) 
        THEN
          bonus := (sales - quota)/4;
          updated := 'Yes';
        ELSE
          IF sales > quota 
          THEN
            bonus := 50;
            updated := 'Yes';
          ELSE
            bonus := 0;
          END IF;
        END IF;
        UPDATE emplo
          SET salary = salary + bonus
          WHERE employee_id = emp_id ;
      END p;
    BEGIN
      p(10100, 10000, 120);
      p(10500, 10000, 121);
      p(9500, 10000, 122);
    END;

  .. code-block:: sql
    :caption: to Rdb

    EXECUTE BLOCK AS    
      DECLARE PROCEDURE p (sales NUMERIC(34, 8), 
                           quota NUMERIC(34, 8), 
                           emp_id NUMERIC(34, 8))
      AS
        DECLARE bonus  NUMERIC(34, 8) = 0;
        DECLARE updated  VARCHAR(3) = 'No';
      BEGIN
        IF (:sales > (:quota + 200)) 
        THEN BEGIN
          bonus = (:sales - :quota)/4;
          updated = 'Yes';
        END
        ELSE
          IF (:sales > :quota) 
          THEN BEGIN
            bonus = 50;
            updated = 'Yes';
          END
          ELSE
            bonus = 0;
        UPDATE emplo
          SET salary = salary + :bonus
          WHERE employee_id = :emp_id ;
      END /*p*/
    BEGIN
      EXECUTE PROCEDURE p(10100, 10000, 120);
      EXECUTE PROCEDURE p(10500, 10000, 121);
      EXECUTE PROCEDURE p(9500, 10000, 122);
    END;

Преобразование оператора ``IF`` c условием ``ELSIF``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Сравним синтаксис оператора ``IF-THEN-ELSIF-ELSE``:

.. container:: twocol
          
  .. code-block::
    :greenlines: 1,2,3,4,5,6,7,8,9,10, 11
    :caption: Oracle
    
    IF <условие_1> 
    THEN <группа_операторов_1>
    ELSIF <условие_2> 

    THEN <группа_операторов_2>
    ELSIF <условие_3> 

    THEN <группа_операторов_3>
    ...
    [ ELSE <группа_операторов_else> ]
    END IF;
                  
  .. code-block:: 
    :greenlines: 1,2,3,4,5,6,7,8,9,10
    :caption: Rdb
      
    IF (<условие_1>)
    THEN [BEGIN] <группа_операторов_1> [END]
    ELSE 
      IF (<условие_2>)
      THEN [BEGIN] <группа_операторов_2> [END]
      ELSE 
        IF (<условие_3>)
        THEN [BEGIN] <группа_операторов_3> [END]
        ...
        [ELSE [BEGIN] <группа_операт_else> [END]]
    :addline:


При конвертации оператора ``IF-THEN-ELSE`` c условием ``ELSIF`` выполняются следующие задачи:

1. *Преобразование во вложенный оператор* ``IF-THEN-ELSE``
   
   Ввиду отсутствия в РБД конструкции ``ELSIF``, оператор ``IF`` преобразуется во вложенный (``ELSE-IF``). 

2. *Условия заключается в скобки*
   
   В РБД условия ``IF`` и ``ELSIF`` должны быть заключены в круглые скобки.

3. *Объединение операторов в блок* ``BEGIN-END``

   Если в группе операторов, следующих за ключевым словом ``THEN`` или ``ELSE``, 
   содержится более одного оператора, то эта группа заключается в блок ``BEGIN-END``.

4. *Удаление* ``END IF;``
   
   В РБД ключевые слова ``END IF;`` отсутствуют в операторе ``IF``.

.. container:: twocol

  .. code-block:: sql
    :caption: Oracle

    CREATE FUNCTION grade_meaning (grade CHAR)
    RETURN VARCHAR2
    IS
      pass BOOLEAN := True;
      res char(15) := '';
    BEGIN
      IF grade = 'A' THEN
        res := 'Excellent'; pass := True;
      ELSIF grade = 'B' THEN
        res := 'Very Good'; pass := True;
      ELSIF grade = 'C' THEN
        res := 'Good'; pass := True;
      ELSIF grade = 'D' THEN
        res := 'Fair'; pass := False;
      ELSIF grade = 'F' THEN
        res := 'Poor'; pass := False;
      ELSE
        res := 'Error'; pass := False;
      END IF;
      RETURN res;
    END;

  .. code-block:: sql
    :caption: to Rdb

    CREATE FUNCTION grade_meaning (grade CHAR)
    RETURNS VARCHAR(32765)
    AS
      DECLARE pass BOOLEAN = True;
      DECLARE res char(15) = '';
    BEGIN
      IF (:grade = 'A') THEN
      BEGIN res = 'Excellent'; pass = True; END
      ELSE IF (:grade = 'B') THEN
      BEGIN res = 'Very Good'; pass = True; END
      ELSE IF (:grade = 'C') THEN 
      BEGIN res = 'Good'; pass = True; END
      ELSE IF (:grade = 'D') THEN 
      BEGIN res = 'Fair'; pass = False; END
      ELSE IF (:grade = 'F') THEN 
      BEGIN res = 'Poor'; pass = False; END
      ELSE 
      BEGIN res = 'Error'; pass = False; END

      RETURN res;
    END;


Оператор WHILE LOOP
---------------------

Сравним синтаксис оператора цикла ``WHILE``:

.. container:: twocol
          
  .. color-block::
      :caption: Oracle
      
      :green:`WHILE <условие>`
      :green:`LOOP`
        :green:`<группа_операторов>`
      :green:`END LOOP` :red:`[<метка>]` :green:`;`

  .. code-block:: 
      :greenlines: 1,2,3
      :caption: Rdb
      
      WHILE (<условие>) 
      DO 
        [BEGIN] <группа_операторов> [END]
      :addline:

При конвертации оператора ``WHILE`` выполняются следующие задачи:

1. *Условие заключается в скобки*

   В РБД условное выражение после ключевого слова ``WHILE`` должно быть заключено в круглые скобки.

2. *Замена ключевого слова* ``LOOP``
   
   Ключевое слово ``LOOP`` заменяется на ключевое слово ``DO``.

3. *Объединение операторов в блок* ``BEGIN-END``

   Если в группе операторов, следующих за ключевым словом ``LOOP``, 
   содержится более одного оператора, то эта группа заключается в блок ``BEGIN-END``.

4. *Удаление* ``END LOOP;``
   
   В РБД ключевые слова ``END LOOP;`` не применяются.

5. *Метка комментируется*

   Если в конце оператора присутствует метка, она комментируется.

.. container:: twocol
          
  .. code-block:: sql
     :caption: Oracle

     DECLARE
       counter NUMBER := 1;
     BEGIN
       WHILE counter <= 5
       LOOP
         counter := counter + 1;
       END LOOP;
     END;

  .. code-block:: sql
     :caption: to RDB

     EXECUTE BLOCK AS 
       DECLARE counter NUMERIC(34, 8) = 1;
     BEGIN
       WHILE (:counter <= 5) 
       DO BEGIN
         counter = :counter + 1;
       END
     END;


Оператор FOR LOOP
---------------------

.. container:: twocol
          
  .. code-block::
    :greenlines: 1,2,3,4,5
    :caption: Oracle
    
    FOR <имя переменной> 
    IN <нижняя граница> .. <верхняя граница>
    LOOP <оператор> [<оператор>...]

    END LOOP [<метка>] ;

  .. code-block:: 
      :greenlines: 1,2,3,4,5
      :caption: Rdb
      
      <имя переменной> = <нижняя граница>;
      WHILE (<имя переменной> <= <верхняя граница>) 
      DO BEGIN <оператор> [<оператор>...]
      <имя переменной> = <имя переменной>+1
      END;


.. container:: twocol
          
  .. code-block::
    :greenlines: 1,2,3,4,5
    :caption: Oracle
    
    FOR <имя переменной> 
    IN REVERSE <нижн. граница>..<верх. граница>
    LOOP <оператор> [<оператор>...]

    END LOOP [<метка>] ;      
        
  .. code-block:: 
    :greenlines: 1,2,3,4,5
    :caption: Rdb
    
    <имя переменной> = <верхняя граница>;
    WHILE (<имя переменной> >= <нижняя граница>) 
    DO BEGIN <оператор> [<оператор>...] 
    <имя переменной> = <имя переменной>-1
    END;


Оператор FOR LOOP для оператора SELECT
-----------------------------------------

.. container:: twocol
          
  .. code-block::
    :greenlines: 1,2,3,4
    :caption: Oracle
    
    FOR <имя переменной типа RECORD> 
    IN (<SELECT-запрос>)
    LOOP <оператор> [<оператор>...] 
    END LOOP [<метка>] ;

        
  .. code-block:: 
    :greenlines: 1,2,3,4
    :caption: Rdb
    
    FOR <оператор SELECT>
    INTO [:]<имя переменной типа RECORD>
    DO <оператор> [<оператор>...] 
    ;


Оператор LOOP
---------------

.. container:: twocol
          
  .. code-block::
    :greenlines: 1,2,3
    :caption: Oracle
    
    LOOP 
      <оператор> [<оператор>...]
    END LOOP [<метка>] ;

  .. code-block:: 
      :greenlines: 1,2,3
      :caption: Rdb
      
      WHILE (TRUE)
      DO [BEGIN] <оператор> [<оператор>...]
      [END] ;


Оператор простого CASE
-----------------------

.. container:: twocol
          
  .. code-block::
    :greenlines: 1,2,3,4,5
    :caption: Oracle
    
    CASE <поисковое выражение>
    WHEN <выражение 1> THEN <результат 1> ;
    [WHEN <выражение 2> THEN <результат 2>;]...
    [ELSE <значение по умолчанию>;]
    END CASE [<<метка>>];

  .. code-block:: 
      :greenlines: 1,2,3,4,5
      :caption: Rdb
      
      CASE <поисковое выражение>
      WHEN <выражение 1> THEN <результат 1>
      [WHEN <выражение 2> THEN <результат 2>]...
      [ELSE <значение по умолчанию>]
      END;


Оператор поискового CASE
--------------------------

.. container:: twocol
          
  .. code-block::
    :greenlines: 1,2,3,4,5
    :caption: Oracle
    
    CASE
    WHEN <лог.выражение_1> THEN <результат_1>;
    [WHEN <лог.выражение_2> THEN <результат_2>;]
    [ELSE <выражение по умолчанию>;]
    END CASE [<<метка>>] ;

  .. code-block:: 
      :greenlines: 1,2,3,4,5
      :caption: Rdb

      CASE
      WHEN <лог.выражение_1> THEN <результат_1>
      [WHEN <лог.выражение_2> THEN <результат_2>]..
      [ELSE <выражение по умолчанию>]
      END


Операторы перехода
-------------------


Оператор EXIT
^^^^^^^^^^^^^^

.. container:: twocol
          
  .. code-block::
    :greenlines: 1
    :redlines: 2
    :caption: Oracle
    
    EXIT [<метка>] 
    [WHEN <булево выражение>] ;

  .. code-block:: 
    :greenlines: 1
    :caption: Rdb
    
    EXIT;
    :addline:




Оператор CONTINUE
^^^^^^^^^^^^^^^^^^^

.. container:: twocol
          
  .. code-block::
      :greenlines: 1
      :redlines: 2
      :caption: Oracle
      
      CONTINUE [<метка>] 
      [WHEN <булево выражение>] ;


  .. code-block:: 
      :greenlines: 1
      :caption: Rdb
      
      CONTINUE [<метка>];
      :addline:



Вызов процедуры
-------------------




Операция присваивания
-----------------------

.. container:: twocol
          
  .. code-block::
      :greenlines: 1
      :caption: Oracle
      
      <имя переменной> := <выражение>;

  .. code-block:: 
      :greenlines: 1
      :caption: Rdb
      
      <имя переменной> = <выражение>;



Оператор EXECUTE IMMEDIATE
----------------------------------

          
.. code-block::
    :redlines: 3,4,5,6,7,8
    :greenlines: 1,2,9
    
    EXECUTE IMMEDIATE '<оператор>'
    [ { INTO { <имя переменной> [, <имя переменной> ]... | <перемення типа RECORD> } 
      | BULK COLLECT INTO { <коллекция>|<:host_array>}
        [, {<коллекция>|<:host_array> } ]... 
      } [USING [IN|OUT|IN OUT] <аргумент привязки> [ [,] [[IN|OUT|IN OUT] <аргумент привязки> ]...]]
    | USING [IN|OUT|IN OUT] <аргумент привязки> [ [,] [[IN|OUT|IN OUT] <аргумент привязки> ]...] 
      [ { RETURNING | RETURN } { INTO ... | BULK COLLECT INTO ... } ]
    | { RETURNING | RETURN } { INTO ... | BULK COLLECT INTO ... } 
    ] ;

                  
.. container:: twocol
          
  .. code-block::
    :greenlines: 1,2
    :redlines: 3
    :caption: Oracle
    
    EXECUTE IMMEDIATE '<оператор>'
    [INTO { <имя перем-ой> [, <имя перем-ой>...]
          | <перемення типа RECORD>}];

  .. code-block:: 
    :greenlines: 1,2
    :redlines: 3
    :caption: Rdb
    
    EXECUTE STATEMENT '<оператор>'
    [INTO {[:]<имя перем-ой> [,[:]<имя перем-ой>]
          | <перемення типа RECORD> } ]


Оператор Pragma AUTONOMOUS_TRANSACTION
----------------------------------------    



.. container:: twocol
          
  .. color-block::
    :caption: Oracle
    
    :green:`PRAGMA AUTONOMOUS_TRANSACTION;`:par:`c`
    

  .. code-block::
    :greenlines: 1,2
    :caption: Rdb
    
    IN AUTONOMOUS TRANSACTION DO
    BEGIN <блок psql операторов> END


.. _sub:declare_exception:

Работа с исключениями
---------------------------

В Oracle существуют два вида исключений:

- системные исключения, объявленные в пакете ``STANDARD`` (например, ``NO_DATA_FOUND``, ``TOO_MANY_ROWS``, ``ZERO_DIVIDE`` и др.). 
- пользовательские исключения, которые явно объявляются в анонимном блоке, процедуре, функции, триггере или пакете.

Преобразование объявления пользовательских исключений рассмотрено в :numref:`подразделе %s <sub:userexception>`. 

В РБД все исключения создаются глобально и видны каждой подпрограмме.
Если при обработке PL/SQL блока (подпрограммы, пакета, триггера) встречаются системные исключения, 
то при конвертации они создаются с одноименным именем в начале скрипта:

.. _exam:new_exception:

.. code-block:: sql
  :caption: Oracle
   
  DECLARE
     l_company_id INTEGER;
  BEGIN
     IF l_company_id IS NULL
     THEN
        RAISE VALUE_ERROR;
     END IF;
  END;

.. code-block:: sql
  :caption: to Rdb

  CREATE EXCEPTION VALUE_ERROR 'ошибка числа или значения';
  
  EXECUTE BLOCK
  AS 
    DECLARE l_company_id INTEGER;
  BEGIN
    IF (:l_company_id IS NULL)
    THEN
        EXCEPTION VALUE_ERROR;
  END;


Ниже рассмотрены операции инициирования исключительных ситуаций и их обработка.

Инициирование исключений
^^^^^^^^^^^^^^^^^^^^^^^^^^

Исключение может быть инициировано в подпрограмме Oracle тремя способами:

- при обнаружении ошибки;
- командой ``RAISE``;
- встроенной процедурой ``RAISE_APPLICATION_ERROR``.

Команда RAISE
""""""""""""""

Чтобы разработчик имел возможность самостоятельно инициировать именованные исключения, в Oracle 
поддерживается команда ``RAISE``. С ее помощью можно инициировать как собственные, так и системные исключения. 
Команда имеет три формы:

.. code-block::
   :greenlines: 1,2,3
   :caption: Oracle

   RAISE <имя_исключения>;
   RAISE <имя_пакета.имя_исключения>;
   RAISE;

Первая форма (без имени пакета) может инициировать исключения, определенные в текущем блоке 
(или в содержащем его блоке), а также системные исключения.

Если исключение объявлено в пакете (но не в ``STANDARD``) и инициируется извне, имя исключения необходимо уточнить именем пакета.

Третья форма ``RAISE`` не требует указывать имя исключения, но используется только в условии ``WHEN`` обработчика исключений. 
Эта форма используется для повторного инициирования (передачи) перехваченного исключения.

Команда ``RAISE`` аналогична оператору ``EXCEPTION`` в РБД:

.. code-block::
   :greenlines: 1
   :caption: to Rdb

   EXCEPTION <имя_исключения>;

Пример можно найти :ref:`выше<exam:new_exception>`.


Процедура RAISE_APPLICATION_ERROR
"""""""""""""""""""""""""""""""""""

Для инициирования исключений Oracle предоставляет процедуру ``RAISE_APPLICATION_ERROR``. 

.. container:: twocol
      
  .. code-block::
    :greenlines: 1, 2, 3, 4
    :caption: Oracle

    RAISE_APPLICATION_ERROR ( <код ошибки>, 
                              '<текст ошибки>');
    :addline:
                                          
  .. code-block:: 
    :greenlines: 1, 2, 3 
    :caption: Rdb
    
    CREATE EXCEPTION CUSTOM_EXCEPTION 'error';
    ...
    EXCEPTION CUSTOM_EXCEPTION('<текст ошиб.>');


Ее преимущество перед командой ``RAISE`` заключается в том, что она позволяет связать с исключением сообщение об ошибке.

При конвертации процедуры ``RAISE_APPLICATION_ERROR`` выполняются следующие задачи:

1. *Создание нового исключения*

   Если в коде встречаются процедуры ``RAISE_APPLICATION_ERROR``, создается исключение с именем ``CUSTOM_EXCEPTION``.
2. *Замена на оператор*  ``EXCEPTION``

   Вызов исключения процедурой ``RAISE_APPLICATION_ERROR`` заменяется оператором ``EXCEPTION CUSTOM_EXCEPTION`` с тем же текстом ошибки.


.. code-block:: sql
  :caption: Oracle

  begin
    raise_application_error(-20134, 'Неправильный номер паспорта');
  end;

.. code-block:: sql
  :caption: to Rdb

  CREATE EXCEPTION CUSTOM_EXCEPTION 'error';
  
  EXECUTE BLOCK 
  AS
  BEGIN
     EXCEPTION CUSTOM_EXCEPTION ('Неправильный номер паспорта');
  END;


Обработка исключений (Exception Handler)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Для обработки ошибочных ситуаций базы данных и пользовательских исключений в PL/SQL используется конструкция ``EXCEPTION-WHEN-THEN``.
Для РБД существует аналогичная конструкция ``WHEN-DO``, которая также добавляется в конце блока.

.. container:: twocol
          
  .. code-block::
    :greenlines: 1,2,3,4,5,6,7,8,9,10
    :caption: Oracle
    
    EXCEPTION
      WHEN { <имя искл-я> 
            [OR <имя искл-я>]... 
          | OTHERS }
      THEN 
        <оператор>; [ <оператор>; ]...

      [WHEN { <имя искл-я> [ OR <имя искл-я> ]... 
          | OTHERS }
      THEN <оператор>; [<оператор>;]...]
      
  .. code-block:: 
    :greenlines: 1,2,3,4,5,6,7,8,9,10
    :caption: Rdb
    
    /*EXCEPTION*/
    WHEN { EXCEPTION <имя искл-я> 
          [, EXCEPTION <имя искл-я> ...] 
        | ANY }
    DO [BEGIN] 
        <оператор>; [ <оператор>; ]...
    [END]
    [WHEN {<имя искл-я> [, <имя искл-я>...] 
          | ANY}
    DO [BEGIN] <оператор>;[<оператор>;]...[END]]
  	 
При конвертации блока обработки исключений выполняются следующие задачи: 

1. *Комментируется ключевое слово* ``EXCEPTION``
   
   Перед блоками ``WHEN`` ключевое слово ``EXCEPTION`` в РБД не применяется.
2. *Добавление* ``EXCEPTION`` *перед именем исключения*
   
   В Oracle исключения перечисляются просто по имени, в РБД перед именем исключения добавляется ключевое слово ``EXCEPTION``.
   
3. *Замена логического оператора* ``OR`` 
   
   Если после ключевого слова ``WHEN`` перечисляются несколько исключений, то операторы ``OR`` заменяется на запятые.
4. *Замена ключевого слова* ``OTHERS``
   
   Заменяется на аналогичное ему ``ANY``.
5. *Замена ключевого слова* ``THEN``
   
   Заменяется на аналогичное ``DO BEGIN ... END``.

.. code-block:: sql
  :caption: Oracle

  CREATE OR REPLACE PROCEDURE add_new_order
    (order_id_in IN NUMBER, sales_in IN NUMBER)
  IS
    no_sales EXCEPTION;
    bad_sales EXCEPTION;
  BEGIN
    IF sales_in = 0 THEN
       RAISE no_sales;
    ELSIF sales_in < 0 THEN
       RAISE bad_sales;
    ELSE
       INSERT INTO orders (order_id, total_sales )
       VALUES ( order_id_in, sales_in );
    END IF;
  EXCEPTION
    WHEN no_sales or bad_sales THEN
       raise_application_error (-20001,'У вас должны быть продажи по заказу, для закрытия заказа.');
    WHEN OTHERS THEN
       raise_application_error (-20002,'Произошла ошибка при добавлении заказа.');
  END;


.. code-block:: sql
  :caption: to Rdb

  CREATE EXCEPTION NO_SALES 'error';
  CREATE EXCEPTION BAD_SALES 'error';
  CREATE EXCEPTION CUSTOM_EXCEPTION 'error';

  CREATE OR ALTER PROCEDURE add_new_order
     (order_id_in  NUMERIC(34, 8), sales_in  NUMERIC(34, 8))
  AS
  BEGIN
     IF (:sales_in = 0) THEN
       EXCEPTION no_sales;
     ELSE IF (:sales_in < 0) THEN
       EXCEPTION bad_sales;
     ELSE
       INSERT INTO orders (order_id, total_sales )
       VALUES ( :order_id_in, :sales_in );

     /*EXCEPTION*/
     WHEN EXCEPTION NO_SALES, EXCEPTION BAD_SALES DO
     BEGIN
       EXCEPTION CUSTOM_EXCEPTION ('У вас должны быть продажи по заказу, для закрытия заказа.');
     END
     WHEN ANY DO
     BEGIN
        EXCEPTION CUSTOM_EXCEPTION ('Произошла ошибка при добавлении заказа.');
     END
  END;


Работа с курсорами
-------------------

Ниже рассмотрены основные операции для работы с курсорами: :ref:`открытие <subsec:open>`, :ref:`закрытие <subsec:close>`, 
:ref:`извлечение данных <subsec:fetch>`, :ref:`оператор цикла <subsec:forloopcursor>`.
Курсоры в PL/SQL также имеют 4 атрибута, указывающих их состояние и результаты работы: 
``%ROWCOUNT``, ``%FOUND``, ``%ISOPEN``, ``%NOTFOUND``. Их конвертация описана в подразделе :ref:`subsec:attr`.


.. _subsec:open:

Открытие курсора (``OPEN``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Сравнение синтаксиса открытия курсора:

.. container:: twocol
          
  .. color-block::
    :caption: Oracle
      
      :green:`OPEN <имя курсора>` :red:`[(<список знач. парам.>)]`:green:`;` 

  .. code-block:: 
      :greenlines: 1
      :caption: Rdb
      
      OPEN <имя курсора> ;

:ess:`Замечание:`

- Курсоры с входными параметрами не поддерживаются в РБД и не могут быть сконвертированы.


.. code-block:: sql
    :caption: Oracle
  
    DECLARE
      num testt.num%TYPE;
      cursor c1 is
        SELECT num FROM testt;
    BEGIN
      OPEN c1;
      FETCH c1 into num;
      CLOSE c1;
    END;

.. code-block:: sql
    :caption: to Rdb
  
    EXECUTE BLOCK
    AS 
      DECLARE num TYPE OF COLUMN testt.num;
      DECLARE c1 CURSOR FOR
        (SELECT num FROM testt);
    BEGIN
      OPEN c1;
      FETCH c1 into :num;
      CLOSE c1;
    END;


.. _subsec:close:

Закрытие курсора (``CLOSE``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Сравнение синтаксиса закрытия курсора:

.. container:: twocol
          
  .. code-block::
    :redlines: 2,3
    :greenlines: 1
    :caption: Oracle
    
    CLOSE { <имя курсора> 
          | <имя переменной типа REF CURSOR> 
          | :<host_cursor_variable> } ;


  .. code-block:: 
    :greenlines: 1
    :caption: Rdb
    
    CLOSE <имя курсора>;

    :addline:

:ess:`Замечание:`

- Типы ``REF CURSOR`` не поддерживаются в РБД и не могут быть сконвертированы.

.. _subsec:fetch:

Получение данных из курсора (``FETCH``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Сравнение синтаксиса получения данных из курсора:

.. container:: twocol
          
  .. code-block::
      :redlines: 2,3,6,7
      :greenlines: 1,4,5,8
      :caption: Oracle
      
      FETCH { <курсор>
            | <переменная курсора>
            | :<host_cursor_variable> }
      { INTO { <переменная> [,<переменная>...]
            | <переменная типа RECORD>} 
      | BULK COLLECT INTO <список коллекций> 
        [LIMIT <числовое выражение>] 
      };

  .. code-block:: 
      :greenlines: 1,4,5
      :caption: Rdb
      
      FETCH <курсор>


      [INTO { [:]<переменная>[,[:]<переменная>...]
            | <переменная типа RECORD>}];


      :addline:
             

:ess:`Замечание:`

- Типы ``REF CURSOR`` не поддерживаются в РБД и не могут быть сконвертированы.
- Конструкция ``BULK COLLECT INTO`` удаляется, т.к. РБД не поддерживает типы коллекций



.. _subsec:forloopcursor:

Оператор FOR LOOP для курсора
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Рассмотрим синтаксис оператора цикла ``FOR`` для курсоров:

.. color-block::
    :caption: Oracle
    
    :green:`FOR <имя переменной цикла> IN <имя курсора>` 
      :red:`[(<список значений параметров>)]`
    :green:`LOOP` 
      :green:`<оператор> [<оператор>...]`
    :green:`END LOOP` :red:`[<метка>]` :green:`;`


Оператор цикла ``FOR LOOP`` для курсора автоматически создает переменную цикла типа Record и затем инициирует открытие курсора.

На каждой итерации из набора результатов извлекается строка и помещается в переменную цикла, что означает, что оператор ``FOR`` 
неявно выполняет операцию ``FETCH``. Когда строки для извлечения заканчиваются, курсор закрывается. Кроме того, курсор будет закрыт, 
если управление передается за пределы цикла или происходит вызов исключения внутри него.

Аналогичного оператора цикла для курсоров в РБД нет, поэтому при конвертации выполняются следующие задачи:

1. *Замена цикла* ``FOR`` *на* ``WHILE`` 

   Чтобы имитировать работу цикла ``FOR`` в Oracle, создается цикл ``WHILE`` с условием для контекстной переменной ``ROW_COUNT`` - 
   она не должна быть нулевой. В конце цикла добавляется оператор ``FETCH`` для извлечения следующего набора данных.

   .. container:: twocol
      
    .. code-block::
      :greenlines: 1, 2, 3, 4, 5
      :caption: Oracle
        
      FOR <перем. цикла> IN <имя курсора> 
      LOOP
          <оператор> [<оператор>...] 

      END LOOP;

    .. code-block:: 
      :greenlines: 1, 2, 3, 4, 5
      :caption: Rdb
      
      WHILE ( ROW_COUNT != 0 ) DO
      BEGIN  
      <оператор> [<оператор>...] 
      FETCH <имя курсора> INTO <пер.цикла>;
      END 

2. *Добавление переменной цикла*
   
   В Oracle данные на каждой итерации извлекаются в переменную цикла (которая создается неявно). 
   Поэтому требуется явно задать переменную цикла с типом данных записей курсора.

   .. code-block:: redstatement
    :caption: Rdb
    :greenlines: 1
  
    DECLARE VARIABLE <имя пер.цикла> TYPE OF TABLE <имя курсора>;

3. *Открытие курсора и извлечение первого значения*

   Перед циклом ``WHILE`` требуется явно открыть курсор (``OPEN``). А также извлечь первую строку из набора данных (``FETCH``).

Таким образом, преобразование конструкции ``FOR`` будет иметь следующий синтаксис:

.. code-block:: 
    :greenlines: 1,2,3,4,5,6,7,8,9, 10, 11
    :caption: to Rdb
    
    DECLARE VARIABLE <имя пер.цикла> TYPE OF TABLE <имя курсора>;
    ...
    OPEN <имя курсора>;
    FETCH <имя курсора> INTO <item>;
    WHILE ( ROW_COUNT != 0 ) DO 
    BEGIN
      <оператор> [<оператор>...] 
      FETCH <имя курсора> INTO <item>;
    END
    CLOSE <имя курсора>;
    ... 

.. code-block:: sql
  :caption: Oracle

  DECLARE
    total_val number(6);
    cursor c1 is
      SELECT * FROM testt WHERE id = 2;
  BEGIN
    total_val := 0;
    FOR i in c1
    LOOP
       total_val := total_val + i.num;
    END LOOP;
  END;


.. code-block:: sql
  :caption: to Rdb

  EXECUTE BLOCK 
  AS 
    DECLARE total_val NUMERIC(6);
    DECLARE c1 CURSOR FOR
      (SELECT * FROM testt WHERE id = 2);
    DECLARE VARIABLE C1_I TYPE OF TABLE C1;
  BEGIN
    total_val = 0; 
    OPEN C1;
    FETCH C1 INTO C1_I;
    WHILE ( ROW_COUNT != 0 ) DO 
    BEGIN
       total_val = :total_val + C1_I.num;
       FETCH C1 INTO C1_I;
    END
    CLOSE C1;
  END;



.. _subsec:attr:

Атрибуты курсора
^^^^^^^^^^^^^^^^^^

%ROWCOUNT
""""""""""""

Атрибут ``%ROWCOUNT`` является числовым атрибутом и возвращает число строк считанных курсором на определенный момент времени. 
В РБД существует контекстная переменная ``ROW_COUNT``,  которая указывает общее количество строк, которые были прочитаны, 
добавлены, изменены или удалены в процессе выполнения предыдущего оператора SQL. 
При конвертации атрибут ``%ROWCOUNT`` заменяется на неё.

.. container:: twocol
      
  .. code-block::
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    :caption: Oracle
    
    <имя курсора>%ROWCOUNT
                                                      
  .. code-block:: 
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    :caption: Rdb
    
    ROW_COUNT

         


.. code-block:: sql
   :caption: Oracle

   CREATE FUNCTION TEST_ROWCOUNT
   RETURN varchar2
   IS
     v_emp emp%ROWTYPE;
     CURSOR c_emp IS
      SELECT * FROM emp WHERE ename='SMITH';
   BEGIN
     OPEN c_emp;
     FETCH c_emp INTO v_emp;
     IF c_emp%ROWCOUNT=1 THEN
       Return 'found';
     ELSE
       Return 'not found';
     END IF;
     CLOSE c_emp;
   END;


.. code-block:: sql
  :caption: to Rdb

  CREATE FUNCTION TEST_ROWCOUNT
  RETURNS VARCHAR(32765)
  AS
    DECLARE VARIABLE v_emp TYPE OF TABLE emp;
    DECLARE c_emp CURSOR FOR
      (SELECT * FROM emp WHERE ename='SMITH');
  BEGIN
    OPEN c_emp;
    FETCH c_emp INTO :v_emp;
    IF (ROW_COUNT=1) THEN
      Return 'found';
    ELSE
      Return 'not found';   
    CLOSE c_emp;
  END;

%FOUND
""""""""""

Данный атрибут является логическим объектом, он возвращает результат ``TRUE``, если последняя операция выборки успешно 
извлекла запись, в противном случае он вернет ``FALSE``.
В РБД существует контекстная переменная ``ROW_COUNT``,  которая указывает общее количество строк, которые были прочитаны, 
добавлены, изменены или удалены в процессе выполнения предыдущего оператора SQL. 
При конвертации атрибут ``%FOUND`` заменяется на выражение ``ROW_COUNT != 0``.

.. container:: twocol
      
  .. code-block::
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    :caption: Oracle
    
    <имя курсора>%FOUND

  .. code-block:: 
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    :caption: Rdb
    
    ROW_COUNT != 0


.. code-block:: sql
   :caption: Oracle

   CREATE FUNCTION TEST_ROWCOUNT
   RETURN varchar2
   IS
     v_emp emp%ROWTYPE;
     CURSOR c_emp IS
      SELECT * FROM emp WHERE ename='SMITH';
   BEGIN
     OPEN c_emp;
     FETCH c_emp INTO v_emp;
     IF c_emp%FOUND THEN
       Return 'found';
     ELSE
       Return 'not found';
     END IF;
     CLOSE c_emp;
   END;


.. code-block:: sql
  :caption: to Rdb

  CREATE FUNCTION TEST_ROWCOUNT
  RETURNS VARCHAR(32765)
  AS
    DECLARE VARIABLE v_emp TYPE OF TABLE emp;
    DECLARE c_emp CURSOR FOR
      (SELECT * FROM emp WHERE ename='SMITH');
  BEGIN
    OPEN c_emp;
    FETCH c_emp INTO :v_emp;
    IF (ROW_COUNT != 0) THEN
      Return 'found';
    ELSE
      Return 'not found';   
    CLOSE c_emp;
  END;



%NOTFOUND
""""""""""""

Данный атрибут является логическим объектом, он возвращает результат ``TRUE``, если последняя операция выборки не смогла 
получить какую-либо запись, в противном случае он вернет ``FALSE``.
В РБД существует контекстная переменная ``ROW_COUNT``,  которая указывает общее количество строк, которые были прочитаны, 
добавлены, изменены или удалены в процессе выполнения предыдущего оператора SQL. 
При конвертации атрибут ``%NOTFOUND`` заменяется на выражение ``ROW_COUNT != 1``.


.. container:: twocol
      
  .. code-block::
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    :caption: Oracle
    
    <имя курсора>%NOTFOUND
                                                    
  .. code-block:: 
    :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    :caption: Rdb
    
    ROW_COUNT != 1


.. code-block:: sql
   :caption: Oracle

   CREATE FUNCTION TEST_ROWCOUNT
   RETURN varchar2
   IS
     v_emp emp%ROWTYPE;
     CURSOR c_emp IS
      SELECT * FROM emp WHERE ename='SMITH';
   BEGIN
     OPEN c_emp;
     FETCH c_emp INTO v_emp;
     IF c_emp%NOTFOUND THEN
       Return 'not found';
     ELSE
       Return 'found';
     END IF;
     CLOSE c_emp;
   END;


.. code-block:: sql
  :caption: to Rdb

  CREATE FUNCTION TEST_ROWCOUNT
  RETURNS VARCHAR(32765)
  AS
    DECLARE VARIABLE v_emp TYPE OF TABLE emp;
    DECLARE c_emp CURSOR FOR
      (SELECT * FROM emp WHERE ename='SMITH');
  BEGIN
    OPEN c_emp;
    FETCH c_emp INTO :v_emp;
    IF (ROW_COUNT != 1) THEN
      Return 'not found';
    ELSE
      Return 'found';   
    CLOSE c_emp;
  END;


%ISOPEN
""""""""

Атрибут ``%ISOPEN``, который проверяет открыт ли курсор в данный момент, не может быть сконвертирован.

.. code-block:: 
   :redlines: 1
   :caption: Oracle

   <имя курсора>%ISOPEN


Типы данных
---------------

.. code-block::
    :redlines: 1,2,3,5,8,10,11,13,14,15
    :greenlines: 4,6,7,9,12,16
    
    { <имя типа Varray>
    | <имя типа вложенных таблиц>
    | [REF] <пользовательский тип>
    | <имя типа RECORD>
    | <имя типа REF CURSOR>
    | <тип данных SQL>
    | <имя курсора>%ROWTYPE
    | <переменная курсора>%ROWTYPE
    | <имя таблицы/представления>%ROWTYPE
    | <переменная типа коллекции>%TYPE
    | <переменная курсора>%TYPE
    | <имя таблицы/представления>.<столбец>%TYPE
    | <имя экземпляра ADT>%TYPE
    | <переменная типа RECORD>[.<поле>]%TYPE
    | <скалярная переменная>%TYPE
    }



- :ess:`Имя типа RECORD`
- :ess:`Тип данных SQL`
- :ess:`Имя курсора%ROWTYPE`
- :ess:`Имя таблицы/представления%ROWTYPE`
- :ess:`Имя таблицы/представления.столбец%TYPE`


.. [1]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.

.. [2]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.

.. [3]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.
