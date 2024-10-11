.. _sec:psql:

Преобразование элементов процедурного языка PSQL
=================================================


Исключения (``EXCEPTION``)
---------------------------------------------

.. _sub:declare_exception:

Объявление пользовательского исключения
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

В Oracle существуют два вида исключений:

- системные исключения, объявленные в пакете ``STANDARD``. 
- пользовательские исключения, которые явно объявляются в анонимном блоке, процедуре, функции, триггере или пакете.

Рассмотрим синтаксис объявления пользовательских исключений в процедуре. Для функции всё аналогично. 
В анонимных блоках и триггерах исключения объявляются в разделе ``DECLARE``.

.. code-block::
    :emphasize-lines: 4,7,8,9
    :greenlines: 1,2,3,4,5,6,7,8,9,10
    :caption: Oracle
    
    CREATE [ OR REPLACE ] PROCEDURE [ <схема>. ] <имя процедуры>
       [ ( <IN|OUT параметр> [, <IN|OUT параметр>]... ) ] 
    {IS|AS} [<объявление>;...] 
            <имя исключения> EXCEPTION;            
    BEGIN 
        <блок операторов> ... 
        RAISE <имя исключения>;
        EXCEPTION
           WHEN <имя исключения> THEN [<обработка исключения>]
    END [<имя процедуры>] ;



Инициирование исключений
^^^^^^^^^^^^^^^^^^^^^^^^^^

Исключение может быть инициировано в подпрограмме Oracle тремя способами:

- при обнаружении ошибки;
- командой ``RAISE``;
- встроенной процедурой ``RAISE_APPLICATION_ERROR``.


Команда RAISE
""""""""""""""

Чтобы разработчик имел возможность самостоятельно инициировать именованные исключения, в Oracle 
поддерживается команда RAISE. С ее помощью можно инициировать как собственные, так и системные исключения. 
Команда имеет три формы:

.. code-block::

    RAISE имя_исключения;
    RAISE имя_пакета.имя_исключения;
    RAISE;

Первая форма (без имени пакета) может инициировать исключения, определенные в текущем блоке 
(или в содержащем его блоке), а также системные исключения.

Если исключение объявлено в пакете (но не в ``STANDARD``) и инициируется извне, имя исключения необходимо уточнить именем пакета.

Третья форма ``RAISE`` не требует указывать имя исключения, но используется только в условии ``WHEN`` обработчика исключений. 
Эта форма используется для повторного инициирования (передачи) перехваченного исключения.


Процедура RAISE_APPLICATION_ERROR
"""""""""""""""""""""""""""""""""""

Для инициирования исключений Oracle предоставляет процедуру ``RAISE_APPLICATION_ERROR``. 
Ее преимущество перед командой ``RAISE`` заключается в том, что она позволяет связать с исключением сообщение об ошибке.


Обработка исключений (Exception Handler)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5,6,7,8,9
             
             EXCEPTION
               WHEN {<имя искл-я> [OR <имя искл-я>]... 
                    | OTHERS }
               THEN 
                  <оператор>; [ <оператор>; ]...

               [WHEN { <имя искл-я> [ OR <имя искл-я> ]... 
                    | OTHERS }
                THEN <оператор>; [<оператор>;]...]
             
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7,8,9
              
                                                        .
             WHEN {<имя искл-я> [, <имя искл-я> ...] 
                  | ANY}
             DO [BEGIN] 
                  <оператор>; [ <оператор>; ]...
             [END]
             [WHEN {<имя искл-я> [, <имя искл-я>...] 
                   | ANY}
              DO [BEGIN] <оператор>;[<оператор>;]...[END]]
  	 

Объявления переменных
-------------------------


В процедурах, функциях, триггерах, пакетах или анонимных PSQL-блоках есть раздел с 
объявлением необходимых элементов языка (переменных, курсоров, подпрограмм и т.д.).

Для примера представим синтаксис создания процедуры с разделом объявления. Для остальных объектов синтаксис аналогичен:


.. code-block::
    :redlines:  11,12
    :greenlines: 1,2,3,4,5,6,7,   9,10,13,14,15,16,   18,19,20
    :emphasize-lines: 3,4
    :caption: Oracle
    
    CREATE [ OR REPLACE ] PROCEDURE [ <схема>. ] <имя процедуры>
    [( <IN|OUT параметр> [, <IN|OUT параметр>]... )] 
    { IS | AS } [ { <объявление_1>;... [<объявление_2>;]... }
                  | <объявление_2>;... ] 
    BEGIN 
        ...
    END [<имя процедуры>] ;

    <объявление_1> ::= { <объявление типа коллекций> 
                       | <объявление типа RECORD> 
                       | <объявление типа REF CURSOR> 
                       | <объявление типа SUBTYPE> 
                       | <объявление курсора> 
                       | <объявление переменных>
                       | <объявление функции> 
                       | <объявление процедуры>}

    <объявление_2> ::= { <объявление функции> | <реализация функции> 
                       | <объявление процедуры> | <реализация процедуры>
                       | <объявление курсора> | <создание курсора> }
    


Объявление типа коллекций
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Объявление ассоциативных массивов и их переменных
""""""""""""""""""""""""""""""""""""""""""""""""""

Синтаксис для определения, а затем объявление переменной типа Associative Arrays в Oracle.

.. code-block::
    :greenlines: 1,2,3,4,5,7
    :caption: Oracle
    
    TYPE <имя типа ассоц.массива> 
    IS TABLE OF <тип данных> [ NOT NULL ] 
    INDEX BY { VARCHAR2 (<размер>)
             | BINARY_INTEGER 
             | PLS_INTEGER };
    
    <имя переменной> <имя типа ассоц.массива>;


.. code-block:: 
    :greenlines: 1,2,3,4,5
    :caption: Rdb
    
    CREATE GLOBAL TEMPORARY TABLE <имя переменной> (
       I1 { VARCHAR(<размер>)
          | INTEGER } NOT NULL PRIMARY KEY,
       VAL <тип данных> [NOT NULL]
    );


Объявление массивов переменной длины
""""""""""""""""""""""""""""""""""""""

В данный момент не конвертируется.


.. code-block::
    :redlines: 1, 2, 3, 4, 5, 6, 7, 8
    :caption: Oracle
    
    TYPE <имя типа Varray> 
    IS {VARRAY | [VARYING] ARRAY} (<число>)
    OF <тип данных> [ NOT NULL ];


Объявление вложенных таблиц
""""""""""""""""""""""""""""

В данный момент не конвертируется.

.. code-block::
    :redlines: 1, 2
    :caption: Oracle
    
    TYPE <имя типа вложенных таблиц> 
    IS TABLE OF <тип данных> [ NOT NULL ];


Объявление типа RECORD
^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4
              
              TYPE <имя типа Record>
              IS RECORD(<имя поля> <тип данных> 
                       [[NOT NULL]{:=|DEFAULT} <выражение>]
                       [, <имя поля> <тип данных>...]...);

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4
             
             DECLARE TYPE <имя типа Record> 
               ( <имя поля> <тип данных> 

                 [, <имя поля> <тип данных> ... ]);


..     
    Oбъявление типа SUBTYPE
    ^^^^^^^^^^^^^^^^^^^^^^^^

    В настоящий момент не конвертируется.

    .. code-block::
        :redlines: 1, 2, 3, 4, 5
        
        SUBTYPE <имя подтипа> IS <базовый тип данных> 
        [ <точность> [,<масштаб> ] 
        | RANGE <нижняя граница>..<верхняя граница>
        | CHARACTER SET <набор символов> ]
        [ NOT NULL ];


Объявление курсоров
^^^^^^^^^^^^^^^^^^^^^^

          
.. code-block::
    :greenlines: 1, 2, 3, 4
    :caption: Oracle
    
    CURSOR <имя курсора>
    [( <имя параметра> [IN] <тип данных> [ { := | DEFAULT } <выражение> ] 
    [, <имя параметра> [IN] <тип данных> [ { := | DEFAULT } <выражение>]]... )]
    RETURN <rowtype> ;


Создание курсоров
^^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,8
             :redlines: 2,3,4,5,6,7
              
             CURSOR <имя курсора>
             [(<имя параметра> [IN] <тип данных> 
               [ { := | DEFAULT } <выражение> ] 
               [, <имя параметра> [IN] <тип данных> 
               [ { := | DEFAULT } <выражение>]]... 
             )]
             [RETURN <rowtype>] 
             IS <SELECT-запрос> ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,8

             DECLARE [VARIABLE] <имя курсора> CURSOR FOR 






             (<SELECT-запрос>);


Объявление переменных
^^^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  2,3
    :greenlines: 1,4,5,6,7
    :caption: Oracle

    { <объявление переменных типа коллекций>
    | <объявление констант>
    | <объявление переменной типа REF CURSOR>
    | <объявление исключений>
    | <объявление переменной типа RECORD>
    | <объявление скалярной переменной>
    }


Объявление переменных типа коллекций
""""""""""""""""""""""""""""""""""""""

.. code-block::
    :redlines:  2,3,4,5,6,7
    :greenlines: 1
    :caption: Oracle
        
    <имя переменной> { <имя типа ассоц.массива> 
                       [:=<выражение> | <вызов функции> | <имя переменной коллекции>]
                     | <имя типа Varray> 
                       [:= {<имя типа Varray>([<список значений>]) | <имя переменной коллекции> }]
                     | <имя типа вложенных таблиц> 
                       [:= {<имя вложенных таблиц>([<список значений>])|<имя переменной коллекции>}]
                     | <имя переменной коллекции>%TYPE } ;    


Объявление констант
"""""""""""""""""""""
        
.. code-block::
    :redlines: 1
    
    <имя константы> CONSTANT <тип данных> [NOT NULL] { := | DEFAULT } <выражение> ;


Объявление исключений
""""""""""""""""""""""

См. :numref:`подраздел %s <sub:declare_exception>`.



Объявление переменной типа RECORD
"""""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 4
             :greenlines: 1,2,3,5,6,7
              
             <имя переменной> 
                    { <имя типа RECORD> 
                    | <имя курсора>%ROWTYPE 
                    | <имя переменной CURSOR REF>%ROWTYPE 
                    | <имя таблицы>%ROWTYPE 
                    | <имя представления>%ROWTYPE 
                    | <имя переменной типа RECORD>%TYPE };


        - :ess:`Rdb`    
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7

             DECLARE [VARIABLE] <имя переменной> 
                   { <имя типа RECORD> 
                   | TYPE OF TABLE  <имя курсора>

                   | TYPE OF TABLE <имя таблицы> 
                   | TYPE OF TABLE <имя представления>
                   | <имя типа RECORD> };


Объявление скалярной переменной
""""""""""""""""""""""""""""""""

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1, 2, 3, 4
              
                                                   .
             <имя переменной> <тип данных> 
             [[NOT NULL] 
             {:= | DEFAULT} <выражение> ] ;

        - :ess:`Rdb`    
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4

             DECLARE [VARIABLE] 
             <имя переменной> <тип данных>
             [NOT NULL] 
             [{ = | DEFAULT } <значение по умолчанию>] ;


Объявление процедуры
^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  2,3
    :greenlines: 1,4
    :caption: Oracle
        
    PROCEDURE <процедура> [(<IN|OUT параметр>[,<IN|OUT параметр>])] 
    [ ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]...)
    | DEFAULT COLLATION <опция сортировки>
    | AUTHID { CURRENT_USER | DEFINER }]... ;


Объявление функции 
^^^^^^^^^^^^^^^^^^^^^^^

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


Реализация процедуры
^^^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines:  2,3,5
    :greenlines: 1,4,6,7,8,9,10,11
    :caption: Oracle

    PROCEDURE <процедура> [(<IN|OUT параметр>[,<IN|OUT параметр>])] 
    [ ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]...)
    | DEFAULT COLLATION <опция сортировки>
    | AUTHID { CURRENT_USER | DEFINER }]... 
    { { IS | AS } <внешний модуль>
    | { IS | AS } [ <объявление_1>;... [<объявление_2>;]... 
                  | <объявление_2>;... ] 
    BEGIN
        <блок операторов> ...
        [ EXCEPTION <обработка исключений> ]
    END [<имя процедуры>] ; }


Реализация функции
^^^^^^^^^^^^^^^^^^^^^^

.. code-block::
    :redlines: 4,5,6,7
    :greenlines: 1,2,3,8,9,10,11,12,13
    :caption: Oracle
    
    FUNCTION <имя функции> [(<IN|OUT параметр>[,<IN|OUT параметр>])]
    RETURN <тип данных> 
    [ DETERMINISTIC
    | PIPELINED
    | PARALLEL_ENABLE
    | RESULT_CACHE [ RELIES_ON ...]  ]...
    { { IS | AS } <внешний модуль>
    | { IS | AS } [ <объявление_1>;... [<объявление_2>;]... 
                  | <объявление_2>;... ] 
    BEGIN
        <блок операторов> ...
        [ EXCEPTION <обработка исключений> ]
    END [<имя процедуры>] ; }



Оператор IF-THEN-ELSE 
------------------------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5,6,7,8,9,10
             
             IF <условие> 
             THEN <оператор> [ <оператор> ]...
             [ ELSIF <условие> 
               THEN <оператор>[<оператор>]...]

             [ ELSE <оператор> [<оператор>]...] 
             END IF ;
                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5,6,7,8,9,10
             
             IF (<условие>)
             THEN [BEGIN] <оператор>[<оператор>...]
             [IF (<условие>) 
              THEN [BEGIN]<оператор>[<оператор>]...[END]]
             [END]
             [ELSE [BEGIN] <оператор>[<оператор>..][END]];
                                                         .


Оператор WHILE LOOP
---------------------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3
             
             WHILE <выражение>
             LOOP <оператор> [<оператор>...]
             END LOOP [<метка>] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3
             
             WHILE (<условие>) 
             DO [BEGIN] <оператор> [<оператор>...]
             [END] ;


Оператор FOR LOOP
---------------------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5
             
             FOR <имя переменной> 
             IN <нижняя граница> .. <верхняя граница>
             LOOP <оператор> [<оператор>...]

             END LOOP [<метка>] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5
             
             <имя переменной> = <нижняя граница>;
             WHILE (<имя переменной> <= <верхняя граница>) 
             DO BEGIN <оператор> [<оператор>...]
             <имя переменной> = <имя переменной>+1
             END;


.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5
             
             FOR <имя переменной> 
             IN REVERSE <нижн. граница>..<верх. граница>
             LOOP <оператор> [<оператор>...]

             END LOOP [<метка>] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5
             
             <имя переменной> = <верхняя граница>;
             WHILE (<имя переменной> >= <нижняя граница>) 
             DO BEGIN <оператор> [<оператор>...] 
             <имя переменной> = <имя переменной>-1
             END;

Оператор FOR LOOP для курсора
------------------------------


.. code-block::
    :greenlines: 1,2,3,4,5,6
    :caption: Oracle
    
    FOR <имя переменной типа RECORD> 
    IN <имя курсора> 
    [(<параметр курсора>[ [,]<параметр курсора>]...)]
    LOOP 
    <оператор> [<оператор>...] 
    END LOOP [<метка>] ;

        

.. code-block:: 
    :greenlines: 1,2,3,4,5,6,7,8,9
    :caption: Rdb
    
    DECLARE VARIABLE <item> TYPE OF TABLE <имя курсора>;
    ...
    OPEN <имя курсора>;
    FETCH <имя курсора> INTO <item>;
    WHILE ( ROW_COUNT != 0 ) DO BEGIN
    <оператор> [<оператор>...] 
    FETCH <имя курсора> INTO <item>;
    END
    CLOSE <имя курсора>;



Оператор FOR LOOP для оператора SELECT
-----------------------------------------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4
             
             FOR <имя переменной типа RECORD> 
             IN (<SELECT-запрос>)
             LOOP <оператор> [<оператор>...] 
             END LOOP [<метка>] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4
             
             FOR <оператор SELECT>
             INTO [:]<имя переменной типа RECORD>
             DO <оператор> [<оператор>...] 
             ;


Оператор LOOP
---------------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3
             
             LOOP 
               <оператор> [<оператор>...]
             END LOOP [<метка>] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3
             
             WHILE (TRUE)
             DO [BEGIN] <оператор> [<оператор>...]
             [END] ;


Оператор простого CASE
-----------------------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5
             
             CASE <поисковое выражение>
             WHEN <выражение 1> THEN <результат 1> ;
             [WHEN <выражение 2> THEN <результат 2>;]...
             [ELSE <значение по умолчанию>;]
             END CASE [<<метка>>];

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5
             
             CASE <поисковое выражение>
             WHEN <выражение 1> THEN <результат 1>
             [WHEN <выражение 2> THEN <результат 2>]...
             [ELSE <значение по умолчанию>]
             END;


Оператор поискового CASE
--------------------------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2,3,4,5
             
             CASE
             WHEN <лог.выражение_1> THEN <результат_1>;
             [WHEN <лог.выражение_2> THEN <результат_2>;]
             [ELSE <выражение по умолчанию>;]
             END CASE [<<метка>>] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3,4,5

             CASE
             WHEN <лог.выражение_1> THEN <результат_1>
             [WHEN <лог.выражение_2> THEN <результат_2>]..
             [ELSE <выражение по умолчанию>]
             END


Операторы перехода
-------------------





Оператор EXIT
^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1
             :redlines: 2
             
             EXIT [<метка>] 
             [WHEN <булево выражение>] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             EXIT;
                                                  .




Оператор CONTINUE
^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1
             :redlines: 2
             
             CONTINUE [<метка>] 
             [WHEN <булево выражение>] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             CONTINUE [<метка>];
                                                   .



Вызов процедуры
-------------------




Операция присваивания
-----------------------

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1
             
             <имя переменной> := <выражение>;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
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

                  
.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1,2
             :redlines: 3
             
             EXECUTE IMMEDIATE '<оператор>'
             [INTO { <имя перем-ой> [, <имя перем-ой>...]
                   | <перемення типа RECORD>}];

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2
             :redlines: 3
             
             EXECUTE STATEMENT '<оператор>'
             [INTO {[:]<имя перем-ой> [,[:]<имя перем-ой>]
                   | <перемення типа RECORD> } ]


Оператор Pragma AUTONOMOUS_TRANSACTION
----------------------------------------    


.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 1
             
             PRAGMA AUTONOMOUS_TRANSACTION ;

                                                       .

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3
             
             IN AUTONOMOUS TRANSACTION DO 
             BEGIN <блок psql операторов> 
             END





Работа с курсорами
------------------------

OPEN
^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 2,3
             :greenlines: 1
             
             OPEN <имя курсора> [(<список параметров>)] ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             OPEN <имя курсора> ;


CLOSE
^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 2,3
             :greenlines: 1
             
             CLOSE { <имя курсора> 
                   | <имя переменной типа REF CURSOR> 
                   | :<host_cursor_variable> } ;

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             CLOSE <имя курсора>;

                                                        .



FETCH
^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :redlines: 2,3,6,7
             :greenlines: 1,4,5,8
             
             FETCH { <курсор>
                   | <переменная курсора>
                   | :<host_cursor_variable> }
             { INTO { <переменная> [,<переменная>...]
                    | <переменная типа RECORD>} 
             | BULK COLLECT INTO ... 
               [LIMIT <числовое выражение>] 
             };

                  
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,4,5
             
             FETCH <курсор>


             [INTO { [:]<переменная>[,[:]<переменная>...]
                   | <переменная типа RECORD>}];


                                                        .
             


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



