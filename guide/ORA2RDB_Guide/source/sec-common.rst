

Преобразование общих конструкций
===================================

.. _sec:datatypes:

Преобразование типов данных
-----------------------------

Преобразования типов данных Oracle в соответствующие им типы данных РБД показаны в :numref:`таблице %s<table:datatypes>`.

.. tabularcolumns:: |>{\ttfamily\arraybackslash}\X{3}{8}|>{\ttfamily\arraybackslash}\X{3}{8}|
.. list-table:: Преобразования типов данных
    :header-rows: 1
    :class: longtable
    :widths: 3, 3
    :name: table:datatypes

    * - Oracle
      - Ред База Данных
    * - VARCHAR2(n)
      - VARCHAR(n)
    * - NVARCHAR2(n)
      - VARCHAR(n)
    * - NUMBER(n,m)
      - NUMERIC(n,m)
    * - NUMBER
      - NUMERIC(34,8)
    * - FLOAT(n)
      - DOUBLE PRECISION
    * - LONG
      - 
    * - DATE
      - 
    * - BINARY_FLOAT
      - FLOAT
    * - BINARY_DOUBLE
      - DOUBLE PRECISION
    * - TIMESTAMP
      - 
    * - TIMESTAMP WITH TIME ZONE
      -
    * - TIMESTAMP WITH LOCAL TIME ZONE
      -
    * - RAW(n)
      - BLOB
    * - LONG RAW
      - 
    * - ROWID
      - BINARY(8)
    * - CHAR(n)
      - 
    * - CHAR
      - 
    * - NCHAR(n)
      - CHAR(n)
    * - NCHAR
      -     
    * - CLOB
      - BLOB SUB_TYPE TEXT
    * - NCLOB
      - 
    * - BLOB
      - 
    

Таким образом, пример преобразования скрипта создания таблицы будет выглядеть так:

.. list-table::
      :class: borderless
      
      * - :ess:`Oracle`
      
          .. code-block:: sql
            
            CREATE TABLE "USER"."ROLEREGISTER" 
            (	"ID" NUMBER(15,0),
                "VERSION" NUMBER(15,0),
                "BUDGET_ID" NUMBER(15,0),
                "DOCUMENTCLASS_ID" NUMBER(15,0),
                "DISPSTATUS_ID" NUMBER(15,0),
                "DOC_NUMBER" VARCHAR2(20),
                "DOC_DATE" DATE,
                "GRANTEDROLE_ID" NUMBER(15,0),
                "GRANTINGUSER_ID" NUMBER(15,0),
                "USER_ID" NUMBER(15,0),
                "GRANTDATE" TIMESTAMP(6),
                "FROMDATE" DATE,
                "DESCRIPTION" CLOB,
                "DOCUMENT_ID" NUMBER(15,0),
                "OPERTYPE_ID" NUMBER(15,0) DEFAULT 0,
                "AMOUNT" NUMBER(15,2) DEFAULT 0,
                "FOREIGN_KEY" VARCHAR2(50),
                "OPERATION" NUMBER(2,0)
            );

        - :ess:`Rdb`
        
          .. code-block:: sql
   
              CREATE TABLE "ROLEREGISTER" 
              (	"ID" NUMERIC(15,0),
                "VERSION" NUMERIC(15,0),
                "BUDGET_ID" NUMERIC(15,0),
                "DOCUMENTCLASS_ID" NUMERIC(15,0),
                "DISPSTATUS_ID" NUMERIC(15,0),
                "DOC_NUMBER" VARCHAR(20),
                "DOC_DATE" DATE,
                "GRANTEDROLE_ID" NUMERIC(15,0),
                "GRANTINGUSER_ID" NUMERIC(15,0),
                "USER_ID" NUMERIC(15,0),
                "GRANTDATE" TIMESTAMP,
                "FROMDATE" DATE,
                "DESCRIPTION" BLOB SUB_TYPE TEXT,
                "DOCUMENT_ID" NUMERIC(15,0),
                "OPERTYPE_ID" NUMERIC(15,0) DEFAULT 0,
                "AMOUNT" NUMERIC(15,2) DEFAULT 0,
                "FOREIGN_KEY" VARCHAR(50),
                "OPERATION" NUMERIC(2,0)
              );




Преобразование схем
---------------------

В примере, приведенном выше, перед именем таблицы указывается имя схемы ``"USER"``, которой принадлежит таблица. 
В одной базе данных Oracle могут размещаться несколько схем. Например, системные таблицы располагаются в одной схеме, 
а пользовательские – в других. Схема – это своего рода контейнер хранимых в БД объектов одного пользователя. 
Обычно при экспорте извлекаются метаданные только тех объектов, владельцем которых является пользователь, под которым 
выполнено подключение. То есть извлекается конкретная схема БД. В полученном скрипте перед именами объектов указывается 
имя этой схемы. 

В РБД понятие схемы не используется, поэтому при преобразовании скрипта её имя убирается.       







