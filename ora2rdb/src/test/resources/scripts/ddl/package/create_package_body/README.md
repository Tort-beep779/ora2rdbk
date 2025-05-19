### Синтаксис create package body

```sql
CREATE [OR REPLACE] [EDITIONABLE | NONEDITIONABLE] PACKAGE BODY [schema_name.]<package_name>
{IS | AS}
[declare_section]
[
BEGIN
  <statement> [<statement> ...]
[<exception_section>]
]
END [<package_name>];

<exception_section> ::=
  EXCEPTION
  WHEN {<exception> [OR <exception>...] | OTHERS} THEN <statement> [<statement> ...]

```
declare_section - описан в директории declare_section
Синтаксис взят с [официальной документации Oracle](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/CREATE-PACKAGE-BODY-statement.html)

Declare_section отличается от declare_block тем, что в нем можно дополнительно указать procedure_definition и function_definition

----------------------------------------------------------------

### [create_editionable_noneditionable_package_body.sql](create_editionable_noneditionable_package_body.sql)

```sql
EDITIONABLE | NONEDITIONABLE
```  

Параметры `EDITIONABLE` и `NONEDITIONABLE` используются для управления версионированием объектов  
базы данных в контексте технологии Edition-Based Redefinition (EBR).  
`EDITIONABLE`:

* Указывает, что объект поддерживает версии (editions).
* Если объект является EDITIONABLE, его можно модифицировать или переопределять в новой редакции базы данных (edition),
  не затрагивая другие редакции. Значение по умолчанию: `EDITIONABLE`

`NONEDITIONABLE`:

* Указывает, что объект не поддерживает версии (editions).
* Объект NONEDITIONABLE существует в единственной версии в базе данных. Если его изменить, изменения будут видны всем
  пользователям независимо от текущей редакции.

----------------------------------------------------------------

### [create_or_replace_package_body.sql](create_or_replace_package_body.sql)

```sql
CREATE [OR REPLACE]
```

Указывает, что, если пакет уже существует, он будет заменен.
Если не указано, создание пакета вызовет ошибку, если пакет с таким именем существует.


----------------------------------------------------------------

### [create_package_body_initialize_section.sql](create_package_body_initialize_section.sql)

```sql
BEGIN
  <statement> [<statement> ...]
[<exception_section> ...]

<exception_section> ::= 
  EXCEPTION
  WHEN {<exception> [OR <exception>...] | OTHERS} 
  THEN <statement> [<statement> ...]
```

Инициализирует переменные и выполняет любые другие одноразовые шаги по настройке.
Блок выполняется один раз в рамках подключения во время обращения к элементам пакета.
Пример:  
Создание пакета и тела пакета:
```sql
CREATE OR REPLACE PACKAGE package_name IS
  cons CONSTANT VARCHAR2(6) := 'text';
end;


CREATE OR REPLACE PACKAGE BODY package_name IS
BEGIN 
     DBMS_OUTPUT.PUT_LINE('initial text');
end;

```
Обращение к константе в пакете:
```sql
BEGIN 
 DBMS_OUTPUT.PUT_LINE(package_name.cons);
END;
```
Вывод:
```sql
  initial text
  text
```
Повторное обращение к пакетной константе не приведет к выполнению блока инициализации, т.к. блок вызывается один раз в рамках подключения.
Пример:
Повторное обращение:
```sql
BEGIN 
 DBMS_OUTPUT.PUT_LINE(package_name.cons);
END;
```
Вывод:
```sql
  text
```

----------------------------------------------------------------


### [create_package_body_is_as.sql](create_package_body_is_as.sql)

```sql
IS | AS
```
IS и AS взаимозаменяемы и не влияют на поведение.
В RDB есть только AS, поэтому IS заменяется на AS при конвертации.

----------------------------------------------------------------

### [create_package_body_schema.sql](create_package_body_schema.sql)

```sql
[schema_name.]<package_name>
```
Указывает имя схемы, в которой создается пакет.

----------------------------------------------------------------

### [create_package_body_without_end_package_name.sql](create_package_body_without_end_package_name.sql)

Указание имени пакета после END является необязательным.

```sql
END [package_name];
```

----------------------------------------------------------------