.. _sec:psqlstat:

Преобразование операторов процедурного языка PL/SQL
===================================================

Программа на PL/SQL состоит из блоков (анонимных или поименованных). 
Блок может содержать вложенные блоки, называемые иногда подблоками.
Язык PL/SQL позволяет определять следующие типы именованных блоков:

- процедуры;
- функции;
- объекты;
- пакеты.

Далее рассмотрим синтаксис блоков и их преобразование, а затем перейдём к элементам языка PL/SQL (операторам выбора, операторам цикла и др.)


.. _subsec:procedure:

Хранимые процедуры (``Procedure``)
------------------------------------

``CREATE PROCEDURE``
^^^^^^^^^^^^^^^^^^^^

Рассмотрим синтаксис создания процедуры в СУБД Oracle [1]_:

.. color-block::
    :caption: Oracle
    
    :green:`CREATE [OR REPLACE]` :red:`[EDITIONABLE|NONEDITIONABLE]` :green:`PROCEDURE` :red:`[<схема>.]` :green:`<имя процедуры>`
       :green:`[ ( <IN|OUT параметр> [, <IN|OUT параметр>]... ) ]` 
       :red:`[ SHARING = { METADATA | NONE } ]`
       :green:`[ AUTHID { CURRENT_USER | DEFINER }]`
       :red:`[ ACCESSIBLE BY ( <средство доступа> [, <средство доступа> ]... ) ]`
       :red:`[ DEFAULT COLLATION <опция сортировки> ]`
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

- При конвертации удаляются ключевые слова ``EDITIONABLE, NONEDITIONABLE``.
- Удаляется конструкция ``SHARING``.
- Удаляется конструкция ``ACCESSIBLE BY``.
- Удаляется предложение ``DEFAULT COLLATION``.
- Конструкция ``{ IS | AS } <внешний модуль>`` комментируется.

  На данный момент конвертер не способен преобразовывать хранимые процедуры, находящиеся во внешнем модуле. 
  Тем не менее, РБД поддерживает использование внешних хранимых процедур. В таком случае вместо тела процедуры 
  указывается её местоположение во внешнем модуле с помощью конструкции ``EXTERNAL NAME``.

- Имя процедуры после ключевого слова ``END`` комментируется.

Далее рассмотрим только те конструкции оператора ``CREATE PROCEDURE``, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.

Преобразование ``CREATE PROCEDURE`` без OUT-параметров
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Сравнение операторов создания процедур без параметров или только с IN-параметрами:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9
             
             CREATE [ OR REPLACE ] 
             PROCEDURE <имя процедуры>
              [(<IN-параметр> [,<IN-параметр>...])] 
             [AUTHID { CURRENT_USER | DEFINER }]
             {IS|AS} 
                [ <блок объявлений> ] 
             BEGIN 
                <блок операторов> 
             END;                  
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9
             
             CREATE [ OR ALTER ] 
             PROCEDURE <имя процедуры>
              [(<IN-параметр> [,<IN-параметр>...])]
             [SQL SECURITY {DEFINER | INVOKER}]
             AS
                [<блок объявлений>]
             BEGIN
                <блок операторов>
             END;

При конвертации оператора ``CREATE PROCEDURE`` без OUT-параметров выполняются следующие задачи:  

1. *Замена ключевого слова* ``REPLACE``

   Данное ключевое слово заменяется на равнозначное ему ``ALTER``.

2. *Преобразование предложения* ``AUTHID``

   ??? 
  
3. *Замена ключевого слова* ``IS`` 
   
   Данное ключевое слово заменяется на равнозначное ему ``AS``.
 
4. *Преобразование IN-параметров* 

   В Oracle входные параметры могут прописываться с модификатором ``IN`` (необязательным). 
   При конвертации модификатор ``IN`` удаляется.

   Сравним синтаксис задания IN-параметров [2]_:

   .. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. color-block::
             
             :green:`<IN-параметр> :=` 
                        :green:`<имя>` :red:`[IN]` :green:`<тип данных>` 
                             :green:`[{:=|DEFAULT} <значение>]`                  
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3
             
             <IN-параметр> := 
                       <имя> <тип данных> 
                            [{=|DEFAULT} <значение>]     

   IN-параметрам можно устанавливать значения по умолчанию. Как видно, различия заключаются лишь в операторе присваивания (``:=``). 
   
   .. note::

      В РБД параметры, для которых установлены значения по умолчанию, должны располагаться в самом конце списка, 
      тогда как в Oracle таких ограничений нет.

5. Преобразование конструкции с блоком объявлений описано в подразделе :ref:`subsec:decl`.


.. code-block:: sql
    :caption: Oracle
  
    CREATE PROCEDURE Set_Multi_Installation_Mode (multi_delivery_mode_ IN BOOLEAN )
    IS
      text1_ Varchar2(100);
    BEGIN
      IF multi_delivery_mode_ THEN text1_ := 'multi';
      ELSE text1_ := NULL;
      END IF;
      INSERT INTO INSTALL_TEM_SYS_TAB (text_col) VALUES (text1_);
    END Set_Multi_Installation_Mode;


.. code-block:: sql
    :caption: to Rdb
  
    CREATE PROCEDURE Set_Multi_Installation_Mode (multi_delivery_mode_  BOOLEAN )
    AS
       DECLARE text1_ VARCHAR(100);
    BEGIN
       IF (:multi_delivery_mode_) THEN text1_ = 'multi';
       ELSE text1_ = NULL;
       INSERT INTO INSTALL_TEM_SYS_TAB (text_col) VALUES (:text1_);
    END /*Set_Multi_Installation_Mode*/;



Преобразование ``CREATE PROCEDURE`` с OUT-параметрами
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Сравнение операторов создания процедур с хотя бы одним OUT-параметром:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 13
             
             CREATE [ OR REPLACE ] 
             PROCEDURE <имя процедуры>
              (<OUT-параметр> [,<IN|OUT-параметр>...])

             [AUTHID { CURRENT_USER | DEFINER }]
             {IS|AS} 
                [ <блок объявлений> ] 
             BEGIN 
                <блок операторов> 



             END;              
              	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
             
             CREATE [OR ALTER] 
             PROCEDURE <имя процедуры> 
               (<OUT-параметр> [,<IN|OUT-параметр>...])
             RETURNS (<OUT-пар.>_OUT [,...]);
             [SQL SECURITY {DEFINER | INVOKER}]
             AS 
               [<блок объявлений>]
             BEGIN
               <блок операторов>
               <OUT-параметр>_OUT = <OUT-параметр>; 
               [<OUT-параметр2>_OUT = <OUT-параметр2>;...]
               SUSPEND;
             END ;

При конвертации оператора ``CREATE PROCEDURE`` с OUT-параметрами выполняются следующие задачи:  

1. *Преобразование процедуры в селективную процедуру* 

   Если в процедуре присутствует хотя бы один OUT-параметр, она преобразуется в селективную процедуру в РБД. 
   Для этого выполняются следующие действия:
   
   .. unindented_list::

      - добавляется конструкция ``RETURNS (...)``, в которую дублируется список всех OUT-параметров с добавлением суффикса ``"_OUT"``.
      - перед завершением процедуры осуществляется присваивание значений выходным параметрам, после чего выполняется команда ``SUSPEND``.

2. *Преобразование входных параметров*

   В процедурах Oracle все параметры являются входными, однако они подразделяются на IN и OUT. 

   Модификаторы ``IN, OUT`` и ``IN OUT`` не используются и удаляются. Следует отметить, что в РБД отсутствует аналог модификатора ``NOCOPY``, 
   который также подлежит исключению.

3. *Замена ключевого слова* ``REPLACE``

   Данное ключевое слово заменяется на равнозначное ему ``ALTER`` 

4. *Преобразование предложения* ``AUTHID``

   ???

5. *Замена ключевого слова* ``IS`` 
   
   Данное ключевое слово заменяется на равнозначное ему ``AS``.
      
6. Преобразование конструкции с блоком объявлений описано в подразделе :ref:`subsec:decl`.


.. code-block:: sql
  :caption: Oracle

  CREATE PROCEDURE Base (NUM IN OUT NUMBER)
  IS
  BEGIN
    SELECT CUST_REP INTO NUM FROM customers
    WHERE customers.CUST_NUM = 5;
  END Base;


.. code-block:: sql
  :caption: to Rdb

  CREATE PROCEDURE Base (NUM NUMERIC(34, 8))
  RETURNS (NUM_OUT NUMERIC(34, 8))
  AS
  BEGIN
    SELECT CUST_REP FROM customers
    WHERE customers.CUST_NUM = 5
    INTO :NUM;
    IF (ROW_COUNT = 0) THEN
        EXCEPTION NO_DATA_FOUND;
    NUM_OUT = NUM;
    SUSPEND;
  END /*Base*/ ;






``ALTER PROCEDURE``
^^^^^^^^^^^^^^^^^^^^

Оператор ``ALTER PROCEDURE`` не конвертируется.

.. code-block::
    :redlines:  1, 2, 3, 4
    :caption: Oracle
    
    ALTER PROCEDURE [<схема>.] <имя процедуры>
    { COMPILE [ DEBUG ] [ <параметры компиляции> ... ] [ REUSE SETTINGS ] 
    | { EDITIONABLE | NONEDITIONABLE } 
    }


``DROP PROCEDURE``
^^^^^^^^^^^^^^^^^^^^

Сравним операторы удаления процедуры:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. color-block::
             
             :green:`DROP PROCEDURE` :red:`[<схема>.]` :green:`<имя процедуры> ;`


        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP PROCEDURE <имя процедуры>;

За исключением имени схемы операторы аналогичны.

.. _subsec:function:

Хранимые функции (``Function``)
----------------------------------

``CREATE FUNCTION``
^^^^^^^^^^^^^^^^^^^^

Рассмотрим синтаксис создания функции в СУБД Oracle [3]_:

.. color-block::
    :caption: Oracle
    
    :green:`CREATE [OR REPLACE]` :red:`[EDITIONABLE|NONEDITIONABLE]` :green:`FUNCTION` :red:`[<схема>.]` :green:`<имя функции>`
       :green:`[ ( <IN|OUT параметр> [, <IN|OUT параметр>]... ) ]`
       :green:`RETURN <тип возвращаемого значения>`
       :red:`[ SHARING = { METADATA | NONE } ]`
       :green:`[ AUTHID { CURRENT_USER | DEFINER }]`
       :red:`[ ACCESSIBLE BY ( <средство доступа> [, <средство доступа> ]... ) ]`
       :red:`[ DEFAULT COLLATION <опция сортировки> ]`   
       :green:`[ DETERMINISTIC ]`
       :red:`[ PARALLEL_ENABLE ... ]`
       :red:`[ RESULT_CACHE ... ]`
       :red:`[ AGGREGATE USING ... ]`
       :red:`[ PIPELINED ... ]`
       :red:`[ SQL_MACRO ]`
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

- При конвертации удаляются ключевые слова ``EDITIONABLE, NONEDITIONABLE``.
- Удаляется конструкция ``SHARING``.
- Удаляется конструкция ``ACCESSIBLE BY``.
- Удаляется предложение ``DEFAULT COLLATION``.
- Удаляется предложение ``PARALLEL_ENABLE``.
- Удаляется предложение ``RESULT_CACHE``.
- Удаляется предложение ``AGGREGATE USING``.
- Удаляется предложение ``PIPELINED``.
- Удаляется предложение ``SQL_MACRO``.
- Конструкция ``{ IS | AS } <внешний модуль>`` комментируется.

  На данный момент конвертер не способен преобразовывать хранимые функции, находящиеся во внешнем модуле. 
  Тем не менее, РБД поддерживает использование внешних хранимых функций. В таком случае вместо тела функции 
  указывается её местоположение во внешнем модуле с помощью конструкции ``EXTERNAL NAME``.

- Имя функции после ключевого слова ``END`` комментируется.

Далее рассмотрим только те конструкции оператора ``CREATE FUNCTION``, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.


Преобразование ``CREATE FUNCTION`` без OUT-параметров
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Сравнение синтаксиса операторов создания функций без параметров или только с IN-параметрами:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
             
             CREATE [ OR REPLACE ] 
             FUNCTION <имя функции>
              [(<IN-параметр> [,<IN-параметр>...])] 
             RETURN <тип возвращаемого значения> 
             [AUTHID { CURRENT_USER | DEFINER }]
             [DETERMINISTIC]
             {IS|AS} 
                 [ <блок объявлений> ] 
             BEGIN 
                 <блок операторов> 
             END;
                                                             
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
             
             CREATE [ OR ALTER ] 
             FUNCTION <имя хранимой функции>
              [(<IN-параметр> [,<IN-параметр>...])]
             RETURNS <тип возвращаемого значения> 
             [DETERMINISTIC]
             [SQL SECURITY {DEFINER | INVOKER}]
             AS
                 [<блок объявлений> ]
             BEGIN
                 <блок операторов>
             END ;

При конвертации оператора ``CREATE FUNCTION`` без OUT-параметров выполняются следующие задачи:  

1. *Замена ключевого слова* ``REPLACE``

   Данное ключевое слово заменяется на равнозначное ему ``ALTER``.

2. *Замена ключевого слова* ``RETURN``

   Данное ключевое слово заменяется на равнозначное ему ``RETURNS``.

3. *Преобразование предложения* ``AUTHID``

   ??? 
  
4. *Замена ключевого слова* ``IS`` 
   
   Данное ключевое слово заменяется на равнозначное ему ``AS``.
 
5. *Преобразование IN-параметров*

   В Oracle входные параметры могут прописываться с модификатором ``IN`` (необязательным). 
   При конвертации модификатор ``IN`` удаляется.

   Сравним синтаксис задания IN-параметров [4]_:

   .. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. color-block::
             
             :green:`<IN-параметр> :=` 
                        :green:`<имя>` :red:`[IN]` :green:`<тип данных>` 
                             :green:`[{:=|DEFAULT} <значение>]`                  
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3
             
             <IN-параметр> := 
                       <имя> <тип данных> 
                            [{=|DEFAULT} <значение>]     

   IN-параметрам можно устанавливать значения по умолчанию. Как видно, различия заключаются лишь в операторе присваивания (``:=``). 
   В РБД параметры, для которых установлены значения по умолчанию, должны располагаться в самом конце списка, 
   тогда как в Oracle таких ограничений нет.

6. Преобразование конструкции с блоком объявлений описано в подразделе :ref:`subsec:decl`.


.. code-block:: sql
   :caption: Oracle

   CREATE FUNCTION IN_FUNCTION (NUM IN NUMBER) 
   RETURN BOOLEAN
   IS
   BEGIN 
      SELECT CUST_REP INTO NUM FROM customers
      WHERE customers.CUST_NUM = NUM;
      RETURN TRUE;
   END OUT_FUNCTION;

.. code-block:: sql
   :caption: to Rdb

   CREATE FUNCTION IN_FUNCTION (NUM IN NUMBER) 
   RETURNS BOOLEAN
   AS
   BEGIN 
      SELECT CUST_REP FROM customers
      WHERE customers.CUST_NUM = NUM
      INTO NUM;
      IF (ROW_COUNT = 0) THEN 
         EXCEPTION NO_DATA_FOUND;
      RETURN TRUE;
   END /*OUT_FUNCTION*/;


Преобразование ``CREATE FUNCTION`` с OUT-параметрами
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Сравнение операторов создания функций с хотя бы одним OUT-параметром:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17
             :redlines: 7
             
             CREATE [OR REPLACE] 
             FUNCTION <имя функции>
              (<OUT-параметр> [,<IN|OUT параметр>...])
             RETURN <тип возвращаемого значения> 

             [AUTHID { CURRENT_USER | DEFINER }]
             [DETERMINISTIC]
             {IS|AS} 
                 [ <блок объявлений> ] 
             BEGIN 
                 <блок операторов> ... 
                 RETURN <результат>;




             END;           
  	                                                        
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17
             
             CREATE [OR ALTER] 
             PROCEDURE <имя функции> 
               (<OUT-параметр> [,<IN|OUT параметр>...])
             RETURNS (RET_VAL <тип возвр.знач.>,
                      <OUT-параметр>_OUT [,...])
             [SQL SECURITY {DEFINER | INVOKER}]

             AS 
               [<блок объявлений> ]
             BEGIN
               <блок операторов>
               RET_VAL = <результат>;
               <OUT-параметр>_OUT = <OUT-параметр>; 
               [<OUT-параметр2>_OUT = <OUT-параметр2>;...]
               SUSPEND;
               EXIT;
             END ;

При конвертации оператора ``CREATE FUNCTION`` с OUT параметрами выполняются следующие задачи:  

1. *Преобразование функции в селективную процедуру*
   
   Если в функции присутствует хотя бы один OUT-параметр, она преобразуется в селективную процедуру в РБД. 
   Для этого выполняются следующие действия:
   
   .. unindented_list::
      
      - ключевое слово ``FUNCTION`` заменяется на ключевое слово ``PROCEDURE``.
      - предложение ``RETURN <тип возвращаемого значения>`` заменяется конструкцией
        ``RETURNS`` со списком выходных параметров:

        - добавляется параметр ``RET_VAL``, который принимает тип возвращаемого значения;
        - дублируется список всех OUT-параметров с добавлением суффикса ``"_OUT"``.

      - перед завершением процедуры осуществляется присваивание значений переменной ``RET_VAL`` и остальным выходным параметрам. 
        После чего выполняется команда ``SUSPEND; EXIT;``.

2. *Преобразование входных параметров*

   В процедурах Oracle все параметры являются входными, однако они подразделяются на IN и OUT. 

   Модификаторы ``IN, OUT`` и ``IN OUT`` не используются и удаляются. Следует отметить, что в РБД отсутствует аналог модификатора ``NOCOPY``, 
   который также подлежит исключению.

3. *Замена ключевого слова* ``REPLACE``

   Данное ключевое слово заменяется на равнозначное ему ``ALTER`` 

4. *Преобразование предложения* ``AUTHID``

   ???
5. *Удаление ключевого слова* ``DETERMINISTIC``
   
   В РБД процедуры не могут быть детерминированными.

6. *Замена ключевого слова* ``IS`` 
   
   Данное ключевое слово заменяется на равнозначное ему ``AS``.
  
7. Преобразование конструкции с блоком объявлений описано в подразделе :ref:`subsec:decl`.


.. code-block:: sql
  :caption: Oracle

  CREATE FUNCTION TEST_FUNCTION (NUM2 IN OUT NUMBER) 
  RETURN BOOLEAN
  IS
  BEGIN
    OUT_FUNCTION(NUM2);
    RETURN TRUE;
  END TEST_FUNCTION;


.. code-block:: sql
  :caption: to Rdb

  CREATE PROCEDURE TEST_FUNCTION (NUM2 NUMERIC(18, 4))
  RETURNS (RET_VAL BOOLEAN, NUM2_OUT NUMERIC(18, 4))
  AS
    DECLARE OUT_FUNCTION_RET_VAL BOOLEAN;
  BEGIN
    SELECT RET_VAL, NUM_OUT FROM OUT_FUNCTION(:NUM2) 
    INTO OUT_FUNCTION_RET_VAL, NUM2;

    RET_VAL = TRUE;
    NUM2_OUT = NUM2;
    SUSPEND;
    EXIT;
  END /*TEST_FUNCTION*/ ;
        

``ALTER FUNCTION``
^^^^^^^^^^^^^^^^^^^^

Оператор ``ALTER FUNCTION`` не конвертируется.

.. code-block::
    :redlines:  1, 2, 3, 4
    :caption: Oracle
    
    ALTER FUNCTION [<схема>.] <имя функции>
    { COMPILE [ DEBUG ] [ <параметры компиляции> ... ] [ REUSE SETTINGS ] 
    | { EDITIONABLE | NONEDITIONABLE } 
    }


``DROP FUNCTION``
^^^^^^^^^^^^^^^^^^^^

Сравним операторы удаления функции:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. color-block::
             
             :green:`DROP FUNCTION` :red:`[<схема>.]` :green:`<имя функции> ;`

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP FUNCTION <имя функции>;

За исключением имени схемы операторы аналогичны.

.. _subsec:trigger:

Триггеры (``Trigger``)
--------------------------

``CREATE TRIGGER``
^^^^^^^^^^^^^^^^^^^^

Рассмотрим синтаксис создания триггеров в СУБД Oracle [5]_:

.. color-block::
    :caption: Oracle
    
    :green:`CREATE [OR REPLACE]` :red:`[EDITIONABLE|NONEDITIONABLE]` :green:`TRIGGER` :red:`[<схема>.]`:green:`<имя триггера>`
    :red:`[ SHARING = { METADATA | NONE } ]` 
    :red:`[ DEFAULT COLLATION <опция сортировки> ]`
    :green:`{ <dml триггеры>`
    :red:`| <триггеры для замещения dml операций для необновляемых представлений>`
    :red:`| <составной dml триггер>`
    :red:`| <системный триггер>` :green:`}`

    :green:`<dml триггеры> ::= { BEFORE | AFTER } <DML событие> [OR <DML событие>...]`
                          :green:`ON` :red:`[<схема>.]` :green:`{<таблица>|<представление>}`
                       :red:`[ REFERENCING { OLD [AS] <old> | NEW [AS] <new> | PARENT [AS] <parent>}... ]`
                       :red:`[ FOR EACH ROW ]`
                       :red:`[ { FORWARD | REVERSE } CROSSEDITION ]`
                       :red:`[ { FOLLOWS | PRECEDES } [<схема>.] <имя триггера> [,...]]`
                       :green:`[ ENABLE | DISABLE ]`
                       :red:`[ WHEN ( <условие> )]`
                       :green:`{`
                         :red:`[ << label >> [ << label >> ]...]`
                         :green:`[ DECLARE <блок объявлений> ]`
                         :green:`BEGIN`
                            :green:`<блок операторов> ...` 
                         :green:`END` :red:`[ <имя триггера> ]` :green:`;`
                       :red:`| CALL <routine_clause>` 
                       :green:`}`                 

**Замечания**

- При конвертации удаляются ключевые слова ``EDITIONABLE, NONEDITIONABLE``.
- Удаляется конструкция ``SHARING``.
- Удаляется предложение ``DEFAULT COLLATION``.
- Триггеры для замещения DML операций необновляемых представлений не поддерживаются РБД. Комментируются.
- Составные DML триггеры не поддерживаются РБД. Комментируются.
- Системные триггеры не поддерживаются РБД. Комментируются.
- Все неподдерживаемые конструкции DML триггеров комментируются.


Преобразование ``CREATE TRIGGER`` 
""""""""""""""""""""""""""""""""""""

Далее рассмотрим только те конструкции оператора ``CREATE TRIGGER``, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.

Сравнение синтаксиса операторов создания DML триггеров:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block::
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
             
             CREATE [OR REPLACE] TRIGGER <имя триггера>

             { BEFORE | AFTER } 
                  <DML событие> [OR <DML событие> ...]
                  ON {<таблица>|<представление>}
             [ ENABLE | DISABLE ] 
             [ DECLARE <блок объявлений> ] 
             BEGIN 
                <блок операторов>
             END;


        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
             
             CREATE [OR ALTER] TRIGGER <имя триггера>
             [ACTIVE | INACTIVE]
             { BEFORE | AFTER } 
                 <DML событие> [OR <DML событие> ...]
                 ON {<таблица>|<представление>}

             AS [<блок объявлений>;]
             BEGIN
               <блок операторов>
             END;

При конвертации оператора ``CREATE TRIGGER`` выполняются следующие задачи:  

1. *Замена ключевого слова* ``REPLACE``

   Данное ключевое слово заменяется на равнозначное ему ``ALTER`` 

2. *Преобразование атрибутов* ``ENABLE | DISABLE``

   ???

3. *Преобразование DML-событий*

   .. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. color-block::
             
             :green:`<DML событие> ::=` 
                :green:`{ DELETE | INSERT`
                :green:`| UPDATE` :red:`[OF <столбец>[,<столбец>]...]`:green:`}`

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1,2,3
             
             <DML событие> ::= 
                          { DELETE | INSERT 
                          | UPDATE }

4. *Добавление ключевого слова* ``AS``

   В Oracle, чтобы объявить переменные, необходимые для работы триггера, добавляется конструкция ``DECLARE``.
   В РБД переменные объявляются после обязательного ключевого слова ``AS``.
   Таким образом, ключевое слово ``DECLARE`` (если оно присутствует) при конвертации заменяется на ключевое слово ``AS``. 
   Если предложение ``DECLARE`` отсутствует, то перед основным блоком ``BEGIN-END`` добавляется ключевое слово ``AS``.

5. Преобразование конструкции с блоком объявлений описано в подразделе :ref:`subsec:decl`.


``ALTER TRIGGER``
^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. color-block::
              
              :green:`ALTER TRIGGER` :red:`[<схема>.]` :green:`<имя триггера>`
              :green:`{` :red:`COMPILE [DEBUG] [<параметры компиляции>...]`
                :red:`[REUSE SETTINGS]`
              :green:`| { ENABLE | DISABLE }`
              :red:`| RENAME TO <новое имя>`
              :red:`| { EDITIONABLE | NONEDITIONABLE }`
              :green:`} ;`

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 4
             
             ALTER TRIGGER <имя триггера>
             
             
             [ACTIVE | INACTIVE];


             :addline:


``DROP TRIGGER``
^^^^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. color-block::
              
              :green:`DROP TRIGGER` :red:`[<схема>.]` :green:`<имя триггера>;`

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP TRIGGER <имя триггера>;


.. _subsec:package:

Заголовки пакетов (``Package``)
---------------------------------

``CREATE PACKAGE``
^^^^^^^^^^^^^^^^^^^^

Рассмотрим синтаксис создания заголовка пакетов в СУБД Oracle [6]_:

.. color-block::
    :caption: Oracle
    
    :green:`CREATE [OR REPLACE]` :red:`[EDITIONABLE|NONEDITIONABLE]` :green:`PACKAGE` :red:`[<схема>.]`:green:`<имя пакета>` 
    :red:`[ SHARING = { METADATA | NONE } ]` 
    :green:`[` :red:`{ DEFAULT COLLATION <опция сортировки>`
      :red:`| AUTHID { CURRENT_USER | DEFINER }` 
      :red:`| ACCESSIBLE BY ( <средство доступа> [, <средство доступа> ]... )}...` :green:`]`
    :green:`{ IS | AS } <список объявлений>`
    :green:`END` :red:`[<имя пакета>]` :green:`;`

    :green:`<список объявлений> ::= { <объявление пак. функции> | <объявление пак. процедуры>`
                            :red:`| <объявление типа> | <объявление курсора>`
                            :red:`| <объявление переменных и констант> }...`

    :green:`<объявление пак.функции> ::= FUNCTION <имя функции> [(<IN|OUT параметр>[,<IN|OUT параметр>])]`
                                 :green:`RETURN <тип данных>`
                                 :green:`[` :red:`ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]... )` 
                                 :green:`| DETERMINISTIC`
                                 :red:`| PIPELINED ...` 
                                 :red:`| PARALLEL_ENABLE ...`  
                                 :red:`| RESULT_CACHE ...` :green:`] ;`

    :green:`<объявление пак.процедуры> ::= PROCEDURE <процедура> [(<IN|OUT параметр>[,<IN|OUT параметр>])]`
                                   :red:`[ACCESSIBLE BY (<средство доступа> [, <средство доступа> ]...)]` :green:`;`


**Замечания**

- При конвертации удаляются ключевые слова ``EDITIONABLE, NONEDITIONABLE``.
- Удаляется конструкция ``SHARING``.
- Удаляется предложение ``DEFAULT COLLATION``.
- Удаляется конструкция ``ACCESSIBLE BY``.
- Имя пакета после ключевого слова ``END`` комментируется.
- В РБД в заголовках пакетов можно объявлять только функции и процедуры. 
  Объявлять переменные и курсоры возможно только внутри самих пакетных процедур и функций.
  

Преобразование ``CREATE PACKAGE``
""""""""""""""""""""""""""""""""""""

Далее рассмотрим только те конструкции оператора ``CREATE PACKAGE``, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.

Сравнение синтаксиса операторов создания заголовков пакетов:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5, 6, 7
              
              CREATE [OR REPLACE] PACKAGE <имя пакета>
              [AUTHID { CURRENT_USER | DEFINER }]
              { IS | AS } 
                 { <объявление процедуры>; 
                 | <объявление функции>; ...}
              END ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7
             
             CREATE [OR ALTER] PACKAGE <имя пакета>
             [SQL SECURITY {DEFINER | INVOKER}]
             AS BEGIN
                { <объявление процедуры>;
                | <объявление функции>;...}
             END ; 

При конвертации оператора ``CREATE PACKAGE`` выполняются следующие задачи:  

1. *Замена ключевого слова* ``REPLACE``

   Данное ключевое слово заменяется на равнозначное ему ``ALTER``.

2. *Преобразование предложения* ``AUTHID``

   ??? 
  
3. *Замена ключевых слов* ``IS/AS`` 
   
   Данные ключевые слова заменяется на ``AS BEGIN``.

4. Преобразование конструкций с объявлением процедур и функций описаны в разделах:   
   :ref:`subsec:proc_decl`, :ref:`subsec:func_decl`.
  


``ALTER PACKAGE``
^^^^^^^^^^^^^^^^^^

Оператор ``ALTER PACKAGE`` не конвертируется.

.. code-block::
    :redlines:  1, 2, 3
    :caption: Oracle

    ALTER PACKAGE [<схема>.] <имя пакета>
    { COMPILE [ DEBUG ] [ <параметры компиляции> ... ] [ REUSE SETTINGS ] 
    | { EDITIONABLE | NONEDITIONABLE } } ;




``DROP PACKAGE``
^^^^^^^^^^^^^^^^^

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. color-block::
              
              :green:`DROP PACKAGE` :red:`[<схема>.]` :green:`<имя пакета>;`

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP PACKAGE <имя пакета>;

За исключением имени схемы операторы аналогичны.


.. _subsec:packagebody:

Тело пакетов (``Package Body``)
--------------------------------

``CREATE PACKAGE BODY``
^^^^^^^^^^^^^^^^^^^^^^^^^

Рассмотрим синтаксис создания тела пакетов в СУБД Oracle [7]_:

.. color-block::
    :caption: Oracle
    
    :green:`CREATE [OR REPLACE]` :red:`[EDITIONABLE|NONEDITIONABLE]` :green:`PACKAGE BODY` :red:`[<схема>.]`:green:`<имя пакета>`
    :red:`SHARING = { METADATA | NONE }`
    :green:`{ IS | AS } {<объявление_1> [<объявление_2>]|<объявление_2>}` 
    :red:`[ BEGIN` 
      :red:`<блок операторов>`
      :red:`[ EXCEPTION <обработка исключений> ]`
    :red:`]`
    :green:`END` :red:`[<имя пакета>]` :green:`;`

    :green:`<объявление_1> ::= {` :red:`<объявление типов>`
                       :red:`| <объявление курсора>`
                       :red:`| <объявление переменных>`
                       :green:`| <объявление функции>`
                       :green:`| <объявление процедуры>}`

    :green:`<объявление_2> ::= { <объявление функции> | <реализация функции>`
                       :green:`| <объявление процедуры> | <реализация процедуры>`
                       :red:`| <объявление курсора> | <создание курсора> }`

**Замечания**

- При конвертации удаляются ключевые слова ``EDITIONABLE, NONEDITIONABLE``.
- Удаляется конструкция ``SHARING``.
- Имя пакета после ключевого слова ``END`` комментируется.
- В РБД в пакетах можно объявлять и реализовывать только функции и процедуры. 
  Объявлять переменные и курсоры возможно только внутри самих пакетных процедур и функций.
- В РБД в пакетах блок ``BEGIN-END`` отсутствует.

 
Преобразование ``CREATE PACKAGE BODY``   
""""""""""""""""""""""""""""""""""""""""""

Далее рассмотрим только те конструкции оператора ``CREATE PACKAGE BODY``, которые преобразуются 
конвертером и поддерживаются Ред Базой Данных.   

Сравнение операторов создания тела пакетов:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
              :greenlines: 1, 2, 3, 4, 5, 6, 7, 8
              
              CREATE [OR REPLACE] 
              PACKAGE BODY <имя пакета>
              { IS | AS }
                 [ <объявление процедуры>;
                 | <объявление функции>;...]
                 { <реализация процедуры>;
                 | <реализация функции>;...}
              END ;

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1, 2, 3, 4, 5, 6, 7, 8
             
             RECREATE
             PACKAGE BODY <имя пакета>
             AS BEGIN
                [ <объявление процедуры>;
                | <объявление функции>;...]
                { <реализация процедуры>;
                | <реализация функции>;...}
             END ;


При конвертации оператора ``CREATE PACKAGE BODY`` выполняются следующие задачи:  

1. *Замена* ``CREATE [OR REPLACE]``

   Данное ключевое слово заменяется на равнозначное ему ``RECREATE`` 

2. *Замена ключевого слова* ``IS`` *или* ``AS`` 
   
   Данные ключевые слова заменяются на ``AS BEGIN``.

3. Преобразование конструкции с блоком объявлений  
   :ref:`subsec:proc_decl`, :ref:`subsec:func_decl`, :ref:`subsec:proc_defin`, :ref:`subsec:func_defin`.




``DROP PACKAGE BODY``
^^^^^^^^^^^^^^^^^^^^^^^^^

Сравним операторы удаления тела пакета:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. color-block::
              
              :green:`DROP PACKAGE BODY` :red:`[<схема>.]` :green:`<имя пакета>;`

        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 1
             
             DROP PACKAGE BODY <имя пакета>;

За исключением имени схемы операторы аналогичны.


Анонимные PL/SQL блоки
------------------------

Сравнение операторов выполнения анонимных PL/SQL блоков:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
          
          .. code-block::
             :greenlines: 2,3,4,5,6
             :redlines: 1
             
             [ << label >> ]... 
             [DECLARE
                <блок объявлений>; ]
             BEGIN
               <блок plsql операторов> ...
             END;
             
        - :ess:`Rdb`
        
          .. code-block:: 
             :greenlines: 2,3,4,5,6
             
             :addline:
             EXECUTE BLOCK AS
               [ <блок объявлений> ]               
             BEGIN
               <блок psql операторов> ...
             END;

При конвертации оператора выполняются следующие задачи:  

1. *Удаление метки* 
   
   ???

2. *Добавление ключевых слов* ``EXECUTE BLOCK AS``

   В РБД анономные блоки начинаются с конструкции ``EXECUTE BLOCK AS``. 

3. *Удаление ключевого слова* ``DECLARE``

   В Oracle, чтобы объявить переменные, необходимые для работы PL/SQL блока, добавляется конструкция ``DECLARE``.
   В РБД переменные объявляются после обязательного ключевого слова ``AS``.
   Таким образом, ключевое слово ``DECLARE`` (если оно присутствует) при конвертации удаляется.

4. Преобразование конструкции с блоком объявлений описано в подразделе :ref:`subsec:decl`.






.. [1]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.

.. [2] 
   Для Ред Базы Данных представлен не полный синтаксис задания входных параметров, а только те конструкции, которые 
   соответствуют синтаксису Oracle и конвертируются в них.

.. [3]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.

.. [4] 
   Для Ред Базы Данных представлен не полный синтаксис задания входных параметров, а только те конструкции, которые 
   соответствуют синтаксису Oracle и конвертируются в них.

.. [5]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.

.. [6]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.

.. [7]
   Конструкции операторов Oracle, которые преобразуются конвертером (с учетом разницы в синтаксисе) обозначены :green:`зеленым` цветом.
   :red:`Красным` цветом обозначены конструкции, которые не поддерживаются Ред Базой Данных или конвертером. Неподдерживаемые конструкции
   удаляются или комментируются.

