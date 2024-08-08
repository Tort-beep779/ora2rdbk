/*
This very, VERY basic error logging package demonstrations the critical elements: use an autonomous
transaction to write a row to the error log; call the full suite of error-related built-in functions
to gather all generic information; pass in application-specific data for logging.
*/

    /*
/*
This very, VERY basic error logging package demonstrations the critical elements: use an autonomous
transaction to write a row to the error log; call the full suite of error-related built-in functions
to gather all generic information; pass in application-specific data for logging.
*/
*/
-- Error Logging Table
CREATE TABLE error_log
(
    log_id       NUMBER GENERATED ALWAYS AS IDENTITY,
    created_on   TIMESTAMP WITH LOCAL TIME ZONE,
    created_by   VARCHAR2 (100),
    errorcode    INTEGER,
    callstack    VARCHAR2 (4000),
    errorstack   VARCHAR2 (4000),
    backtrace    VARCHAR2 (4000),
    error_info   VARCHAR2 (4000)
);

-- Totally Minimal API for Error Logging
-- Including an example of providing a name for an un-named system exception
-- raised when a FORALL with SAVE EXCEPTIONS encounters at least one failed statement.
CREATE OR REPLACE PACKAGE error_mgr
IS

   failure_in_forall   EXCEPTION;

   PRAGMA EXCEPTION_INIT (failure_in_forall, -24381);

   PROCEDURE log_error (app_info_in IN VARCHAR2);
END;
/

-- Log the Error!
-- Key points: it's an autonomous transaction, which means the row is inserted into the error
-- log without also committing other unsaved changes in the session (likely part of a business
-- transaction that is in trouble). Plus, I invoke the full set of built-in functions to gather
-- system-level information and write to table. Finally, I add the application-specific information.

CREATE OR REPLACE PACKAGE BODY error_mgr
IS
   PROCEDURE log_error (app_info_in IN VARCHAR2)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      /* Cannot call this function directly in SQL */
      c_code   CONSTANT INTEGER := SQLCODE;
BEGIN
INSERT INTO error_log (created_on,
                       created_by,
                       errorcode,
                       callstack,
                       errorstack,
                       backtrace,
                       error_info)
VALUES (SYSTIMESTAMP,
        USER,
        c_code,
        DBMS_UTILITY.format_call_stack,
        DBMS_UTILITY.format_error_stack,
        DBMS_UTILITY.format_error_backtrace,
        app_info_in);

COMMIT;
END;
END;
/

-- Try it Out
DECLARE
l_company_id   INTEGER;
BEGIN
   IF l_company_id IS NULL
   THEN
      RAISE VALUE_ERROR;
END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      error_mgr.log_error ('Company ID is NULL - not allowed.');
END;
/

SELECT backtrace, errorstack, callstack FROM error_log;


BEGIN
FOR rec IN (  SELECT *
                   FROM endangered_species
               ORDER BY common_name)
   LOOP
      DBMS_OUTPUT.put_line (rec.common_name);
END LOOP;
END;
/

-- Cursor FOR Loop with Explicit Cursor
/*
As mentioned above, you can declare the cursor once, then use it
multiple times. Here, in two different cursor FOR loops.
*/

DECLARE
CURSOR species_cur
   IS
SELECT *
FROM endangered_species
ORDER BY common_name;

PROCEDURE start_conservation_effort
IS
BEGIN
      DBMS_OUTPUT.put_line ('Remove human presence');
END;
BEGIN
FOR rec IN species_cur
   LOOP
      DBMS_OUTPUT.put_line (rec.common_name);
END LOOP;

FOR rec IN species_cur
   LOOP
      start_conservation_effort;
END LOOP;
END;
/

/*
The MULTISET operators are fantastic, declarative, set-oriented functionality
for nested tables. But if you have a nested table of object types, then you will
also need to provide a MAP method for that object type if your MULTISET needs
to do a comparison. Which is true for pretty much every variation on MULTISET
except for MULTISET UNION [ALL].

For full explanation, see my blog post:

https://stevenfeuersteinonplsql.blogspot.com/2018/10/why-wont-multiset-work-for-me.html
*/

CREATE TABLE limbs
(
    nm        VARCHAR2 (100),
    avg_len   NUMBER
);

BEGIN
INSERT INTO limbs VALUES ('arm', 1);

INSERT INTO limbs VALUES ('leg', 2);

INSERT INTO limbs VALUES ('tail', 3);

COMMIT;
END;
/

CREATE OR REPLACE TYPE limb_ot AUTHID DEFINER
   IS OBJECT
(
   nm VARCHAR2 (100),
   avg_len NUMBER
)
/

-- Works Just Fine
-- MULTISET UNION = MULTISET UNION ALL, which means no checking for duplicates,
-- which means no need to compare, so no problem!
DECLARE
TYPE limbs_t IS TABLE OF limb_ot;

   l_limbs   limbs_t;
BEGIN
SELECT limb_ot (l.nm, l.avg_len)
           BULK COLLECT INTO l_limbs
FROM limbs l
ORDER BY l.nm;

l_limbs := l_limbs MULTISET UNION l_limbs;
   DBMS_OUTPUT.put_line ('Lots of limbs! ' || l_limbs.COUNT);
END;
/

-- Even Works for %ROWTYPE Elements!
-- Again, no need to make a comparison, so we are good.
DECLARE
TYPE limbs_t IS TABLE OF limbs%ROWTYPE;

   l_limbs   limbs_t;
BEGIN
SELECT l.nm, l.avg_len
    BULK COLLECT INTO l_limbs
FROM limbs l
ORDER BY l.nm;

l_limbs := l_limbs MULTISET UNION l_limbs;
   DBMS_OUTPUT.put_line ('Lots of limbs! ' || l_limbs.COUNT);
END;
/

-- EXCEPT Requires Comparison
-- Now we get an error. MULTISET EXCEPT can't do its job without comparing
-- contents of the object type. The limb_ot object type has no map method (yet!), so it fails.
DECLARE
TYPE limbs_t IS TABLE OF limb_ot;

   l_limbs   limbs_t;
BEGIN
SELECT limb_ot (l.nm, l.avg_len)
           BULK COLLECT INTO l_limbs
FROM limbs l
ORDER BY l.nm;

l_limbs := l_limbs MULTISET EXCEPT l_limbs;
   DBMS_OUTPUT.put_line ('Lots of limbs! ' || l_limbs.COUNT);
END;
/

-- UNION DISTINCT - Compares
-- I add the DISTINCT modifier and now MULTISET UNION doesn't work.
DECLARE
TYPE limbs_t IS TABLE OF limb_ot;
   l_limbs   limbs_t;
BEGIN
SELECT limb_ot (l.nm, l.avg_len)
           BULK COLLECT INTO l_limbs
FROM limbs l
ORDER BY l.nm;

l_limbs := l_limbs MULTISET UNION DISTINCT l_limbs;
   DBMS_OUTPUT.put_line ('Lots of limbs! ' || l_limbs.COUNT);
END;
/

-- Add a Map Method!
CREATE OR REPLACE TYPE limb_ot AUTHID DEFINER
   IS OBJECT
(
   nm VARCHAR2 (100),
   avg_len NUMBER,
   MAP MEMBER FUNCTION limb_map
      RETURN NUMBER
)
/

-- It's a silly mapping algorithm - only looks at the length of the name.
-- When you create your map method, make sure it reflects the logic of your data.
CREATE OR REPLACE TYPE BODY limb_ot
IS
   MAP MEMBER FUNCTION limb_map
      RETURN NUMBER
   IS
BEGIN
RETURN LENGTH (self.nm);
END;
END;
/

-- Now UNION DISTINCT Works
/*
With the map method in place, MULTISET operations that require comparisons
now work. But wait - only 2 elements in the resulting UNION DISTINCT? But all
three rows are distinct - what's going on? Hint: see mapping algorithm.
*/

DECLARE
TYPE limbs_t IS TABLE OF limb_ot;
   l_limbs   limbs_t;
BEGIN
SELECT limb_ot (l.nm, l.avg_len)
           BULK COLLECT INTO l_limbs
FROM limbs l
ORDER BY l.nm;

l_limbs := l_limbs MULTISET UNION DISTINCT l_limbs;
   DBMS_OUTPUT.put_line ('Lots of limbs! ' || l_limbs.COUNT);
END;
/

-- Now MULTISET EXCEPT works - and nothing is left when you "minus" something from itself.
DECLARE
TYPE limbs_t IS TABLE OF limb_ot;

   l_limbs   limbs_t;
BEGIN
SELECT limb_ot (l.nm, l.avg_len)
           BULK COLLECT INTO l_limbs
FROM limbs l
ORDER BY l.nm;

l_limbs := l_limbs MULTISET EXCEPT l_limbs;
   DBMS_OUTPUT.put_line ('Lots of limbs! ' || l_limbs.COUNT);
END;
/

-- But Still Not with %ROWTYPE
-- Sorry, there is no way currently in PL/SQL to either create an analogue of
-- a mapping method to a record type or compare records generally.
DECLARE
TYPE limbs_t IS TABLE OF limbs%ROWTYPE;

   l_limbs   limbs_t;
BEGIN
SELECT l.nm, l.avg_len
    BULK COLLECT INTO l_limbs
FROM limbs l
ORDER BY l.nm;

l_limbs := l_limbs MULTISET EXCEPT l_limbs;
   DBMS_OUTPUT.put_line ('Lots of limbs! ' || l_limbs.COUNT);
END;
/

-- Tweak Mapping Algorithm

/*
Remember that statement that showed only 2 rows were distinct?
That's not right - well, wait, but it was correct, given the simplistic
mapping algorithm. The names of two limbs were the same: 3, so they mapped
to the "same" as for as DISTINCT goes. Let's improve that algorithm!
*/

CREATE OR REPLACE TYPE BODY limb_ot
IS
   MAP MEMBER FUNCTION limb_map
      RETURN NUMBER
   IS
BEGIN
RETURN LENGTH (self.nm) + self.avg_len;
END;
END;
/

-- Mapping Algorithms Matter
-- With the new algorithm, the DISTINCT operation now gets a different value
-- for each row and so 3 elements are assigned to l_limbs.
DECLARE
TYPE limbs_t IS TABLE OF limb_ot;

   l_limbs   limbs_t;
BEGIN
SELECT limb_ot (l.nm, l.avg_len)
           BULK COLLECT INTO l_limbs
FROM limbs l
ORDER BY l.nm;

l_limbs := l_limbs MULTISET UNION DISTINCT l_limbs;
   DBMS_OUTPUT.put_line ('Lots of limbs! ' || l_limbs.COUNT);
END;
/

/*
One of the nicest things about nested tables is that you can compare two
such collections for equality using nothing more than...the equality operator!

Key things to remember: order of elements is not significant; if the collections
have different numbers of elements, "=" returns FALSE; if they have the same
number of elements, but at least one of the values in either collection is NULL,
"=" returns NULL; two initialized, but empty collections are equal.
*/

-- What do you think will be displayed?
-- Before running this script, see if you can predict the outcome!
DECLARE
TYPE nested_tab_t IS TABLE OF INTEGER;

   tab_1   nested_tab_t := nested_tab_t (1, 2, 3, 4, 5, 6, 7);
   tab_2   nested_tab_t := nested_tab_t (7, 6, 5, 4, 3, 2, 1);
   tab_3   nested_tab_t := nested_tab_t ();
   tab_4  nested_tab_t := nested_tab_t ();
   tab_5  nested_tab_t := nested_tab_t (null);
   tab_6  nested_tab_t := nested_tab_t (null);

   PROCEDURE check_for_equality (i_tab_1   IN nested_tab_t,
                                 i_tab_2   IN nested_tab_t)
IS
      v_equal   BOOLEAN := i_tab_1 = i_tab_2;
BEGIN
      DBMS_OUTPUT.put_line (
            'Equal? '
         || CASE
               WHEN v_equal IS NULL THEN 'null'
               WHEN v_equal THEN 'equal'
               ELSE 'not equal'
            END);
END check_for_equality;
BEGIN
   check_for_equality (tab_1, tab_2);
   tab_1.EXTEND (1);
   check_for_equality (tab_1, tab_2);
   tab_2.EXTEND (1);
   check_for_equality (tab_1, tab_2);
   check_for_equality (tab_1, tab_3);
   check_for_equality (tab_3, tab_4);
   check_for_equality (tab_5, tab_6);
END;
/

/*
While PL/SQL is mostly used to provide secure, efficient access to the relational
tables (SQL), you can also - to some extent - follow an object-oriented approach
as well. PL/SQL doesn't offer classes, but instead OBJECT TYPEs. You can then declare
instances of the object type (just like an object is an instance of a class).
You can declare static and member methods, take advantage of inheritance, and
many other expected O-O features. One thing you cannot do, though, is declare
private attributes and methods. It's all public in object types.
*/

-- Base or Root Object Type

/*
I like to eat. So let's build a class hierarchy of food. Each instance of
food has a name, a good group, and the place it is grown. I also include a
function to return the price of the food - but I do not implement that function.
Instead, it and the type are NOT INSTANTIABLE. This means you cannot declare an
instance of food_t. Instead you must define child object types that implement
the price function, and then you can declare and manipulate variables based on those child types.
*/

CREATE TYPE food_t AS OBJECT (
   NAME         VARCHAR2 (100)
 , food_group   VARCHAR2 (100)
 , grown_in     VARCHAR2 (100)
 ,
   -- Generic foods cannot have a price, but we can
   -- insist that all subtypes DO implement a price
   -- function.
   NOT INSTANTIABLE MEMBER FUNCTION price
      RETURN NUMBER
)
NOT FINAL NOT INSTANTIABLE;
/

-- Every Dessert is a Food

/*
But not every food is a dessert. That's what the hierarchy says.
Note that this type is instantiable. Which means I must include an object
type body that implements price.
*/

CREATE TYPE dessert_t UNDER food_t (
   contains_chocolate   CHAR (1)
 , year_created         NUMBER (4)
 , OVERRIDING MEMBER FUNCTION price
      RETURN NUMBER
)
NOT FINAL;
/

-- An Object Type Body
/*
I override the base price function with an actual implementation.
As you can see and would expect, the price goes up if the dessert contains chocolate.
*/
CREATE OR REPLACE TYPE BODY dessert_t
IS
   OVERRIDING MEMBER FUNCTION price
      RETURN NUMBER
   IS
      multiplier   NUMBER := 1;
BEGIN
      DBMS_OUTPUT.put_line ('Dessert price!');

      IF SELF.contains_chocolate = 'Y'
      THEN
         multiplier := 2;
END IF;

      IF SELF.year_created < 1900
      THEN
         multiplier := multiplier + 0.5;
END IF;

RETURN (10.00 * multiplier);
END;
END;
/

-- Every Cake is a Dessert
-- But not every dessert is a cake. And I override dessert's price function with one specially for cake.
CREATE TYPE cake_t UNDER dessert_t (
   diameter      NUMBER
 , inscription   VARCHAR2 (200)
 ,
   -- Inscription and diameter determine the price
   OVERRIDING MEMBER FUNCTION price
      RETURN NUMBER
)
/

-- Cake-Specific Price Function
-- Cakes often have messages on their surface - an inscription - and you pay by the letter.
CREATE OR REPLACE TYPE BODY cake_t
IS
   OVERRIDING MEMBER FUNCTION price
      RETURN NUMBER
   IS
BEGIN
      DBMS_OUTPUT.put_line ('Cake price!');
RETURN  (  5.00                                             -- base price
    + 0.25 * (LENGTH (SELF.inscription))          -- $.25 per letter
    + 0.50 * diameter
    );
END;
END;
/

-- Can I Declare a Food Variable?
-- No! The type is NOT INSTANTIABLE, so this attempt fails.
DECLARE
my_favorite_vegetable   food_t
                           := food_t ('Brussel Sprouts', 'VEGETABLE', 'farm');
BEGIN
   DBMS_OUTPUT.put_line (my_favorite_vegetable.price);
END;
/

DECLARE
last_resort_dessert   dessert_t
                         := dessert_t ('Jello', 'PROTEIN', 'bowl', 'N', 1887);
   heavenly_cake         cake_t
      := cake_t ('Marzepan Delight'
               , 'CARBOHYDRATE'
               , 'bakery'
               , 'N'
               , 1634
               , 8
               , 'Happy Birthday!'
                );
BEGIN
   DBMS_OUTPUT.put_line (last_resort_dessert.price);
   DBMS_OUTPUT.put_line (heavenly_cake.price);
END;
/

DECLARE
TYPE foodstuffs_nt IS TABLE OF food_t;

   fridge_contents   foodstuffs_nt
      := foodstuffs_nt (dessert_t ('Strawberries and cream'
                                 , 'FRUIT'
                                 , 'Backyard'
                                 , 'N'
                                 , 2001
                                  )
                      , dessert_t ('Strawberries and cream'
                                 , 'FRUIT'
                                 , 'Backyard'
                                 , 'N'
                                 , 2001
                                  )
                      , cake_t ('Chocolate Supreme'
                              , 'CARBOHYDATE'
                              , 'Kitchen'
                              , 'Y'
                              , 2001
                              , 8
                              , 'Happy Birthday, Veva'
                               )
                       );
BEGIN
FOR indx IN fridge_contents.FIRST .. fridge_contents.LAST
   LOOP
      DBMS_OUTPUT.put_line (   'Price of '
                            || fridge_contents (indx).NAME
                            || ' = '
                            || fridge_contents (indx).price
                           );
END LOOP;
END;
/

-- Store Object Type Instances in Tables
-- You can create relational tables with columns whose types are object types. And substitutability works here too!
CREATE TABLE food_tab (food food_t)
    /

-- Cakes and Desserts are Foods
-- So I can insert them into the table.
DECLARE
s_and_c    dessert_t
                 := dessert_t ('Strawberries and cream',
                               'FRUIT',
                               'Backyard',
                               'N',
                               2001);
   choc_sup   cake_t
                 := cake_t ('Chocolate Supreme',
                            'CARBOHYDATE',
                            'Kitchen',
                            'Y',
                            2001,
                            8,
                            'Happy Birthday, Veva');
BEGIN
INSERT INTO food_tab
VALUES (s_and_c);

INSERT INTO food_tab
VALUES (choc_sup);
END;
/

SELECT COUNT (*) FROM food_tab
    /


DECLARE
CURSOR species_cur
   IS
SELECT *
FROM endangered_species
ORDER BY common_name;

PROCEDURE start_conservation_effort
IS
BEGIN
      DBMS_OUTPUT.put_line ('Remove human presence');
END;
BEGIN
FOR rec IN species_cur
   LOOP
      DBMS_OUTPUT.put_line (rec.common_name);
END LOOP;

FOR rec IN species_cur
   LOOP
      start_conservation_effort;
END LOOP;
END;


/*
A table function is a function executed with the TABLE operator,
and then within the FROM clause of a query - in other words, a function
that is selected from just like a relational table! A common usage of
table functions in the Data Warehousing world is to stream data directly
from one process or transformation, to the next process without
intermediate staging (a "streaming" table function). But you can also
leverage table functions to programatically create a dataset and then
make it available in SQL.
*/

-- Create Nested Table Type
/*
A table function must return a collection that is visible in the SQL layer.
So the collection's type must be defined at the schema-level as shown here or
in 12.1 and higher in a package specification.
*/

CREATE OR REPLACE TYPE names_nt IS TABLE OF VARCHAR2 ( 1000 );
/

-- Silly Dataset Generator
/*
I need to generated N number of names. Here's a function that does it.
It's a silly example. I can do this in SQL, too, but it demonstrates the ability
to programmatically (procedurally) populate a collection.
*/

CREATE OR REPLACE FUNCTION lotsa_names (
   base_name_in   IN   VARCHAR2
 , count_in       IN   INTEGER
)
   RETURN names_nt
IS
   retval names_nt := names_nt ( );
BEGIN
   retval.EXTEND ( count_in );

FOR indx IN 1 .. count_in
   LOOP
      retval ( indx ) := base_name_in || ' ' || indx;
END LOOP;

RETURN retval;
END lotsa_names;
/

-- Call table function inside SELECT
/*
And there you have it, folks! Embed the function invocation inside the
TABLE operator, in the FROM clause, and Oracle Database works its magic for you.

And when you have a collection of scalars, the column name is hard-coded to
COLUMN_VALUE but you can use a column alias to change it to whatever you'd like.
*/

SELECT COLUMN_VALUE my_name
FROM TABLE ( lotsa_names ( 'Steven', 100 )) names ;

-- A "Table" Just Like Any Other
/*
Once TABLE has transformed your collection into a relational dataset,
you can join it to other tables, perform unions, etc. Whatever you would
and could do with a "normal" table or view.
*/

SELECT COLUMN_VALUE my_alias
FROM hr.employees, TABLE ( lotsa_names ( 'Steven', 10 )) names ;

-- Return Cursor Variable to Dataset
/*
Here's an example of calling the table function, converting to a SQL dataset,
assigning it to a cursor variable, and then returning that via the function.
This function could then be invoked from a host environment, say a Java program,
and the data will be consumed. That Java or UI developer will have no idea
how the data set was constructed, and why should they care?
*/

CREATE OR REPLACE FUNCTION lotsa_names_cv (
   base_name_in   IN   VARCHAR2
 , count_in       IN   INTEGER
)
   RETURN sys_refcursor
IS
   retval sys_refcursor;
BEGIN
OPEN retval FOR
SELECT COLUMN_VALUE
FROM TABLE ( lotsa_names ( base_name_in, count_in )) names;

RETURN retval;
END lotsa_names_cv;
/

DECLARE
l_names_cur sys_refcursor;
   l_name VARCHAR2 ( 32767 );
BEGIN
   l_names_cur := lotsa_names_cv ( 'Steven', 100 );

   LOOP
FETCH l_names_cur INTO l_name;

      EXIT WHEN l_names_cur%NOTFOUND;
      DBMS_OUTPUT.put_line ( 'Name = ' || l_name );
END LOOP;

CLOSE l_names_cur;
END;
/




/*
Use MULTISET UNION to perform set-level union operations on nested tables.
Remember: with MULTISET, ALL is the default, not DISTINCT (the opposite
holds true with SQL UNION).
*/

CREATE OR REPLACE TYPE strings_nt IS TABLE OF VARCHAR2 (1000)
/

CREATE OR REPLACE PACKAGE authors_pkg
IS
   steven_authors   strings_nt;
   veva_authors     strings_nt;
   eli_authors      strings_nt;

   PROCEDURE show_authors (title_in IN VARCHAR2, authors_in IN strings_nt);

   PROCEDURE init_authors;
END;
/

CREATE OR REPLACE PACKAGE BODY authors_pkg
IS
   PROCEDURE show_authors (title_in IN VARCHAR2, authors_in IN strings_nt)
   IS
BEGIN
      DBMS_OUTPUT.put_line (title_in);

FOR indx IN 1 .. authors_in.COUNT
      LOOP
         DBMS_OUTPUT.put_line (indx || ' = ' || authors_in (indx));
END LOOP;
END show_authors;

   PROCEDURE init_authors
IS
BEGIN
      steven_authors :=
         strings_nt ('ROBIN HOBB'
                   , 'ROBERT HARRIS'
                   , 'DAVID BRIN'
                   , 'SHERI S. TEPPER'
                   , 'CHRISTOPHER ALEXANDER'
                   , 'PIERS ANTHONY');
      veva_authors :=
         strings_nt ('ROBIN HOBB', 'SHERI S. TEPPER', 'ANNE MCCAFFREY');

      eli_authors :=
         strings_nt ('PIERS ANTHONY', 'SHERI S. TEPPER', 'DAVID BRIN');
END;
END;
/

DECLARE
our_authors   strings_nt;
BEGIN
   authors_pkg.init_authors;
   our_authors :=
      authors_pkg.steven_authors MULTISET UNION authors_pkg.veva_authors;

   authors_pkg.show_authors ('Steven and Veva', our_authors);

   /* Use MULTISET UNION inside SQL */
   DBMS_OUTPUT.put_line ('Union inside SQL');

FOR rec IN (  SELECT COLUMN_VALUE
                   FROM TABLE (
                           authors_pkg.veva_authors
                              MULTISET UNION authors_pkg.steven_authors)
               ORDER BY COLUMN_VALUE)
   LOOP
      DBMS_OUTPUT.put_line (rec.COLUMN_VALUE);
END LOOP;

   our_authors :=
      authors_pkg.steven_authors
         MULTISET UNION DISTINCT authors_pkg.veva_authors;

   authors_pkg.show_authors ('Steven then Veva with DISTINCT', our_authors);
END;
/

/*
 Method 2 means your dynamically-constructed SQL statement in a non-query DML
 (insert, update, delete, merge) with a fixed number of bind variables.
 That is, at the time you are writing your code, you know how many variables
 you must bind into placeholders.
*/

-- Copy Table from HR to Change It
CREATE TABLE employees
AS
SELECT * FROM hr.employees;

-- Silly Little Helper Function
/*
This is dynamic SQL method 3, by the way: a SELECT with fixed number of bind
variables and/or SELECT list elements (INTO clause). We take basic steps to
guard against SQL injection with the DBMS_ASSERT package. But there is still
a GAPING HOLE with the WHERE clause. Thus, this program should never be callable
directly by a user, with un-checked user input.
*/

CREATE OR REPLACE FUNCTION table_count (
   table_name_in   IN all_tables.table_name%TYPE,
   where_in        IN VARCHAR2 DEFAULT NULL)
   RETURN PLS_INTEGER
   AUTHID CURRENT_USER
IS
   l_table_name   all_tables.table_name%TYPE;
   l_return       PLS_INTEGER;
BEGIN
   l_table_name := sys.DBMS_ASSERT.sql_object_name (table_name_in);
EXECUTE IMMEDIATE
    'SELECT COUNT(*) FROM ' || table_name_in || ' WHERE ' || where_in
    INTO l_return;

RETURN l_return;
END;
/

-- Can't Bind Column Names
/*
First of all, remember: you can only bind variable values. You cannot bind parts
of the SQL statement that are needed at the time the statement is parsed, such
as the table name, column name, where clause, etc. This code will compile, but fail to run.
*/

CREATE OR REPLACE PROCEDURE set_to_10000 (col_in             IN VARCHAR2,
                                          department_id_in   IN PLS_INTEGER)
IS
   l_update CONSTANT VARCHAR2 (1000) :=
      'UPDATE employees SET :colname = 10000
        WHERE department_id = :dept';
BEGIN
EXECUTE IMMEDIATE l_update USING col_in, department_id_in;

DBMS_OUTPUT.put_line ('Rows updated: ' || TO_CHAR (SQL%ROWCOUNT));
END;
/

-- Can't Bind Column Names - In Action
BEGIN
   set_to_10000 ('salary', 50);
/* ORA-01747: invalid user.table.column, table.column, or column specification */
END;
/

-- Bind Single Variable
/*
Now I concatenate in the name of the column - which introduces the possibility of
SQL injection, so watch out! I bind the department ID. Each placeholder - in the
form :name, where name could also be an integer value - must have a corresponding
value in the USING clause.
*/

CREATE OR REPLACE PROCEDURE set_to_10000 (col_in             IN VARCHAR2,
                                          department_id_in   IN PLS_INTEGER)
IS
   l_update   VARCHAR2 (1000)
      :=    'UPDATE employees SET '
         || col_in
         || ' = 10000
        WHERE department_id = :dept';
BEGIN
EXECUTE IMMEDIATE l_update USING department_id_in;

DBMS_OUTPUT.put_line ('Rows updated: ' || TO_CHAR (SQL%ROWCOUNT));
END;
/

BEGIN
   DBMS_OUTPUT.put_line (
         'Before '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));

   set_to_10000 ('salary', 50);

   DBMS_OUTPUT.put_line (
         'After '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));
ROLLBACK;
END;
/

-- Multiple Placeholders, Different Names
-- I have two placeholders with different names. I therefore have two expressions in the USING clause.
CREATE OR REPLACE PROCEDURE updnumval (col_in             IN VARCHAR2,
                                       department_id_in   IN PLS_INTEGER,
                                       val_in             IN NUMBER)
IS
   l_update   VARCHAR2 (1000)
      :=    'UPDATE employees SET '
         || col_in
         || ' = :val
        WHERE department_id = :dept';
BEGIN
EXECUTE IMMEDIATE l_update USING val_in, department_id_in;

DBMS_OUTPUT.put_line ('Rows updated: ' || TO_CHAR (SQL%ROWCOUNT));
END;
/

BEGIN
   DBMS_OUTPUT.put_line (
         'Before '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));

   updnumval ('salary', 50, 10000);

   DBMS_OUTPUT.put_line (
         'After '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));
ROLLBACK;
END;
/

-- Three Placeholders, Repeating Names
-- Now I have three placeholders and the name "val" is used twice. When I execute a dynamic SQL statement, I must have an expression in the USING clause for each placeholder - by position, not name. So you see three variables, including val_in twice. Of course, I could use a different expression for the second "val" placeholder. They are NOT connected by name.
CREATE OR REPLACE PROCEDURE updnumval (col_in             IN VARCHAR2,
                                       department_id_in   IN PLS_INTEGER,
                                       val_in             IN NUMBER)
IS
   l_update   VARCHAR2 (1000)
      :=    'UPDATE employees SET '
         || col_in
         || ' = :val
        WHERE department_id = :dept and :val IS NOT NULL';
BEGIN
EXECUTE IMMEDIATE l_update USING val_in, department_id_in, val_in;

DBMS_OUTPUT.put_line ('Rows updated: ' || TO_CHAR (SQL%ROWCOUNT));
END;
/

BEGIN
   DBMS_OUTPUT.put_line (
         'Before '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));

   updnumval ('salary', 50, 10000);

   DBMS_OUTPUT.put_line (
         'After '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));
ROLLBACK;
END;
/

/*
The "in tab" procedure displays what's in a table, using DBMS_SQL and method 4 dynamic SQL.
That is, I do not know at the time I compile my code how many columns I will displaying.
Most dynamic SQL method 4 is more complicated than this, so it serves as a nice introduction.
Much of the code volume has to do with formatting, but I also like to use this as an
example of relying on nested subprograms to make code much more readable.

NOTE: this procedure is vulnerable to SQL injection.
      Users should NEVER be allowed to pass inputs to program like this directly!
*/

CREATE OR REPLACE PROCEDURE intab (table_in          IN VARCHAR2,
                                   where_in          IN VARCHAR2 DEFAULT NULL,
                                   colname_like_in   IN VARCHAR2 := '%')
   /*
   | Demonstration of method 4 dynamic SQL with DBMS_SQL:
   |   Show the contents "in" a "tab"le - intab.
   |   Only supports number, date, string column types.
   |
   | Oracle Database 11g version utilizes DBMS_SQL.to_cursor_number
   | to greatly simplify the code.
   |
   | Author: Steven Feuerstein, steven.feuerstein@oracle.com
   */
   AUTHID CURRENT_USER
IS
   -- Avoid repetitive "maximum size" declarations for VARCHAR2 variables.
   SUBTYPE max_varchar2_t IS VARCHAR2 (32767);

   -- Minimize size of a string column.
   c_min_length   CONSTANT PLS_INTEGER := 10;

   -- Collection to hold the column information for this table.
   TYPE columns_tt IS TABLE OF all_tab_columns%ROWTYPE
      INDEX BY PLS_INTEGER;

   l_columns               columns_tt;
   -- Open a cursor for use by DBMS_SQL subprograms throughout this procedure.
   l_cursor                INTEGER;
   --
   -- Formatting and SELECT elements used throughout the program.
   l_header                max_varchar2_t;
   l_select_list           max_varchar2_t;
   g_row_line_length       INTEGER := 0;

   /* Utility functions that determine the "family" of the column datatype.
   They do NOT comprehensively cover the datatypes supported by Oracle.
   You will need to expand on these programs if you want your version of
   intab to support a wider range of datatypes.
   */

   FUNCTION is_string (columns_in IN columns_tt, row_in IN INTEGER)
      RETURN BOOLEAN
   IS
BEGIN
RETURN (columns_in (row_in).data_type IN ('CHAR', 'VARCHAR2', 'VARCHAR'));
END;

   FUNCTION is_number (columns_in IN columns_tt, row_in IN INTEGER)
      RETURN BOOLEAN
   IS
BEGIN
RETURN (columns_in (row_in).data_type IN ('FLOAT', 'INTEGER', 'NUMBER'));
END;

   FUNCTION is_date (columns_in IN columns_tt, row_in IN INTEGER)
      RETURN BOOLEAN
   IS
BEGIN
RETURN (columns_in (row_in).data_type IN ('DATE', 'TIMESTAMP'));
END;

   PROCEDURE load_column_information (
      select_list_io   IN OUT NOCOPY VARCHAR2,
      header_io        IN OUT NOCOPY VARCHAR2,
      columns_io       IN OUT NOCOPY columns_tt)
IS
      l_dot_location   PLS_INTEGER;
      l_owner          VARCHAR2 (100);
      l_table          VARCHAR2 (100);
      l_index          PLS_INTEGER;
      --
      no_such_table    EXCEPTION;
      PRAGMA EXCEPTION_INIT (no_such_table, -942);
BEGIN
      -- Separate the schema and table names, if both are present.
      l_dot_location := INSTR (table_in, '.');

      IF l_dot_location > 0
      THEN
         l_owner := SUBSTR (table_in, 1, l_dot_location - 1);
         l_table := SUBSTR (table_in, l_dot_location + 1);
ELSE
         l_owner := USER;
         l_table := table_in;
END IF;

      -- Retrieve all the column information into a collection of records.

SELECT *
           BULK COLLECT INTO columns_io
FROM all_tab_columns
WHERE     owner = l_owner
  AND table_name = l_table
  AND column_name LIKE NVL (colname_like_in, '%');

l_index := columns_io.FIRST;

      IF l_index IS NULL
      THEN
         RAISE no_such_table;
ELSE
         /* Add each column to the select list, calculate the length needed
         to display each column, and also come up with the total line length.
         Again, please note that the datatype support here is quite limited.
         */

         WHILE (l_index IS NOT NULL)
         LOOP
            IF select_list_io IS NULL
            THEN
               select_list_io := columns_io (l_index).column_name;
ELSE
               select_list_io :=
                  select_list_io || ', ' || columns_io (l_index).column_name;
END IF;

            IF is_string (columns_io, l_index)
            THEN
               columns_io (l_index).data_length :=
                  GREATEST (
                     LEAST (columns_io (l_index).data_length, c_min_length),
                     LENGTH (columns_io (l_index).column_name));
            ELSIF is_date (columns_io, l_index)
            THEN
               columns_io (l_index).data_length :=
                  GREATEST (c_min_length,
                            LENGTH (columns_io (l_index).column_name));
            ELSIF is_number (columns_io, l_index)
            THEN
               columns_io (l_index).data_length :=
                  GREATEST (NVL (columns_io (l_index).data_precision, 38),
                            LENGTH (columns_io (l_index).column_name));
END IF;

            g_row_line_length :=
               g_row_line_length + columns_io (l_index).data_length + 1;
            --
            -- Construct column header line incrementally.
            header_io :=
                  header_io
               || ' '
               || RPAD (columns_io (l_index).column_name,
                        columns_io (l_index).data_length);
            l_index := columns_io.NEXT (l_index);
END LOOP;
END IF;
END load_column_information;

   PROCEDURE report_error (text_in IN VARCHAR2, cursor_io IN OUT INTEGER)
IS
BEGIN
      IF DBMS_SQL.is_open (cursor_io)
      THEN
         DBMS_SQL.close_cursor (cursor_io);
END IF;

      DBMS_OUTPUT.put_line (text_in);
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
END;

   PROCEDURE construct_and_open_cursor (select_list_in   IN     VARCHAR2,
                                        cursor_out          OUT INTEGER)
IS
      l_query          max_varchar2_t;
      l_where_clause   max_varchar2_t := LTRIM (where_in);
      l_cursor         SYS_REFCURSOR;
BEGIN
      -- Construct a where clause if a value was specified.

      IF l_where_clause IS NOT NULL
      THEN
         --

         IF (    l_where_clause NOT LIKE 'GROUP BY%'
             AND l_where_clause NOT LIKE 'ORDER BY%')
         THEN
            l_where_clause := 'WHERE ' || LTRIM (l_where_clause, 'WHERE');
END IF;
END IF;

      -- Assign the dynamic string to a local variable so that it can be
      -- easily used to report an error.
      l_query :=
            'SELECT '
         || select_list_in
         || '  FROM '
         || table_in
         || ' '
         || l_where_clause;
      DBMS_OUTPUT.put_line (l_querY);

      -- 11.1 DBMS_SQL enhancement: convert to cursor variable.
OPEN l_cursor FOR l_query;

cursor_out := DBMS_SQL.to_cursor_number (l_cursor);
EXCEPTION
      WHEN OTHERS
      THEN
         report_error ('Error constructing and opening cursor: ' || l_query,
                       cursor_out);
         RAISE;
END;

   PROCEDURE define_columns_and_execute (cursor_io    IN OUT INTEGER,
                                         columns_in   IN     columns_tt)
IS
      l_index      PLS_INTEGER;
      l_feedback   PLS_INTEGER;
BEGIN
      /*
      DBMS_SQL.DEFINE_COLUMN
      Before executing the query, I need to tell DBMS_SQL the datatype
      of each the columns being selected in the query. I simply pass
      a literal of the appropriate type to an overloading of
      DBMS_SQL.DEFINE_COLUMN. With string types, I need to also specify
      the maximum length of the value.
      */
      l_index := columns_in.FIRST;

      WHILE (l_index IS NOT NULL)
      LOOP
         IF is_string (columns_in, l_index)
         THEN
            DBMS_SQL.define_column (cursor_io,
                                    l_index,
                                    'a',
                                    columns_in (l_index).data_length);
         ELSIF is_number (columns_in, l_index)
         THEN
            DBMS_SQL.define_column (cursor_io, l_index, 1);
         ELSIF is_date (columns_in, l_index)
         THEN
            DBMS_SQL.define_column (cursor_io, l_index, SYSDATE);
END IF;

         l_index := columns_in.NEXT (l_index);
END LOOP;
EXCEPTION
      WHEN OTHERS
      THEN
         report_error ('Error defining columns', cursor_io);
         RAISE;
END;

   PROCEDURE build_and_display_output (header_in    IN     VARCHAR2,
                                       cursor_io    IN OUT INTEGER,
                                       columns_in   IN     columns_tt)
IS
      -- Used to hold the retrieved column values.
      l_string_value     VARCHAR2 (2000);
      l_number_value     NUMBER;
      l_date_value       DATE;
      --
      l_feedback         INTEGER;
      l_index            PLS_INTEGER;
      l_one_row_string   max_varchar2_t;

      -- Formatting for the output of the header information

      PROCEDURE display_header
IS
         l_border   max_varchar2_t := RPAD ('-', g_row_line_length, '-');

         FUNCTION centered_string (string_in   IN VARCHAR2,
                                   length_in   IN INTEGER)
            RETURN VARCHAR2
         IS
            len_string   INTEGER := LENGTH (string_in);
BEGIN
            IF len_string IS NULL OR length_in <= 0
            THEN
               RETURN NULL;
ELSE
               RETURN    RPAD (' ', (length_in - len_string) / 2 - 1)
                      || LTRIM (RTRIM (string_in));
END IF;
END centered_string;
BEGIN
         DBMS_OUTPUT.put_line (l_border);
         DBMS_OUTPUT.put_line (
            centered_string ('Contents of ' || table_in, g_row_line_length));
         DBMS_OUTPUT.put_line (l_border);
         DBMS_OUTPUT.put_line (l_header);
         DBMS_OUTPUT.put_line (l_border);
END display_header;
BEGIN
      display_header;

      /*
         DBMS_SQL.FETCH_ROWS
         Fetch a row, and return the numbers of rows fetched.
         When 0, we are done.
      */
      WHILE DBMS_SQL.fetch_rows (cursor_io) > 0
      LOOP
         l_one_row_string := NULL;
         l_index := columns_in.FIRST;

         WHILE (l_index IS NOT NULL)
         LOOP
            /*
            DBMS_SQL.COLUMN_VALUE
            Retrieve each column value in the current row,
            deposit it into a variable of the appropriate type,
            then convert to a string and concatenate to the
            full line variable.
            */

            IF is_string (columns_in, l_index)
            THEN
               DBMS_SQL.COLUMN_VALUE (cursor_io, l_index, l_string_value);
            ELSIF is_number (columns_in, l_index)
            THEN
               DBMS_SQL.COLUMN_VALUE (cursor_io, l_index, l_number_value);
               l_string_value := TO_CHAR (l_number_value);
            ELSIF is_date (columns_in, l_index)
            THEN
               DBMS_SQL.COLUMN_VALUE (cursor_io, l_index, l_date_value);
               l_string_value := TO_CHAR (l_date_value);
END IF;

            l_one_row_string :=
                  l_one_row_string
               || ' '
               || RPAD (NVL (l_string_value, ' '),
                        columns_in (l_index).data_length);
            l_index := columns_in.NEXT (l_index);
END LOOP;

         DBMS_OUTPUT.put_line (l_one_row_string);
END LOOP;
EXCEPTION
      WHEN OTHERS
      THEN
         report_error (
            'Error displaying output; last row = ' || l_one_row_string,
            cursor_io);
END;
BEGIN
   load_column_information (l_select_list, l_header, l_columns);
   construct_and_open_cursor (l_select_list, l_cursor);
   define_columns_and_execute (l_cursor, l_columns);
   build_and_display_output (l_header, l_cursor, l_columns);
END intab;
/

BEGIN
   intab ('HR.DEPARTMENTS',
          where_in          => 'department_name like ''%io%''',
          colname_like_in   => '%NAME%');
END;
/

BEGIN
   intab ('HR.EMPLOYEES',
          where_in          => 'department_id = 80',
          colname_like_in   => '%NAME%');
END;
/


/*
Just when you thought your dynamic SQL was safe! This script offers a simple
example of how dynamic SQL that contains concatenation (as opposed to binding)
can be subverted to serve possibly malicious purposes.
*/

CREATE OR REPLACE PACKAGE sql_injection_demo
IS
   TYPE name_sal_rt IS RECORD (
      last_name   VARCHAR2(1000)
    , salary      NUMBER
   );

   FUNCTION name_sal_for (where_in IN VARCHAR2 DEFAULT NULL)
      RETURN sys_refcursor;

   PROCEDURE show_name_sal (
      title_in IN VARCHAR2
    , rows_inout IN OUT sys_refcursor
   );
END sql_injection_demo;
/

-- Danger! Danger! Danger!
-- Notice that concatenation of an entire WHERE clause. So flexible, so enticing....so dangerous!
CREATE OR REPLACE PACKAGE BODY sql_injection_demo
IS
   FUNCTION name_sal_for (where_in IN VARCHAR2 DEFAULT NULL)
      RETURN sys_refcursor
   IS
      l_query   VARCHAR2 (32767)
              := 'select last_name, salary from employees WHERE ' || where_in;
      l_cursor        sys_refcursor;
BEGIN
OPEN l_cursor FOR l_query;

RETURN l_cursor;
END name_sal_for;

   PROCEDURE show_name_sal (
      title_in IN VARCHAR2
    , rows_inout IN OUT sys_refcursor
   )
IS
      l_employee   name_sal_rt;
BEGIN
      DBMS_OUTPUT.put_line (RPAD ('=', 100, '='));
      DBMS_OUTPUT.put_line ('SQL Injection Demonstration: ' || title_in);

      LOOP
FETCH rows_inout
          INTO l_employee;
         EXIT WHEN rows_inout%NOTFOUND;

         DBMS_OUTPUT.put_line (l_employee.last_name || '-'
                               || l_employee.salary
                              );
END LOOP;

CLOSE rows_inout;
END show_name_sal;
END sql_injection_demo;
/

-- That's a Funny WHERE Clause!
-- Yep. I can just append a UNION to end of a "normal" WHERE clause predicate, and go crazy.
DECLARE
l_rows   sys_refcursor;
BEGIN
   l_rows := sql_injection_demo.name_sal_for ('department_id = 100');
   sql_injection_demo.show_name_sal ('Department 100', l_rows);
   --
   l_rows :=
      sql_injection_demo.name_sal_for
                    (   'department_id = 100'
                     || ' UNION select ''USER: '' || username, 1 from all_users'
                    );
   sql_injection_demo.show_name_sal ('Department 100 PLUS Users', l_rows);
END;
/

/*
The DBMS_UTILITY.format_error_backtrace function, added in Oracle Database 10g Release 2,
is a critical subprogram to call when logging exceptions. It returns a string that traces
the error back to the line on which it was raised! Note: if you re-raise an exception as
it propagates up the stack, you will lose the "original" line number. The back trace function
always only traces back to the most recently raised exception.
*/

CREATE OR REPLACE PROCEDURE proc1
IS
BEGIN
   DBMS_OUTPUT.put_line ('running proc1');
   RAISE NO_DATA_FOUND;
END;
/

CREATE OR REPLACE PROCEDURE proc2
IS
   l_str   VARCHAR2 (30) := 'calling proc1';
BEGIN
   DBMS_OUTPUT.put_line (l_str);
   proc1;
END;
/

CREATE OR REPLACE PROCEDURE proc3
IS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc2');
   proc2;
END;
/

-- Without Back Trace....
-- The only way to "see" the line number on which the error was raised was to let the exception go unhandled.
BEGIN
   DBMS_OUTPUT.put_line ('Proc3 -> Proc2 -> Proc1 unhandled');
   proc3;
END;
/

-- Trap and Display Error Stack (Error Message)
-- Sure, that works fine and is very good info to have, but the error stack (error message) will contain the line number on which the error was raised!
BEGIN
   DBMS_OUTPUT.put_line ('Proc3 -> Proc2 -> Proc1 unhandled');
   proc3;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_stack);
END;
/

-- Add Back Trace to Error Handler
-- Now we trap the exception at the top level subprogram and view both the error stack and the back trace.
CREATE OR REPLACE PROCEDURE proc3
IS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc2');
   proc2;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line ('Error backtrace at top level:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_stack);
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
END;
/

BEGIN
   DBMS_OUTPUT.put_line ('Proc3 -> Proc2 -> Proc1 backtrace');
   proc3;
END;
/

-- Re-Raise Exception
-- I show the back trace, but then re-raise.
CREATE OR REPLACE PROCEDURE proc1
IS
BEGIN
   DBMS_OUTPUT.put_line ('running proc1');
   RAISE NO_DATA_FOUND;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line ('Error backtrace in block where raised:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
      RAISE;
END;
/

-- Can't Trace All the Way Back
-- The call to back trace in this upper-level subprogram no longer finds it way back to the line number of the original exception. That was wiped out with the call to RAISE;
CREATE OR REPLACE PROCEDURE proc3
IS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc2');
   proc2;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line ('Error backtrace at top level:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
END;
/

BEGIN
   DBMS_OUTPUT.put_line ('Proc3 -> Proc2 -> Proc1, re-reraise in Proc1');
   proc3;
END;
/

-- Handle and Raise At Every Level
-- And see how the back trace changes!
CREATE OR REPLACE PROCEDURE proc1
IS
BEGIN
   DBMS_OUTPUT.put_line ('running proc1');
   RAISE NO_DATA_FOUND;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line ('Error stack in block where raised:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
      RAISE;
END;
/

CREATE OR REPLACE PROCEDURE proc2
IS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc1');
   proc1;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE VALUE_ERROR;
END;
/

CREATE OR REPLACE PROCEDURE proc3
IS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc2');
   proc2;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line ('Error backtrace at top level:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
END;
/

BEGIN
   DBMS_OUTPUT.put_line
('Proc3 -> Proc2 -> Proc1, re-reraise in Proc1, raise VE in Proc2');
   proc3;
END;
/

/*
UTL_CALL_STACK, introduced in Oracle Database 12c, offers fine-grained access to
the execution call stack, error stack, and backtrace information. Prior to
UTL_CALL_STACK, developers used functions in DBMS_UTILITY to obtain this infromation:
FORMAT_CALL_STACK, FORMAT_ERROR_STACK, FORMAT_ERROR_BACKTRACE.
The my_utl_call_stack offers functions of the same name to replace those functions.
*/

CREATE OR REPLACE PACKAGE my_utl_call_stack
   AUTHID DEFINER
IS
   FUNCTION format_call_stack RETURN VARCHAR2;
   FUNCTION format_error_stack RETURN VARCHAR2;
   FUNCTION format_error_backtrace RETURN VARCHAR2;
   FUNCTION backtrace_to RETURN VARCHAR2;
END;
/

CREATE OR REPLACE PACKAGE BODY my_utl_call_stack
IS
   FUNCTION format_call_stack
      RETURN VARCHAR2
   IS
      l_return   VARCHAR2 (32767)
         :=    '----- PL/SQL Call Stack -------'
            || CHR (10)
            || 'Line     Object name'
            || CHR (10)
            || '-------- ----------------------';
BEGIN
      /* 1 is always this function, so ignore it. */
FOR indx IN 2 .. utl_call_stack.dynamic_depth
      LOOP
         l_return :=
               l_return
            || case when l_return is not null then CHR (10) end
            || LPAD (TO_CHAR (utl_call_stack.unit_line (indx)), 8)
            || ' '
            || utl_call_stack.owner (indx)
            || '.'
            || utl_call_stack.concatenate_subprogram (
                  utl_call_stack.subprogram (indx));
END LOOP;

RETURN l_return;
END;

   FUNCTION format_error_stack
      RETURN VARCHAR2
   IS
      l_return   VARCHAR2 (32767);
BEGIN
FOR indx IN 1 .. utl_call_stack.error_depth
      LOOP
         l_return :=
               l_return
            || case when l_return is not null then CHR (10) end
            || 'ORA-'
            || LPAD (TO_CHAR (utl_call_stack.error_number (indx)), 5, '0')
            || ': '
            || utl_call_stack.error_msg (indx);
END LOOP;

RETURN l_return;
END;

   FUNCTION format_error_backtrace
      RETURN VARCHAR2
   IS
      l_return   VARCHAR2 (32767);
BEGIN
FOR indx IN 1 .. utl_call_stack.backtrace_depth
      LOOP
         l_return :=
               l_return
            || case when l_return is not null then CHR (10) end
            || indx
            || ' -> '
            || utl_call_stack.backtrace_unit (indx)
            || ' - Line '
            || TO_CHAR (utl_call_stack.backtrace_line (indx));
END LOOP;

RETURN l_return;
EXCEPTION
      WHEN OTHERS
      THEN
         IF SQLCODE = -64610
         THEN
            /* ORA-64610: bad depth indicator */
            RETURN l_return;
ELSE
            RAISE;
END IF;
END;

   FUNCTION backtrace_to
      RETURN VARCHAR2
   IS
BEGIN
RETURN    utl_call_stack.backtrace_unit (1)
    || ' on line '
    || utl_call_stack.backtrace_line (1);
END;
END;
/

SET SERVEROUTPUT ON


CREATE OR REPLACE PROCEDURE p1
IS
   PROCEDURE nested_in_p1
   IS
BEGIN
      DBMS_OUTPUT.put_line ('Call Stack from DBMS_UTILITY');
      DBMS_OUTPUT.put_line ('-');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_call_stack);
      DBMS_OUTPUT.put_line ('-');
      DBMS_OUTPUT.put_line ('Call Stack from UTL_CALL_STACK');
      DBMS_OUTPUT.put_line ('-');
      DBMS_OUTPUT.put_line (my_utl_call_stack.format_call_stack);
      RAISE NO_DATA_FOUND;
END;
BEGIN
   nested_in_p1;
END;
/

CREATE OR REPLACE PACKAGE pkg
   AUTHID DEFINER
IS
   PROCEDURE p;
END;
/

CREATE OR REPLACE PACKAGE BODY pkg
IS
   PROCEDURE p
   IS
BEGIN
      p1;
END;
END;
/

CREATE OR REPLACE PROCEDURE p2
   AUTHID DEFINER
IS
BEGIN
   pkg.p;
END;
/

CREATE OR REPLACE PROCEDURE p3
   AUTHID DEFINER
IS
BEGIN
   p2;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line ('-');

      DBMS_OUTPUT.put_line ('Error Stack from DBMS_UTILTY');
      DBMS_OUTPUT.put_line ('-');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_stack);

      DBMS_OUTPUT.put_line ('Error Stack from UTL_CALL_STACK');
      DBMS_OUTPUT.put_line ('-');
      DBMS_OUTPUT.put_line (my_utl_call_stack.format_error_stack);

      DBMS_OUTPUT.put_line ('-');

      DBMS_OUTPUT.put_line ('Backtrace from DBMS_UTILITY');
      DBMS_OUTPUT.put_line ('-');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
      DBMS_OUTPUT.put_line ('-');
      DBMS_OUTPUT.put_line ('Backtrace from UTL_CALL_STACK');
      DBMS_OUTPUT.put_line ('-');
      DBMS_OUTPUT.put_line (my_utl_call_stack.format_error_backtrace);
      DBMS_OUTPUT.put_line ('-');
      DBMS_OUTPUT.put_line ('Backtrace to: ' || my_utl_call_stack.backtrace_to());
      RAISE;
END;
/

BEGIN
   p3;

/* Trapping the exception because if I do not, LiveSQL will not
   show the contents of the DBMS_OUTPUT buffer.
*/

EXCEPTION WHEN OTHERS
   THEN
      NULL;
END;
/

CREATE OR REPLACE PACKAGE dbms_errlog_helper
   AUTHID CURRENT_USER
/*
| File name: dbms_errlog_helper.sql
|
| Author: Steven Feuerstein, steven.feuerstein@oracle.com
|
| Overview: Run this program to create a database error log table
|   (via the DBMS_ERRLOG mechanism) so that you can log errors for
|   this table and continue processing DML statements. It will also
|   generate a helper package for the specified table that you can
|   use after running the DML statement(s) so you can easily view
|   and manage any errors that are raised. Finally, it automatically
|   adds audit columns created_by and created_on so you can keep
|   track of where and when the errors were added, and a trigger is
|   defined on the table to populate those columns.
|
| TO DO
|   * Execute grants on error log table so that anyone who can make
|     a change to the DML table can insert into the log table.
|
| Modification History:
|   Date        Who         What
|
| Dec 2008      SF          Stop creating the trigger with a static name.
|                           Instead, the name varies by the table name.
|                           Add option to clear error log after retrieval.
|
| Mar 2008      SF          Create audit columns, create trigger,
|                           change to AUTHID CURRENT_USER.
|
| Feb 2008      SF          Convert to package that offers ability
|                           to immediately compile package rather
|                           than return CLOBS.
|
| Oct 3 2007    SF          Carve out from q$error_manager to make it
|                           available as a stand-alone utility.
|
*/
IS
   PROCEDURE create_objects (dml_table_name           VARCHAR2
                           , err_log_table_name       VARCHAR2 DEFAULT NULL
                           , err_log_table_owner      VARCHAR2 DEFAULT NULL
                           , err_log_table_space      VARCHAR2 DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR2 DEFAULT NULL
                           , err_log_package_spec OUT DBMS_SQL.varchar2s
                           , err_log_package_body OUT DBMS_SQL.varchar2s
                            );

   PROCEDURE create_objects (dml_table_name           VARCHAR2
                           , err_log_table_name       VARCHAR2 DEFAULT NULL
                           , err_log_table_owner      VARCHAR2 DEFAULT NULL
                           , err_log_table_space      VARCHAR2 DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR2 DEFAULT NULL
                           , err_log_package_spec OUT VARCHAR2
                           , err_log_package_body OUT VARCHAR2
                            );

   PROCEDURE create_objects (dml_table_name        VARCHAR2
                           , err_log_table_name    VARCHAR2 DEFAULT NULL
                           , err_log_table_owner   VARCHAR2 DEFAULT NULL
                           , err_log_table_space   VARCHAR2 DEFAULT NULL
                           , skip_unsupported      BOOLEAN DEFAULT FALSE
                           , overwrite_log_table   BOOLEAN DEFAULT TRUE
                           , err_log_package_name  VARCHAR2 DEFAULT NULL
                            );
END dbms_errlog_helper;
/

-- Package Body
-- I love using dynamic SQL to perform tasks like this. Of course, you'd have to be very careful if this was running in production (and users could supply text), but this is a developer utility. So don't worry, be happy!
CREATE OR REPLACE PACKAGE BODY dbms_errlog_helper
IS
   /*
   | Overview: Run this program to create a database error log table
   |   (via the DBMS_ERRLOG mechanism) so that you can log errors for
   |   this table and continue processing DML statements. It will also
   |   generate a helper package for the specified table that you can
   |   use after running the DML statement(s) so you can easily view
   |   and manage any errors that are raised
   |
   | Author(s): Steven Feuerstein
   |
   | Modification History:
   |   Date        Who         What
   | Feb 2008      SF          Convert to package that offers ability
   |                           to immediately compile package rather
   |                           return CLOBS.A
   | Oct 3 2007    SF          Carve out from q$error_manager to make it
   |                           available as a stand-alone utility.
   |
   */

   SUBTYPE maxvarchar2_t IS VARCHAR2 (32767);

   PROCEDURE create_objects (dml_table_name           VARCHAR2
                           , err_log_table_name       VARCHAR2 DEFAULT NULL
                           , err_log_table_owner      VARCHAR2 DEFAULT NULL
                           , err_log_table_space      VARCHAR2 DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR2 DEFAULT NULL
                           , err_log_package_spec OUT DBMS_SQL.varchar2s
                           , err_log_package_body OUT DBMS_SQL.varchar2s
                            )
IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      c_package_name CONSTANT maxvarchar2_t
            := SUBSTR (NVL (err_log_package_name, 'ELP$_' || dml_table_name)
                     , 1
                     , 30
                      ) ;
      c_errlog_table_name CONSTANT maxvarchar2_t
            := SUBSTR (NVL (err_log_table_name, 'ERR$_' || dml_table_name)
                     , 1
                     , 30
                      ) ;
      c_qual_errlog_table_name CONSTANT maxvarchar2_t
            := CASE
                  WHEN err_log_table_owner IS NULL THEN NULL
                  ELSE err_log_table_owner || '.'
END
|| c_errlog_table_name ;
      l_spec   DBMS_SQL.varchar2s;
      l_body   DBMS_SQL.varchar2s;

      PROCEDURE create_error_log
IS
BEGIN
         IF overwrite_log_table
         THEN
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ' || c_qual_errlog_table_name;
EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
END;
END IF;

         /*
         Create the error log; any errors raised by this program will
         terminate the rest of the processing of this helper program.
         */
         DBMS_ERRLOG.create_error_log (
            dml_table_name        => dml_table_name
          , err_log_table_name    => err_log_table_name
          , err_log_table_owner   => err_log_table_owner
          , err_log_table_space   => err_log_table_space
          , skip_unsupported      => skip_unsupported
         );

         /* Alter the error log table to add audit columns. */
EXECUTE IMMEDIATE 'ALTER TABLE ' || NVL (err_log_table_owner, USER)
    || '.' || c_errlog_table_name || ' ADD created_by VARCHAR2(30)';

EXECUTE IMMEDIATE 'ALTER TABLE ' || NVL (err_log_table_owner, USER)
    || '.' || c_errlog_table_name || ' ADD created_on DATE';

/* Add Call Stack: Thanks, IFMC! */
EXECUTE IMMEDIATE 'ALTER TABLE ' || NVL (err_log_table_owner, USER)
    || '.' || c_errlog_table_name || ' ADD call_stack VARCHAR2(4000)';

/* Add the trigger to update these columns. */
EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER '
    || SUBSTR (dml_table_name || '$BEF_EL', 1, 30)
    || ' BEFORE INSERT OR UPDATE ON ' || NVL (err_log_table_owner, USER)
    || '.' || c_errlog_table_name || ' FOR EACH ROW BEGIN :NEW.created_by := USER; '
    || ' :NEW.created_on := SYSDATE; ' || ' :NEW.call_stack := '
    || 'SUBSTR (dbms_utility.Format_call_stack (), 1, 4000); END;';
END create_error_log;

      PROCEDURE generate_spec (package_name_in IN     VARCHAR2
                             , code_out           OUT DBMS_SQL.varchar2s
                              )
IS
         PROCEDURE add_line (line_in IN VARCHAR2)
         IS
BEGIN
            l_spec (l_spec.COUNT + 1) := line_in;
END add_line;
BEGIN
         add_line ('CREATE OR REPLACE PACKAGE ' || c_package_name || ' IS ');
         add_line(   'SUBTYPE error_log_r IS '
                  || c_qual_errlog_table_name
                  || '%ROWTYPE;');
         add_line(   'TYPE error_log_tc IS TABLE OF '
                  || c_qual_errlog_table_name
                  || '%ROWTYPE;');
         add_line ('PROCEDURE clear_error_log;');
         add_line ('FUNCTION error_log_contents (');
         add_line ('  ORA_ERR_NUMBER$_IN IN PLS_INTEGER DEFAULT NULL');
         add_line (', ORA_ERR_OPTYP$_IN IN VARCHAR2 DEFAULT NULL');
         add_line (', ORA_ERR_TAG$_IN IN VARCHAR2 DEFAULT NULL');
         add_line (', where_in IN VARCHAR2 DEFAULT NULL');
         add_line (', preserve_log_in IN BOOLEAN DEFAULT TRUE');
         add_line (') RETURN error_log_tc;');
         -- add_line ('PROCEDURE dump_error_log;');
         add_line ('END ' || c_package_name || ';');
         code_out := l_spec;
END generate_spec;

      PROCEDURE generate_body (package_name_in IN     VARCHAR2
                             , code_out           OUT DBMS_SQL.varchar2s
                              )
IS
         PROCEDURE add_line (line_in IN VARCHAR2)
         IS
BEGIN
            l_body (l_body.COUNT + 1) := line_in;
END add_line;
BEGIN
         add_line (
            'CREATE OR REPLACE PACKAGE BODY ' || c_package_name || ' IS '
         );
         add_line ('PROCEDURE clear_error_log');
         add_line ('IS PRAGMA AUTONOMOUS_TRANSACTION; BEGIN ');
         add_line ('DELETE FROM ' || c_qual_errlog_table_name || '; COMMIT;');
         add_line ('END clear_error_log;');
         add_line ('FUNCTION error_log_contents (');
         add_line ('  ORA_ERR_NUMBER$_IN IN PLS_INTEGER DEFAULT NULL');
         add_line (', ORA_ERR_OPTYP$_IN IN VARCHAR2 DEFAULT NULL');
         add_line (', ORA_ERR_TAG$_IN IN VARCHAR2 DEFAULT NULL');
         add_line (', where_in IN VARCHAR2 DEFAULT NULL');
         add_line (', preserve_log_in IN BOOLEAN DEFAULT TRUE');
         add_line (') RETURN error_log_tc');
         add_line (' IS ');
         add_line('l_query      VARCHAR2 (32767)
         :=    ''SELECT * FROM '
                  || c_qual_errlog_table_name
                  || ' WHERE ( ora_err_number$ LIKE :ora_err_number$_in
              OR :ora_err_number$_in IS NULL');
         add_line(') AND (   ora_err_optyp$ LIKE :ora_err_optyp$_in
              OR :ora_err_optyp$_in IS NULL )');
         add_line('AND (ora_err_tag$ LIKE :ora_err_tag$_in OR :ora_err_tag$_in IS NULL)''
            || CASE WHEN where_in IS NULL');
         add_line('THEN NULL ELSE '' AND '' || REPLACE (where_in, '''''''', '''''''''''') END;
      l_log_rows   error_log_tc;');
         add_line (
            'BEGIN EXECUTE IMMEDIATE l_query BULK COLLECT INTO l_log_rows'
         );
         add_line('USING ORA_ERR_NUMBER$_IN, ORA_ERR_NUMBER$_IN,
               ORA_ERR_OPTYP$_IN, ORA_ERR_OPTYP$_IN,
               ORA_ERR_TAG$_IN, ORA_ERR_TAG$_IN; RETURN l_log_rows;');
         add_line ('IF NOT preserve_log_in THEN clear_error_log(); END IF;');
         add_line('EXCEPTION WHEN OTHERS THEN
         DBMS_OUTPUT.put_line (''Error retrieving log contents for :'');
         DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_stack);
         DBMS_OUTPUT.put_line (l_query);
         RAISE;');
         add_line ('END error_log_contents; END ' || c_package_name || ';');
         code_out := l_body;
END generate_body;
BEGIN
      create_error_log;
      generate_spec (c_package_name, err_log_package_spec);
      generate_body (c_package_name, err_log_package_body);
END create_objects;

   PROCEDURE create_objects (dml_table_name           VARCHAR2
                           , err_log_table_name       VARCHAR2 DEFAULT NULL
                           , err_log_table_owner      VARCHAR2 DEFAULT NULL
                           , err_log_table_space      VARCHAR2 DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR2 DEFAULT NULL
                           , err_log_package_spec OUT VARCHAR2
                           , err_log_package_body OUT VARCHAR2
                            )
IS
      l_spec          DBMS_SQL.varchar2s;
      l_body          DBMS_SQL.varchar2s;
      l_spec_string   maxvarchar2_t;
      l_body_string   maxvarchar2_t;
BEGIN
      create_objects (dml_table_name         => dml_table_name
                    , err_log_table_name     => err_log_table_name
                    , err_log_table_owner    => err_log_table_owner
                    , err_log_table_space    => err_log_table_space
                    , skip_unsupported       => skip_unsupported
                    , overwrite_log_table    => overwrite_log_table
                    , err_log_package_name   => err_log_package_name
                    , err_log_package_spec   => l_spec
                    , err_log_package_body   => l_body
                     );

FOR indx IN 1 .. l_spec.COUNT
      LOOP
         l_spec_string :=
            CASE
               WHEN indx = 1 THEN l_spec (indx)
               ELSE l_spec_string || CHR (10) || l_spec (indx)
END;
END LOOP;

FOR indx IN 1 .. l_body.COUNT
      LOOP
         l_body_string :=
            CASE
               WHEN indx = 1 THEN l_body (indx)
               ELSE l_body_string || CHR (10) || l_body (indx)
END;
END LOOP;

      err_log_package_spec := l_spec_string;
      err_log_package_body := l_body_string;
END create_objects;

   PROCEDURE create_objects (dml_table_name        VARCHAR2
                           , err_log_table_name    VARCHAR2 DEFAULT NULL
                           , err_log_table_owner   VARCHAR2 DEFAULT NULL
                           , err_log_table_space   VARCHAR2 DEFAULT NULL
                           , skip_unsupported      BOOLEAN DEFAULT FALSE
                           , overwrite_log_table   BOOLEAN DEFAULT TRUE
                           , err_log_package_name  VARCHAR2 DEFAULT NULL
                            )
IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      l_spec   DBMS_SQL.varchar2s;
      l_body   DBMS_SQL.varchar2s;

      PROCEDURE compile_statement (array_in IN DBMS_SQL.varchar2s)
IS
         l_cur   PLS_INTEGER := DBMS_SQL.open_cursor;
BEGIN
         DBMS_SQL.parse (l_cur
                       , array_in
                       , 1
                       , array_in.COUNT
                       , TRUE
                       , DBMS_SQL.native
                        );
         DBMS_SQL.close_cursor (l_cur);
END compile_statement;
BEGIN
      create_objects (dml_table_name         => dml_table_name
                    , err_log_table_name     => err_log_table_name
                    , err_log_table_owner    => err_log_table_owner
                    , err_log_table_space    => err_log_table_space
                    , skip_unsupported       => skip_unsupported
                    , overwrite_log_table    => overwrite_log_table
                    , err_log_package_name   => err_log_package_name
                    , err_log_package_spec   => l_spec
                    , err_log_package_body   => l_body
                     );
      compile_statement (l_spec);
      compile_statement (l_body);
EXCEPTION
      WHEN OTHERS THEN dbms_output.put_line (dbms_utility.format_error_backtrace); raise;
END create_objects;
END dbms_errlog_helper;