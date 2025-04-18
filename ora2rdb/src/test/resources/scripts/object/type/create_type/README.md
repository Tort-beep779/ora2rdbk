## Объектно-ориентированные возможности 
### Создание объекта
В oracle database естьвозможность создать объект. Пример

    CREATE OR REPLACE TYPE catalog_item_t AS OBJECT (
    id INTEGER,
    title VARCHAR2(4000),
    NOT INSTANTIABLE MEMBER FUNCTION ck_digit_okay
    RETURN BOOLEAN,
    MEMBER FUNCTION print
    RETURN VARCHAR2
    ) NOT INSTANTIABLE NOT FINAL;

Это аналог класса в Java.

Ключевые слова **NOT FINAL** в конце определения типа указывают, что он может служить
базовым или супертипом, то есть на его основе могут определяться другие типы

**NOT INSTANTIABLE**  - это означает, что PL/SQL позволит объявлять переменные типа
catalog_item_t, но им нельзя будет присваивать значения — ни явно, ни другим способом. Подобно абстрактному классу Java,

Приведенная выше команда **CREATE TYPE** создает спецификацию объектного типа.
Соответствующее тело типа с реализацией методов создается отдельно командой
**CREATE TYPE BODY**.

### Создание подтипа

    CREATE TYPE book_t UNDER catalog_item_t (
        isbn VARCHAR2(13),
        pages INTEGER,

    CONSTRUCTOR FUNCTION book_t (id IN INTEGER DEFAULT NULL,
        title IN VARCHAR2 DEFAULT NULL,
        isbn IN VARCHAR2 DEFAULT NULL,
        pages IN INTEGER DEFAULT NULL)
        RETURN SELF AS RESULT,

    OVERRIDING MEMBER FUNCTION ck_digit_okay
        RETURN BOOLEAN,
    OVERRIDING MEMBER FUNCTION print
        RETURN VARCHAR2
    );
 
Поля **id** и **title** наследуются от базового типа **catalog_item_t**

Тело метода book_t 

    CREATE OR REPLACE TYPE BODY book_t
    AS
    CONSTRUCTOR FUNCTION book_t (id    IN INTEGER
    , title IN VARCHAR2
    , isbn  IN VARCHAR2
    , pages IN INTEGER
    )
    RETURN SELF AS RESULT
    IS
    BEGIN
    self.id := id;
    self.title := title;
    self.isbn := isbn;
    self.pages := pages;
    
          IF isbn IS NULL OR self.ck_digit_okay
          THEN
             RETURN;
          ELSE
             raise_application_error (-20000
                                    , 'ISBN ' || isbn || ' has bad check digit'
                                     );
          END IF;
    END;
    
    OVERRIDING MEMBER FUNCTION ck_digit_okay
    RETURN BOOLEAN
    IS
    subtotal      PLS_INTEGER := 0;
    isbn_digits   VARCHAR2 (10);
    BEGIN
    /* remove dashes and spaces */
    isbn_digits := REPLACE (REPLACE (self.isbn, '-'), ' ');
    
          IF LENGTH (isbn_digits) != 10
          THEN
             RETURN FALSE;
          END IF;
    
          FOR nth_digit IN 1 .. 9
          LOOP
             subtotal :=
                subtotal
                + (11 - nth_digit)
                  * TO_NUMBER (SUBSTR (isbn_digits, nth_digit, 1));
          END LOOP;
    
          /* check digit can be 'X' which has value of 10 */
          IF UPPER (SUBSTR (isbn_digits, 10, 1)) = 'X'
          THEN
             subtotal := subtotal + 10;
          ELSE
             subtotal := subtotal + TO_NUMBER (SUBSTR (isbn_digits, 10, 1));
          END IF;
    
          RETURN MOD (subtotal, 11) = 0;
    EXCEPTION
    WHEN OTHERS
    THEN
    RETURN FALSE;
    END;
    
    OVERRIDING MEMBER FUNCTION PRINT
    RETURN VARCHAR2
    IS
    BEGIN
    RETURN    'id='
    || id
    || '; title='
    || title
    || '; isbn='
    || isbn
    || '; pages='
    || pages;
    END;
    END;

#### Ключевое слово SELF

Аналог ключевого слова this в языке Java. SELF — это ссылка на вызывающий (текущий) экземпляр, ис-
пользуемая исключительно в реализации методов. Ее можно применять для ссылки
на весь объект, а с точечным синтаксисом — для ссылки на атрибут или метод объекта:

IF SELF.id ...

IF SELF.ck_digit_okay() ...

