/*Found error(s) in file while parsing
Error at line 3:25 - mismatched input '(' expecting ';'
Error at line 9:0 - mismatched input '/' expecting ';'
Error at line 16:19 - no viable alternative at input 'l_limbs MULTISET'
Error at line 15:19 - no viable alternative at input 'l_limbs MULTISET'
Error at line 16:19 - no viable alternative at input 'l_limbs MULTISET'
Error at line 14:19 - no viable alternative at input 'l_limbs MULTISET'
Error at line 12:0 - mismatched input '/' expecting ';'
Error at line 19:19 - no viable alternative at input 'l_limbs MULTISET'
Error at line 14:19 - no viable alternative at input 'l_limbs MULTISET'
Error at line 16:19 - no viable alternative at input 'l_limbs MULTISET'
Error at line 16:19 - no viable alternative at input 'l_limbs MULTISET'
Error at line 40:9 - no viable alternative at input 'tab_1.EXTEND'
Error at line 13:0 - mismatched input '/' expecting ';'
Error at line 6:4 - mismatched input '/' expecting ';'
Error at line 18:10 - no viable alternative at input 'retval.EXTEND'
Error at line 13:0 - mismatched input '/' expecting ';'
Error at line 8:33 - no viable alternative at input 'authors_pkg.steven_authors MULTISET'
Error at line 6:0 - mismatched input 'CREATE' expecting ';'
*/


/*
This very, VERY basic error logging package demonstrations the critical elements: use an autonomous
transaction to write a row to the error log; call the full suite of error-related built-in functions
to gather all generic information; pass in application-specific data for logging.
*/

-- Error Logging Table
CREATE EXCEPTION NO_DATA_FOUND
	'no data found';
CREATE TABLE error_log
(
    log_id       NUMERIC(18, 4) GENERATED ALWAYS AS IDENTITY,
    created_on   TIMESTAMP WITH LOCAL TIME ZONE,
    created_by   VARCHAR (100),
    errorcode    INTEGER,
    callstack    VARCHAR (4000),
    errorstack   VARCHAR (4000),
    backtrace    VARCHAR (4000),
    error_info   VARCHAR (4000)
);


CREATE OR ALTER PACKAGE 
AS BEGIN 
   failure_in_forall   EXCEPTION; 
/*
Error at line 3:25 - mismatched input '(' expecting ';'
 

   PRAGMA EXCEPTION_INIT (failure_in_forall, -24381); 
*/ 

   PROCEDURE log_error (app_info_in  VARCHAR(32000));  
  END;
/


SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN 
   PROCEDURE log_error (app_info_in  VARCHAR(32000))
   AS
      
      /* Cannot call this function directly in SQL */
      DECLARE c_code   CONSTANT INTEGER = SQLCODE;
BEGIN
IN AUTONOMOUS TRANSACTION DO BEGIN
INSERT INTO error_log (created_on,
                       created_by,
                       errorcode,
                       callstack,
                       errorstack,
                       backtrace,
                       error_info)
VALUES (CURRENT_TIMESTAMP,
        USER,
        :c_code,
        DBMS_UTILITY.format_call_stack,
        DBMS_UTILITY.format_error_stack,
        DBMS_UTILITY.format_error_backtrace,
        :app_info_in);

COMMIT;
	END
END  
  END;

SET TERM ; ^
/

-- Try it Out
DECLARE
DECLARE l_company_id   INTEGER;
BEGIN
   IF (l_company_id IS NULL)
   THEN
      RAISE VALUE_ERROR;
EXCEPTION
   WHEN OTHERS
   DOBEGIN
	      error_mgr.log_error ('Company ID is NULL - not allowed.');
      ENDEND;
/

SELECT backtrace, errorstack, callstack FROM error_log;


BEGIN
FOR rec IN (  SELECT *
                   FROM endangered_species
               ORDER BY common_name)
DO
BEGIN
      DBMS_OUTPUT.put_line (rec.common_name);
END
END;
/

-- Cursor FOR Loop with Explicit Cursor
/*
As mentioned above, you can declare the cursor once, then use it
multiple times. Here, in two different cursor FOR loops.
*/

DECLARE
DECLARE species_cur
   CURSOR FOR
(SELECT *
FROM endangered_species
ORDER BY common_name);

PROCEDURE start_conservation_effort
AS
BEGIN
      DBMS_OUTPUT.put_line ('Remove human presence');
END
BEGIN
OPEN SPECIES_CUR;
FETCH SPECIES_CUR INTO SPECIES_CUR_REC;
WHILE ( ROW_COUNT != 0 ) DO
BEGIN
      DBMS_OUTPUT.put_line (SPECIES_CUR_REC.common_name);
	FETCH SPECIES_CUR INTO SPECIES_CUR_REC;
END
CLOSE SPECIES_CUR;

OPEN SPECIES_CUR;
FETCH SPECIES_CUR INTO SPECIES_CUR_REC;
WHILE ( ROW_COUNT != 0 ) DO
BEGIN
      EXECUTE PROCEDURE start_conservation_effort;
	FETCH SPECIES_CUR INTO SPECIES_CUR_REC;
END
CLOSE SPECIES_CUR;

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
    nm        VARCHAR (100),
    avg_len   NUMERIC(18, 4)
);

BEGIN
INSERT INTO limbs VALUES ('arm', 1);

INSERT INTO limbs VALUES ('leg', 2);

INSERT INTO limbs VALUES ('tail', 3);

COMMIT;
END;
/
/*
Error at line 9:0 - mismatched input '/' expecting ';'


CREATE OR REPLACE TYPE limb_ot AUTHID DEFINER
   IS OBJECT
(
   nm VARCHAR2 (100),
   avg_len NUMBER
)
/
*/
/*
Error at line 16:19 - no viable alternative at input 'l_limbs MULTISET'


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
*/
/
/*
Error at line 15:19 - no viable alternative at input 'l_limbs MULTISET'


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
*/
/
/*
Error at line 16:19 - no viable alternative at input 'l_limbs MULTISET'


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
*/
/
/*
Error at line 14:19 - no viable alternative at input 'l_limbs MULTISET'


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
*/
/
/*
Error at line 12:0 - mismatched input '/' expecting ';'


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
*/

-- It's a silly mapping algorithm - only looks at the length of the name.
-- When you create your map method, make sure it reflects the logic of your data.
CREATE OR REPLACE TYPE BODY limb_ot
IS
   MAP MEMBER FUNCTION limb_map
      RETURN NUMERIC(18, 4)
   IS
BEGIN
RETURN CHAR_LENGTH (self.nm);
END;
END;
/
/*
Error at line 19:19 - no viable alternative at input 'l_limbs MULTISET'


-- Now UNION DISTINCT Works

With the map method in place, MULTISET operations that require comparisons
now work. But wait - only 2 elements in the resulting UNION DISTINCT? But all
three rows are distinct - what's going on? Hint: see mapping algorithm.


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
*/
/
/*
Error at line 14:19 - no viable alternative at input 'l_limbs MULTISET'


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
*/
/
/*
Error at line 16:19 - no viable alternative at input 'l_limbs MULTISET'


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
*/
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
      RETURN NUMERIC(18, 4)
   IS
BEGIN
RETURN CHAR_LENGTH (self.nm) + self.avg_len;
END;
END;
/
/*
Error at line 16:19 - no viable alternative at input 'l_limbs MULTISET'


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
*/
/
/*
Error at line 40:9 - no viable alternative at input 'tab_1.EXTEND'



One of the nicest things about nested tables is that you can compare two
such collections for equality using nothing more than...the equality operator!

Key things to remember: order of elements is not significant; if the collections
have different numbers of elements, "=" returns FALSE; if they have the same
number of elements, but at least one of the values in either collection is NULL,
"=" returns NULL; two initialized, but empty collections are equal.


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
*/
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
   NAME         VARCHAR (100)
 , food_group   VARCHAR (100)
 , grown_in     VARCHAR (100)
 ,
   -- Generic foods cannot have a price, but we can
   -- insist that all subtypes DO implement a price
   -- function.
   NOT INSTANTIABLE MEMBER FUNCTION price
      RETURN NUMERIC(18, 4)
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
 , year_created         NUMERIC (4)
 , OVERRIDING MEMBER FUNCTION price
      RETURN NUMERIC(18, 4)
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
      RETURN NUMERIC(18, 4)
   IS
      DECLARE multiplier   NUMERIC(18, 4) = 1;
BEGIN
      DBMS_OUTPUT.put_line ('Dessert price!');

      IF (SELF.contains_chocolate = 'Y')
      THEN
         multiplier = 2;

      IF (SELF.year_created < 1900)
      THEN
         multiplier = multiplier + 0.5;

RETURN (10.00 * multiplier);
END;
END;
/
/*
Error at line 13:0 - mismatched input '/' expecting ';'


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
*/

-- Cake-Specific Price Function
-- Cakes often have messages on their surface - an inscription - and you pay by the letter.
CREATE OR REPLACE TYPE BODY cake_t
IS
   OVERRIDING MEMBER FUNCTION price
      RETURN NUMERIC(18, 4)
   IS
BEGIN
      DBMS_OUTPUT.put_line ('Cake price!');
RETURN  (  5.00                                             -- base price
    + 0.25 * (CHAR_LENGTH (SELF.inscription))          -- $.25 per letter
    + 0.50 * diameter
    );
END;
END;
/

-- Can I Declare a Food Variable?
-- No! The type is NOT INSTANTIABLE, so this attempt fails.
DECLARE
DECLARE my_favorite_vegetable   food_t
                           = food_t ('Brussel Sprouts', 'VEGETABLE', 'farm');
BEGIN
   DBMS_OUTPUT.put_line (my_favorite_vegetable.price);
END;
/

DECLARE
DECLARE last_resort_dessert   dessert_t
                         = dessert_t ('Jello', 'PROTEIN', 'bowl', 'N', 1887);
   DECLARE heavenly_cake         cake_t
      = cake_t ('Marzepan Delight'
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
/*TYPE foodstuffs_nt IS TABLE OF food_t;*/

   DECLARE fridge_contents   foodstuffs_nt
      = foodstuffs_nt (dessert_t ('Strawberries and cream'
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
indx = fridge_contents.FIRST;
WHILE ( indx <= fridge_contents.LAST) DO
BEGIN
      DBMS_OUTPUT.put_line (   'Price of '
                            || fridge_contents (:indx).NAME
                            || ' = '
                            || fridge_contents (:indx).price
                           );
indx = indx + 1;
END
END;
/
/*
Error at line 6:4 - mismatched input '/' expecting ';'


-- Store Object Type Instances in Tables
-- You can create relational tables with columns whose types are object types. And substitutability works here too!
CREATE TABLE food_tab (food food_t)
    /
*/

-- Cakes and Desserts are Foods
-- So I can insert them into the table.
DECLARE
DECLARE s_and_c    dessert_t
                 = dessert_t ('Strawberries and cream',
                               'FRUIT',
                               'Backyard',
                               'N',
                               2001);
   DECLARE choc_sup   cake_t
                 = cake_t ('Chocolate Supreme',
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
DECLARE species_cur
   CURSOR FOR
(SELECT *
FROM endangered_species
ORDER BY common_name);

PROCEDURE start_conservation_effort
AS

  DECLARE VARIABLE SPECIES_CUR_REC TYPE OF TABLE SPECIES_CUR;

  DECLARE VARIABLE indx INTEGER;
BEGIN
      DBMS_OUTPUT.put_line ('Remove human presence');
END
BEGIN
OPEN SPECIES_CUR;
FETCH SPECIES_CUR INTO SPECIES_CUR_REC;
WHILE ( ROW_COUNT != 0 ) DO
BEGIN
      DBMS_OUTPUT.put_line (SPECIES_CUR_REC.common_name);
	FETCH SPECIES_CUR INTO SPECIES_CUR_REC;
END
CLOSE SPECIES_CUR;

OPEN SPECIES_CUR;
FETCH SPECIES_CUR INTO SPECIES_CUR_REC;
WHILE ( ROW_COUNT != 0 ) DO
BEGIN
      EXECUTE PROCEDURE start_conservation_effort;
	FETCH SPECIES_CUR INTO SPECIES_CUR_REC;
END
CLOSE SPECIES_CUR;

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

CREATE OR REPLACE TYPE names_nt IS TABLE OF VARCHAR ( 1000 );
/
/*
Error at line 18:10 - no viable alternative at input 'retval.EXTEND'


-- Silly Dataset Generator

I need to generated N number of names. Here's a function that does it.
It's a silly example. I can do this in SQL, too, but it demonstrates the ability
to programmatically (procedurally) populate a collection.


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
*/
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
FROM employees, TABLE ( lotsa_names ( 'Steven', 10 )) names ;

-- Return Cursor Variable to Dataset
/*
Here's an example of calling the table function, converting to a SQL dataset,
assigning it to a cursor variable, and then returning that via the function.
This function could then be invoked from a host environment, say a Java program,
and the data will be consumed. That Java or UI developer will have no idea
how the data set was constructed, and why should they care?
*/

SET TERM ^ ;

CREATE OR ALTER FUNCTION lotsa_names_cv (
   base_name_in      VARCHAR(32000)
 , count_in          INTEGER
)
   RETURNS sys_refcursor
AS
   DECLARE retval sys_refcursor;

  DECLARE VARIABLE SPECIES_CUR_REC TYPE OF TABLE SPECIES_CUR;
BEGIN
OPEN :retval FOR
SELECT COLUMN_VALUE
FROM TABLE ( lotsa_names ( :base_name_in, :count_in )) names;

RETURN retval;
END /*lotsa_names_cv*/^

SET TERM ; ^
/

DECLARE
DECLARE l_names_cur sys_refcursor;
   DECLARE l_name VARCHAR ( 32767 );
BEGIN
   l_names_cur = lotsa_names_cv ( 'Steven', 100 );

   WHILE (TRUE) DO BEGIN
FETCH l_names_cur INTO l_name;

        IF( ROW_COUNT != 1 ) BEGIN LEAVE END;
      DBMS_OUTPUT.put_line ( 'Name = ' || l_name );
END 

CLOSE l_names_cur;
END;
/
/*
Error at line 13:0 - mismatched input '/' expecting ';'






Use MULTISET UNION to perform set-level union operations on nested tables.
Remember: with MULTISET, ALL is the default, not DISTINCT (the opposite
holds true with SQL UNION).


CREATE OR REPLACE TYPE strings_nt IS TABLE OF VARCHAR2 (1000)
/
*/


CREATE OR ALTER PACKAGE 
AS BEGIN 
   DECLARE steven_authors   strings_nt;  
   DECLARE veva_authors     strings_nt;  
   DECLARE eli_authors      strings_nt;  

   PROCEDURE show_authors (title_in  VARCHAR(32000), authors_in  strings_nt);  

   DECLARE PROCEDURE init_authors;  
  END;
/


SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN 
   PROCEDURE show_authors (title_in  VARCHAR(32000), authors_in  strings_nt)
   AS

  DECLARE VARIABLE indx INTEGER;
BEGIN
      DBMS_OUTPUT.put_line (:title_in);

indx = 1;
WHILE ( indx <= authors_in.COUNT) DO
BEGIN
         DBMS_OUTPUT.put_line (:indx || ' = ' || :authors_in (:indx));
indx = indx + 1;
END
END /*show_authors*/  

   PROCEDURE init_authors
AS
BEGIN
      steven_authors =
         strings_nt ('ROBIN HOBB'
                   , 'ROBERT HARRIS'
                   , 'DAVID BRIN'
                   , 'SHERI S. TEPPER'
                   , 'CHRISTOPHER ALEXANDER'
                   , 'PIERS ANTHONY');
      veva_authors =
         strings_nt ('ROBIN HOBB', 'SHERI S. TEPPER', 'ANNE MCCAFFREY');

      eli_authors =
         strings_nt ('PIERS ANTHONY', 'SHERI S. TEPPER', 'DAVID BRIN');
END  
  END;

SET TERM ; ^
/
/*
Error at line 8:33 - no viable alternative at input 'authors_pkg.steven_authors MULTISET'


DECLARE
our_authors   strings_nt;
BEGIN
   authors_pkg.init_authors;
   our_authors :=
      authors_pkg.steven_authors MULTISET UNION authors_pkg.veva_authors;

   authors_pkg.show_authors ('Steven and Veva', our_authors);

    Use MULTISET UNION inside SQL 
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
*/
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
SELECT * FROM employees;

-- Silly Little Helper Function
/*
This is dynamic SQL method 3, by the way: a SELECT with fixed number of bind
variables and/or SELECT list elements (INTO clause). We take basic steps to
guard against SQL injection with the DBMS_ASSERT package. But there is still
a GAPING HOLE with the WHERE clause. Thus, this program should never be callable
directly by a user, with un-checked user input.
*/

SET TERM ^ ;

CREATE OR ALTER FUNCTION table_count (
   table_name_in    TYPE OF COLUMN all_tables.table_name,
   where_in         VARCHAR(32000) DEFAULT NULL)
   RETURNS PLS_INTEGER
   AUTHID CURRENT_USER
AS
   DECLARE l_table_name   TYPE OF COLUMN all_tables.table_name;
   DECLARE l_return       PLS_INTEGER;
BEGIN
   l_table_name = sys.DBMS_ASSERT.sql_object_name (:table_name_in);
EXECUTE STATEMENT
    ('SELECT COUNT(*) FROM ' || :table_name_in || ' WHERE ' || :where_in)
     INTO :l_return;

RETURN l_return;
END^

SET TERM ; ^
/

-- Can't Bind Column Names
/*
First of all, remember: you can only bind variable values. You cannot bind parts
of the SQL statement that are needed at the time the statement is parsed, such
as the table name, column name, where clause, etc. This code will compile, but fail to run.
*/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE set_to_10000 (col_in              VARCHAR(32000),
                                          department_id_in    PLS_INTEGER)
AS
   DECLARE l_update CONSTANT VARCHAR (1000) =
      'UPDATE employees SET :colname = 10000
        WHERE department_id = :dept';
BEGIN
EXECUTE STATEMENT (:l_update) USING :col_in, :department_id_in;

DBMS_OUTPUT.put_line ('Rows updated: ' || CAST (SQL%ROWCOUNT));
END^

SET TERM ; ^
/

-- Can't Bind Column Names - In Action
BEGIN
   EXECUTE PROCEDURE set_to_10000 ('salary', 50);
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

SET TERM ^ ;

CREATE OR ALTER PROCEDURE set_to_10000 (col_in              VARCHAR(32000),
                                          department_id_in    PLS_INTEGER)
AS
   DECLARE l_update   VARCHAR (1000)
      =    'UPDATE employees SET '
         || :col_in
         || ' = 10000
        WHERE department_id = :dept';
BEGIN
EXECUTE STATEMENT (:l_update) USING :department_id_in;

DBMS_OUTPUT.put_line ('Rows updated: ' || CAST (SQL%ROWCOUNT));
END^

SET TERM ; ^
/

BEGIN
   DBMS_OUTPUT.put_line (
         'Before '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));

   EXECUTE PROCEDURE set_to_10000 ('salary', 50);

   DBMS_OUTPUT.put_line (
         'After '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));
ROLLBACK;
END;
/

-- Multiple Placeholders, Different Names
-- I have two placeholders with different names. I therefore have two expressions in the USING clause.
SET TERM ^ ;

CREATE OR ALTER PROCEDURE updnumval (col_in              VARCHAR(32000),
                                       department_id_in    PLS_INTEGER,
                                       val_in              NUMERIC(18, 4))
AS
   DECLARE l_update   VARCHAR (1000)
      =    'UPDATE employees SET '
         || :col_in
         || ' = :val
        WHERE department_id = :dept';
BEGIN
EXECUTE STATEMENT (:l_update) USING :val_in, :department_id_in;

DBMS_OUTPUT.put_line ('Rows updated: ' || CAST (SQL%ROWCOUNT));
END^

SET TERM ; ^
/

BEGIN
   DBMS_OUTPUT.put_line (
         'Before '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));

   EXECUTE PROCEDURE updnumval ('salary', 50, 10000);

   DBMS_OUTPUT.put_line (
         'After '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));
ROLLBACK;
END;
/

-- Three Placeholders, Repeating Names
-- Now I have three placeholders and the name "val" is used twice. When I execute a dynamic SQL statement, I must have an expression in the USING clause for each placeholder - by position, not name. So you see three variables, including val_in twice. Of course, I could use a different expression for the second "val" placeholder. They are NOT connected by name.
SET TERM ^ ;

CREATE OR ALTER PROCEDURE updnumval (col_in              VARCHAR(32000),
                                       department_id_in    PLS_INTEGER,
                                       val_in              NUMERIC(18, 4))
AS
   DECLARE l_update   VARCHAR (1000)
      =    'UPDATE employees SET '
         || :col_in
         || ' = :val
        WHERE department_id = :dept and :val IS NOT NULL';
BEGIN
EXECUTE STATEMENT (:l_update) USING :val_in, :department_id_in, :val_in;

DBMS_OUTPUT.put_line ('Rows updated: ' || CAST (SQL%ROWCOUNT));
END^

SET TERM ; ^
/

BEGIN
   DBMS_OUTPUT.put_line (
         'Before '
      || table_count ('employees',
                      'department_id = 50 AND salary = 10000'));

   EXECUTE PROCEDURE updnumval ('salary', 50, 10000);

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

CREATE GLOBAL TEMPORARY TABLE L_COLUMNS (
	I1 PLS_INTEGER,
	VAL TYPE OF TABLE all_tab_columns,
	CONSTRAINT PK_L_COLUMNS PRIMARY KEY (I1)
);

SET TERM ^ ;

CREATE OR ALTER PROCEDURE intab (table_in           VARCHAR(32000),
                                   where_in           VARCHAR(32000) DEFAULT NULL,
                                   colname_like_in    VARCHAR(32000) = '%')
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
AS
   -- Avoid repetitive "maximum size" declarations for VARCHAR2 variables.
   SUBTYPE max_varchar2_t IS VARCHAR (32767);

   -- Minimize size of a string column.
   DECLARE c_min_length   CONSTANT PLS_INTEGER = 10;

   -- Collection to hold the column information for this table.
   /*TYPE columns_tt IS TABLE OF TYPE OF TABLE all_tab_columns
      INDEX BY PLS_INTEGER;*/

   /*l_columns               columns_tt;*/
   -- Open a cursor for use by DBMS_SQL subprograms throughout this procedure.
   DECLARE l_cursor                INTEGER;
   --
   -- Formatting and SELECT elements used throughout the program.
   DECLARE l_header                max_varchar2_t;
   DECLARE l_select_list           max_varchar2_t;
   DECLARE g_row_line_length       INTEGER = 0;

   /* Utility functions that determine the "family" of the column datatype.
   They do NOT comprehensively cover the datatypes supported by Oracle.
   You will need to expand on these programs if you want your version of
   intab to support a wider range of datatypes.
   */

   FUNCTION is_string (columns_in  columns_tt, row_in  INTEGER)
      RETURNS BOOLEAN
   AS
BEGIN
RETURN (:columns_in (:row_in).data_type IN ('CHAR', 'VARCHAR2', 'VARCHAR'));
END

   FUNCTION is_number (columns_in  columns_tt, row_in  INTEGER)
      RETURNS BOOLEAN
   AS
BEGIN
RETURN (:columns_in (:row_in).data_type IN ('FLOAT', 'INTEGER', 'NUMBER'));
END

   FUNCTION is_date (columns_in  columns_tt, row_in  INTEGER)
      RETURNS BOOLEAN
   AS
BEGIN
RETURN (:columns_in (:row_in).data_type IN ('DATE', 'TIMESTAMP'));
END

   PROCEDURE load_column_information (
      select_list_io      VARCHAR(32000),
      header_io           VARCHAR(32000),
      columns_io          columns_tt)
RETURNS( SELECT_LIST_IO_OUT VARCHAR(32000), 
HEADER_IO_OUT VARCHAR(32000), 
COLUMNS_IO_OUT columns_tt)

AS
      DECLARE l_dot_location   PLS_INTEGER;
      DECLARE l_owner          VARCHAR (100);
      DECLARE l_table          VARCHAR (100);
      DECLARE l_index          PLS_INTEGER;
      --
      no_such_table    EXCEPTION;
      
BEGIN
      -- Separate the schema and table names, if both are present.
      l_dot_location = POSITION ('.', table_in);

      IF (:l_dot_location > 0)
      THEN
      BEGIN
         l_owner = SUBSTRING (:table_in FROM  1 FOR  :l_dot_location - 1);
         l_table = SUBSTRING (:table_in FROM  :l_dot_location + 1);
      END
ELSE
BEGIN
         l_owner = USER;
         l_table = :table_in;
END

      -- Retrieve all the column information into a collection of records.

SELECT *
FROM all_tab_columns
WHERE     owner = :l_owner
  AND table_name = :l_table
  AND column_name LIKE COALESCE (:colname_like_in, '%')
BULK COLLECT INTO :columns_io;
IF (ROW_COUNT = 0) THEN
	EXCEPTION NO_DATA_FOUND;

l_index = columns_io.FIRST;

      IF (:l_index IS NULL)
      THEN
         RAISE no_such_table;
ELSE
         /* Add each column to the select list, calculate the length needed
         to display each column, and also come up with the total line length.
         Again, please note that the datatype support here is quite limited.
         */

         WHILE ((:l_index IS NOT NULL)) DO
         BEGIN
            IF (:select_list_io IS NULL)
            THEN
               select_list_io = :columns_io (:l_index).column_name;
ELSE
               select_list_io =
                  :select_list_io || ', ' || :columns_io (:l_index).column_name;

            IF (is_string (:columns_io, :l_index))
            THEN
               columns_io (:l_index).data_length =
                  GREATEST (
                     LEAST (:columns_io (:l_index).data_length, :c_min_length),
                     CHAR_LENGTH (:columns_io (:l_index).column_name));
            ELSE IF (is_date (:columns_io, :l_index))
            THEN
               columns_io (:l_index).data_length =
                  GREATEST (:c_min_length,
                            CHAR_LENGTH (:columns_io (:l_index).column_name));
            ELSE IF (is_number (:columns_io, :l_index))
            THEN
               columns_io (:l_index).data_length =
                  GREATEST (COALESCE (:columns_io (:l_index).data_precision, 38),
                            CHAR_LENGTH (:columns_io (:l_index).column_name));

            g_row_line_length =
               :g_row_line_length + :columns_io (:l_index).data_length + 1;
            --
            -- Construct column header line incrementally.
            header_io =
                  :header_io
               || ' '
               || RPAD (:columns_io (:l_index).column_name,
                        :columns_io (:l_index).data_length);
            l_index = columns_io.NEXT (:l_index);
         END
SELECT_LIST_IO_OUT = SELECT_LIST_IO;
HEADER_IO_OUT = HEADER_IO;
COLUMNS_IO_OUT = COLUMNS_IO;
SUSPEND;
END /*load_column_information*/

   PROCEDURE report_error (text_in  VARCHAR(32000), cursor_io   INTEGER)
RETURNS( CURSOR_IO_OUT INTEGER)

AS
BEGIN
      IF (DBMS_SQL.is_open (:cursor_io))
      THEN
         DBMS_SQL.close_cursor (:cursor_io);

      DBMS_OUTPUT.put_line (:text_in);
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
CURSOR_IO_OUT = CURSOR_IO;
SUSPEND;
END

   PROCEDURE construct_and_open_cursor (select_list_in        VARCHAR(32000),
                                        cursor_out           INTEGER)
RETURNS( CURSOR_OUT_OUT INTEGER)

AS
      DECLARE l_query          max_varchar2_t;
      DECLARE l_where_clause   max_varchar2_t = LTRIM (:where_in);
      DECLARE :l_cursor         SYS_REFCURSOR;
BEGIN
      -- Construct a where clause if a value was specified.

      IF (:l_where_clause IS NOT NULL)
      THEN
         --

         IF ((    :l_where_clause NOT LIKE 'GROUP BY%'
             AND :l_where_clause NOT LIKE 'ORDER BY%'))
         THEN
            l_where_clause = 'WHERE ' || LTRIM (:l_where_clause, 'WHERE');

      -- Assign the dynamic string to a local variable so that it can be
      -- easily used to report an error.
      l_query =
            'SELECT '
         || :select_list_in
         || '  FROM '
         || :table_in
         || ' '
         || :l_where_clause;
      DBMS_OUTPUT.put_line (:l_querY);

      -- 11.1 DBMS_SQL enhancement: convert to cursor variable.
OPEN :l_cursor FOR :l_query;

cursor_out = DBMS_SQL.to_cursor_number (:l_cursor);
/*EXCEPTION*/
      WHEN OTHERS
      DOBEGIN
	         EXECUTE PROCEDURE report_error ('Error constructing and opening cursor: ' || :l_query,
                       :cursor_out);
         RAISE;
         ENDCURSOR_OUT_OUT = CURSOR_OUT;
SUSPEND;
END

   PROCEDURE define_columns_and_execute (cursor_io      INTEGER,
                                         columns_in        columns_tt)
RETURNS( CURSOR_IO_OUT INTEGER, 

AS
      DECLARE l_index      PLS_INTEGER;
      DECLARE l_feedback   PLS_INTEGER;
BEGIN
      /*
      DBMS_SQL.DEFINE_COLUMN
      Before executing the query, I need to tell DBMS_SQL the datatype
      of each the columns being selected in the query. I simply pass
      a literal of the appropriate type to an overloading of
      DBMS_SQL.DEFINE_COLUMN. With string types, I need to also specify
      the maximum length of the value.
      */
      l_index = columns_in.FIRST;

      WHILE ((:l_index IS NOT NULL)) DO
      BEGIN
         IF (is_string (:columns_in, :l_index))
         THEN
            DBMS_SQL.define_column (:cursor_io,
                                    :l_index,
                                    'a',
                                    :columns_in (:l_index).data_length);
         ELSE IF (is_number (:columns_in, :l_index))
         THEN
            DBMS_SQL.define_column (:cursor_io, :l_index, 1);
         ELSE IF (is_date (:columns_in, :l_index))
         THEN
            DBMS_SQL.define_column (:cursor_io, :l_index, CURRENT_TIMESTAMP);

         l_index = columns_in.NEXT (:l_index);
      END
/*EXCEPTION*/
      WHEN OTHERS
      DOBEGIN
	         EXECUTE PROCEDURE report_error ('Error defining columns', :cursor_io);
         RAISE;
         ENDCURSOR_IO_OUT = CURSOR_IO;
SUSPEND;
END

   PROCEDURE build_and_display_output (header_in         VARCHAR(32000),
                                       cursor_io      INTEGER,
                                       columns_in        columns_tt)
RETURNS( CURSOR_IO_OUT INTEGER, 

AS
      -- Used to hold the retrieved column values.
      DECLARE l_string_value     VARCHAR (2000);
      DECLARE l_number_value     NUMERIC(18, 4);
      DECLARE l_date_value       DATE;
      --
      DECLARE l_feedback         INTEGER;
      DECLARE l_index            PLS_INTEGER;
      DECLARE l_one_row_string   max_varchar2_t;

      -- Formatting for the output of the header information

      PROCEDURE display_header
AS
         DECLARE l_border   max_varchar2_t = RPAD ('-', :g_row_line_length, '-');

         FUNCTION centered_string (string_in    VARCHAR(32000),
                                   length_in    INTEGER)
            RETURNS VARCHAR(32000)
         AS
            DECLARE len_string   INTEGER = CHAR_LENGTH (:string_in);
BEGIN
            IF (:len_string IS NULL OR :length_in <= 0)
            THEN
               RETURN NULL;
ELSE
               RETURN    RPAD (' ', (:length_in - :len_string) / 2 - 1)
                      || LTRIM (RTRIM (:string_in));
END /*centered_string*/
BEGIN
         DBMS_OUTPUT.put_line (:l_border);
         DBMS_OUTPUT.put_line (
            centered_string ('Contents of ' || :table_in, :g_row_line_length));
         DBMS_OUTPUT.put_line (:l_border);
         DBMS_OUTPUT.put_line (:l_header);
         DBMS_OUTPUT.put_line (:l_border);
END /*display_header*/
BEGIN
      EXECUTE PROCEDURE display_header;

      /*
         DBMS_SQL.FETCH_ROWS
         Fetch a row, and return the numbers of rows fetched.
         When 0, we are done.
      */
      WHILE (DBMS_SQL.fetch_rows (:cursor_io) > 0) DO
      BEGIN
         l_one_row_string = NULL;
         l_index = columns_in.FIRST;

         WHILE ((:l_index IS NOT NULL)) DO
         BEGIN
            /*
            DBMS_SQL.COLUMN_VALUE
            Retrieve each column value in the current row,
            deposit it into a variable of the appropriate type,
            then convert to a string and concatenate to the
            full line variable.
            */

            IF (is_string (:columns_in, :l_index))
            THEN
               DBMS_SQL.COLUMN_VALUE (:cursor_io, :l_index, :l_string_value);
            ELSE IF (is_number (:columns_in, :l_index))
            THEN
            BEGIN
               DBMS_SQL.COLUMN_VALUE (:cursor_io, :l_index, :l_number_value);
               l_string_value = CAST (:l_number_value);
            END
            ELSE IF (is_date (:columns_in, :l_index))
            THEN
            BEGIN
               DBMS_SQL.COLUMN_VALUE (:cursor_io, :l_index, :l_date_value);
               l_string_value = CAST (:l_date_value);
            END

            l_one_row_string =
                  :l_one_row_string
               || ' '
               || RPAD (COALESCE (:l_string_value, ' '),
                        :columns_in (:l_index).data_length);
            l_index = columns_in.NEXT (:l_index);
         END

         DBMS_OUTPUT.put_line (:l_one_row_string);
      END
/*EXCEPTION*/
      WHEN OTHERS
      DOBEGIN
	         EXECUTE PROCEDURE report_error (
            'Error displaying output; last row = ' || :l_one_row_string,
            :cursor_io);
         ENDCURSOR_IO_OUT = CURSOR_IO;
SUSPEND;
END
BEGIN
   EXECUTE PROCEDURE load_column_information (:l_select_list, :l_header, l_columns);
   EXECUTE PROCEDURE construct_and_open_cursor (:l_select_list, :l_cursor);
   EXECUTE PROCEDURE define_columns_and_execute (:l_cursor, l_columns);
   EXECUTE PROCEDURE build_and_display_output (:l_header, :l_cursor, l_columns);
END /*intab*/^

SET TERM ; ^
/

BEGIN
   EXECUTE PROCEDURE intab ('HR.DEPARTMENTS',
          where_in          => 'department_name like ''%io%''',
          colname_like_in   => '%NAME%');
END;
/

BEGIN
   EXECUTE PROCEDURE intab ('HR.EMPLOYEES',
          where_in          => 'department_id = 80',
          colname_like_in   => '%NAME%');
END;
/


CREATE OR ALTER PACKAGE sql_injection_demo
AS BEGIN 
   DECLARE TYPE name_sal_rt   (
      last_name   VARCHAR(1000)
    , salary      NUMERIC(18, 4)
   );  

   FUNCTION name_sal_for (where_in  VARCHAR(32000) DEFAULT NULL)
      RETURNS sys_refcursor;  

   PROCEDURE show_name_sal (
      title_in  VARCHAR(32000)
    , rows_inout   sys_refcursor
   );  
  END ;
/


SET TERM ^ ;

RECREATE   PACKAGE BODY sql_injection_demo
AS BEGIN 
   FUNCTION name_sal_for (where_in  VARCHAR(32000) DEFAULT NULL)
      RETURNS sys_refcursor
   AS
      DECLARE l_query   VARCHAR (32767)
              = 'select last_name, salary from employees WHERE ' || :where_in;
      DECLARE l_cursor        sys_refcursor;
BEGIN
OPEN :l_cursor FOR :l_query;

RETURN l_cursor;
END /*name_sal_for*/  

   PROCEDURE show_name_sal (
      title_in  VARCHAR(32000)
    , rows_inout   sys_refcursor
   )
RETURNS( ROWS_INOUT_OUT sys_refcursor)

AS
      DECLARE l_employee   name_sal_rt;
BEGIN
      DBMS_OUTPUT.put_line (RPAD ('=', 100, '='));
      DBMS_OUTPUT.put_line ('SQL Injection Demonstration: ' || :title_in);

      WHILE (TRUE) DO BEGIN
FETCH :rows_inout
          INTO :l_employee;
           IF( ROW_COUNT != 1 ) BEGIN LEAVE END;

         DBMS_OUTPUT.put_line (l_employee.last_name || '-'
                               || l_employee.salary
                              );
END 

CLOSE :rows_inout;
ROWS_INOUT_OUT = ROWS_INOUT;
SUSPEND;
END /*show_name_sal*/  
  END ;

SET TERM ; ^
/

-- That's a Funny WHERE Clause!
-- Yep. I can just append a UNION to end of a "normal" WHERE clause predicate, and go crazy.
DECLARE
DECLARE l_rows   sys_refcursor;
BEGIN
   l_rows = sql_injection_demo.name_sal_for ('department_id = 100');
   sql_injection_demo.show_name_sal ('Department 100', l_rows);
   --
   l_rows =
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

SET TERM ^ ;

CREATE OR ALTER PROCEDURE proc1
AS
BEGIN
   DBMS_OUTPUT.put_line ('running proc1');
   RAISE NO_DATA_FOUND;
END^

SET TERM ; ^
/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE proc2
AS
   DECLARE l_str   VARCHAR (30) = 'calling proc1';
BEGIN
   DBMS_OUTPUT.put_line (:l_str);
   EXECUTE PROCEDURE proc1;
END^

SET TERM ; ^
/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE proc3
AS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc2');
   EXECUTE PROCEDURE proc2;
END^

SET TERM ; ^
/

-- Without Back Trace....
-- The only way to "see" the line number on which the error was raised was to let the exception go unhandled.
BEGIN
   DBMS_OUTPUT.put_line ('Proc3 -> Proc2 -> Proc1 unhandled');
   EXECUTE PROCEDURE proc3;
END;
/

-- Trap and Display Error Stack (Error Message)
-- Sure, that works fine and is very good info to have, but the error stack (error message) will contain the line number on which the error was raised!
BEGIN
   DBMS_OUTPUT.put_line ('Proc3 -> Proc2 -> Proc1 unhandled');
   EXECUTE PROCEDURE proc3;
EXCEPTION
   WHEN OTHERS
   DOBEGIN
	      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_stack);
      ENDEND;
/

-- Add Back Trace to Error Handler
-- Now we trap the exception at the top level subprogram and view both the error stack and the back trace.
SET TERM ^ ;

CREATE OR ALTER PROCEDURE proc3
AS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc2');
   EXECUTE PROCEDURE proc2;
/*EXCEPTION*/
   WHEN OTHERS
   DOBEGIN
	      DBMS_OUTPUT.put_line ('Error backtrace at top level:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_stack);
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
      ENDEND^

SET TERM ; ^
/

BEGIN
   DBMS_OUTPUT.put_line ('Proc3 -> Proc2 -> Proc1 backtrace');
   EXECUTE PROCEDURE proc3;
END;
/

-- Re-Raise Exception
-- I show the back trace, but then re-raise.
SET TERM ^ ;

CREATE OR ALTER PROCEDURE proc1
AS
BEGIN
   DBMS_OUTPUT.put_line ('running proc1');
   RAISE NO_DATA_FOUND;
/*EXCEPTION*/
   WHEN OTHERS
   DOBEGIN
	      DBMS_OUTPUT.put_line ('Error backtrace in block where raised:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
      RAISE;
      ENDEND^

SET TERM ; ^
/

-- Can't Trace All the Way Back
-- The call to back trace in this upper-level subprogram no longer finds it way back to the line number of the original exception. That was wiped out with the call to RAISE;
SET TERM ^ ;

CREATE OR ALTER PROCEDURE proc3
AS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc2');
   EXECUTE PROCEDURE proc2;
/*EXCEPTION*/
   WHEN OTHERS
   DOBEGIN
	      DBMS_OUTPUT.put_line ('Error backtrace at top level:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
      ENDEND^

SET TERM ; ^
/

BEGIN
   DBMS_OUTPUT.put_line ('Proc3 -> Proc2 -> Proc1, re-reraise in Proc1');
   EXECUTE PROCEDURE proc3;
END;
/

-- Handle and Raise At Every Level
-- And see how the back trace changes!
SET TERM ^ ;

CREATE OR ALTER PROCEDURE proc1
AS
BEGIN
   DBMS_OUTPUT.put_line ('running proc1');
   RAISE NO_DATA_FOUND;
/*EXCEPTION*/
   WHEN OTHERS
   DOBEGIN
	      DBMS_OUTPUT.put_line ('Error stack in block where raised:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
      RAISE;
      ENDEND^

SET TERM ; ^
/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE proc2
AS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc1');
   EXECUTE PROCEDURE proc1;
/*EXCEPTION*/
   WHEN OTHERS
   DOBEGIN
	      RAISE VALUE_ERROR;
      ENDEND^

SET TERM ; ^
/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE proc3
AS
BEGIN
   DBMS_OUTPUT.put_line ('calling proc2');
   EXECUTE PROCEDURE proc2;
/*EXCEPTION*/
   WHEN OTHERS
   DOBEGIN
	      DBMS_OUTPUT.put_line ('Error backtrace at top level:');
      DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
      ENDEND^

SET TERM ; ^
/

BEGIN
   DBMS_OUTPUT.put_line
('Proc3 -> Proc2 -> Proc1, re-reraise in Proc1, raise VE in Proc2');
   EXECUTE PROCEDURE proc3;
END;
/


CREATE OR ALTER PACKAGE 
   AUTHID DEFINER
AS BEGIN 
   FUNCTION format_call_stack RETURNS VARCHAR(32000);  
   FUNCTION format_error_stack RETURNS VARCHAR(32000);  
   FUNCTION format_error_backtrace RETURNS VARCHAR(32000);  
   FUNCTION backtrace_to RETURNS VARCHAR(32000);  
  END;
/


SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN 
   FUNCTION format_call_stack
      RETURNS VARCHAR(32000)
   AS
      DECLARE l_return   VARCHAR (32767)
         =    '----- PL/SQL Call Stack -------'
            || CHR (10)
            || 'Line     Object name'
            || CHR (10)
            || '-------- ----------------------';

  DECLARE VARIABLE indx INTEGER;
BEGIN
      /* 1 is always this function, so ignore it. */
indx = 2;
WHILE ( indx <= utl_call_stack.dynamic_depth) DO
BEGIN
         l_return =
               :l_return
            || case when :l_return is not null then CHR (10) end
            || LPAD (CAST (utl_call_stack.unit_line (:indx) AS VARCHAR(32000)), 8)
            || ' '
            || utl_call_stack.owner (:indx)
            || '.'
            || utl_call_stack.concatenate_subprogram (
                  utl_call_stack.subprogram (:indx));
indx = indx + 1;
END

RETURN l_return;
END  

   FUNCTION format_error_stack
      RETURNS VARCHAR(32000)
   AS
      DECLARE l_return   VARCHAR (32767);

  DECLARE VARIABLE indx INTEGER;
BEGIN
indx = 1;
WHILE ( indx <= utl_call_stack.error_depth) DO
BEGIN
         l_return =
               :l_return
            || case when :l_return is not null then CHR (10) end
            || 'ORA-'
            || LPAD (CAST (utl_call_stack.error_number (:indx) AS VARCHAR(32000)), 5, '0')
            || ': '
            || utl_call_stack.error_msg (:indx);
indx = indx + 1;
END

RETURN l_return;
END  

   FUNCTION format_error_backtrace
      RETURNS VARCHAR(32000)
   AS
      DECLARE l_return   VARCHAR (32767);

  DECLARE VARIABLE indx INTEGER;
BEGIN
indx = 1;
WHILE ( indx <= utl_call_stack.backtrace_depth) DO
BEGIN
         l_return =
               :l_return
            || case when :l_return is not null then CHR (10) end
            || :indx
            || ' -> '
            || utl_call_stack.backtrace_unit (:indx)
            || ' - Line '
            || CAST (utl_call_stack.backtrace_line (:indx) AS VARCHAR(32000));
indx = indx + 1;
END

RETURN l_return;
/*EXCEPTION*/
      WHEN OTHERS
      DOBEGIN
	         IF (SQLCODE = -64610)
         THEN
            /* ORA-64610: bad depth indicator */
            RETURN l_return;
ELSE
            RAISE;
         ENDEND  

   FUNCTION backtrace_to
      RETURNS VARCHAR(32000)
   AS
BEGIN
RETURN    utl_call_stack.backtrace_unit (1)
    || ' on line '
    || utl_call_stack.backtrace_line (1);
END  
  END;

SET TERM ; ^
/
/*
Error at line 6:0 - mismatched input 'CREATE' expecting ';'


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
*/
/


CREATE OR ALTER PACKAGE 
   AUTHID DEFINER
AS BEGIN 
   DECLARE PROCEDURE p;  
  END;
/


SET TERM ^ ;

RECREATE   PACKAGE BODY 
AS BEGIN 
   PROCEDURE p
   AS
BEGIN
      p1;
END  
  END;

SET TERM ; ^
/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE p2
   AUTHID DEFINER
AS
BEGIN
   EXECUTE PROCEDURE pkg.p;
END^

SET TERM ; ^
/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE p3
   AUTHID DEFINER
AS
BEGIN
   EXECUTE PROCEDURE p2;
/*EXCEPTION*/
   WHEN OTHERS
   DOBEGIN
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
      ENDEND^

SET TERM ; ^
/

BEGIN
   EXECUTE PROCEDURE p3;

/* Trapping the exception because if I do not, LiveSQL will not
   show the contents of the DBMS_OUTPUT buffer.
*/

EXCEPTION WHEN OTHERS
   DOBEGIN
	      NULL;
      ENDEND;
/


CREATE OR ALTER PACKAGE dbms_errlog_helper
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
AS BEGIN 
   PROCEDURE create_objects (dml_table_name           VARCHAR(32000)
                           , err_log_table_name       VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner      VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space      VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR(32000) DEFAULT NULL
                           , err_log_package_spec  DBMS_SQL.varchar2s
                           , err_log_package_body  DBMS_SQL.varchar2s
                            );  

   PROCEDURE create_objects (dml_table_name           VARCHAR(32000)
                           , err_log_table_name       VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner      VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space      VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR(32000) DEFAULT NULL
                           , err_log_package_spec  VARCHAR(32000)
                           , err_log_package_body  VARCHAR(32000)
                            );  

   PROCEDURE create_objects (dml_table_name        VARCHAR(32000)
                           , err_log_table_name    VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner   VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space   VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported      BOOLEAN DEFAULT FALSE
                           , overwrite_log_table   BOOLEAN DEFAULT TRUE
                           , err_log_package_name  VARCHAR(32000) DEFAULT NULL
                            );  
  END ;
/


SET TERM ^ ;

RECREATE   PACKAGE BODY dbms_errlog_helper
AS BEGIN 
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

   SUBTYPE maxvarchar2_t IS VARCHAR (32767);  

   PROCEDURE create_objects (dml_table_name           VARCHAR(32000)
                           , err_log_table_name       VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner      VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space      VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR(32000) DEFAULT NULL
                           , err_log_package_spec  DBMS_SQL.varchar2s
                           , err_log_package_body  DBMS_SQL.varchar2s
                            )
RETURNS( ERR_LOG_PACKAGE_SPEC_OUT DBMS_SQL.varchar2s, 
ERR_LOG_PACKAGE_BODY_OUT DBMS_SQL.varchar2s)

AS
      
      DECLARE c_package_name CONSTANT maxvarchar2_t
            = SUBSTRING (COALESCE (:err_log_package_name, 'ELP$_' || :dml_table_name)
                      FROM  1
                      FOR  30
                      ) ;
      DECLARE c_errlog_table_name CONSTANT maxvarchar2_t
            = SUBSTRING (COALESCE (:err_log_table_name, 'ERR$_' || :dml_table_name)
                      FROM  1
                      FOR  30
                      ) ;
      DECLARE c_qual_errlog_table_name CONSTANT maxvarchar2_t
            = CASE
                  WHEN :err_log_table_owner IS NULL THEN NULL
                  ELSE :err_log_table_owner || '.'
END
|| :c_errlog_table_name ;
      DECLARE l_spec   DBMS_SQL.varchar2s;
      DECLARE l_body   DBMS_SQL.varchar2s;

      PROCEDURE create_error_log
AS
BEGIN
         IF (:overwrite_log_table)
         THEN
BEGIN
EXECUTE STATEMENT ('DROP TABLE ' || :c_qual_errlog_table_name);
/*EXCEPTION*/
               WHEN OTHERS
               DOBEGIN
	                  NULL;
                  ENDEND

         /*
         Create the error log; any errors raised by this program will
         terminate the rest of the processing of this helper program.
         */
         DBMS_ERRLOG.create_error_log (
            :dml_table_name        => :dml_table_name
          , :err_log_table_name    => :err_log_table_name
          , :err_log_table_owner   => :err_log_table_owner
          , :err_log_table_space   => :err_log_table_space
          , :skip_unsupported      => :skip_unsupported
         );

         /* Alter the error log table to add audit columns. */
EXECUTE STATEMENT ('ALTER TABLE ' || COALESCE (:err_log_table_owner, USER)
    || '.' || :c_errlog_table_name || ' ADD created_by VARCHAR2(30)');

EXECUTE STATEMENT ('ALTER TABLE ' || COALESCE (:err_log_table_owner, USER)
    || '.' || :c_errlog_table_name || ' ADD created_on DATE');

/* Add Call Stack: Thanks, IFMC! */
EXECUTE STATEMENT ('ALTER TABLE ' || COALESCE (:err_log_table_owner, USER)
    || '.' || :c_errlog_table_name || ' ADD call_stack VARCHAR2(4000)');

/* Add the trigger to update these columns. */
EXECUTE STATEMENT ('CREATE OR REPLACE TRIGGER '
    || SUBSTRING (:dml_table_name || '$BEF_EL' FROM  1 FOR  30)
    || ' BEFORE INSERT OR UPDATE ON ' || COALESCE (:err_log_table_owner, USER)
    || '.' || :c_errlog_table_name || ' FOR EACH ROW BEGIN :NEW.created_by := USER; '
    || ' :NEW.created_on := SYSDATE; ' || ' :NEW.call_stack := '
    || 'SUBSTR (dbms_utility.Format_call_stack (), 1, 4000); END;');
END /*create_error_log*/

      PROCEDURE generate_spec (package_name_in      VARCHAR(32000)
                             , code_out            DBMS_SQL.varchar2s
                              )
RETURNS( CODE_OUT_OUT DBMS_SQL.varchar2s)

AS
         PROCEDURE add_line (line_in  VARCHAR(32000))
         AS
BEGIN
            l_spec (l_spec.COUNT + 1) = :line_in;
END /*add_line*/
BEGIN
         EXECUTE PROCEDURE add_line ('CREATE OR REPLACE PACKAGE ' || :c_package_name || ' IS ');
         EXECUTE PROCEDURE add_line(   'SUBTYPE error_log_r IS '
                  || :c_qual_errlog_table_name
                  || '%ROWTYPE;');
         EXECUTE PROCEDURE add_line(   'TYPE error_log_tc IS TABLE OF '
                  || :c_qual_errlog_table_name
                  || '%ROWTYPE;');
         EXECUTE PROCEDURE add_line ('PROCEDURE clear_error_log;');
         EXECUTE PROCEDURE add_line ('FUNCTION error_log_contents (');
         EXECUTE PROCEDURE add_line ('  ORA_ERR_NUMBER$_IN IN PLS_INTEGER DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', ORA_ERR_OPTYP$_IN IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', ORA_ERR_TAG$_IN IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', where_in IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', preserve_log_in IN BOOLEAN DEFAULT TRUE');
         EXECUTE PROCEDURE add_line (') RETURN error_log_tc;');
         -- add_line ('PROCEDURE dump_error_log;');
         EXECUTE PROCEDURE add_line ('END ' || :c_package_name || ';');
         code_out = :l_spec;
CODE_OUT_OUT = CODE_OUT;
SUSPEND;
END /*generate_spec*/

      PROCEDURE generate_body (package_name_in      VARCHAR(32000)
                             , code_out            DBMS_SQL.varchar2s
                              )
RETURNS( CODE_OUT_OUT DBMS_SQL.varchar2s)

AS
         PROCEDURE add_line (line_in  VARCHAR(32000))
         AS
BEGIN
            l_body (l_body.COUNT + 1) = :line_in;
END /*add_line*/
BEGIN
         EXECUTE PROCEDURE add_line (
            'CREATE OR REPLACE PACKAGE BODY ' || :c_package_name || ' IS '
         );
         EXECUTE PROCEDURE add_line ('PROCEDURE clear_error_log');
         EXECUTE PROCEDURE add_line ('IS PRAGMA AUTONOMOUS_TRANSACTION; BEGIN ');
         EXECUTE PROCEDURE add_line ('DELETE FROM ' || :c_qual_errlog_table_name || '; COMMIT;');
         EXECUTE PROCEDURE add_line ('END clear_error_log;');
         EXECUTE PROCEDURE add_line ('FUNCTION error_log_contents (');
         EXECUTE PROCEDURE add_line ('  ORA_ERR_NUMBER$_IN IN PLS_INTEGER DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', ORA_ERR_OPTYP$_IN IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', ORA_ERR_TAG$_IN IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', where_in IN VARCHAR2 DEFAULT NULL');
         EXECUTE PROCEDURE add_line (', preserve_log_in IN BOOLEAN DEFAULT TRUE');
         EXECUTE PROCEDURE add_line (') RETURN error_log_tc');
         EXECUTE PROCEDURE add_line (' IS ');
         EXECUTE PROCEDURE add_line('l_query      VARCHAR2 (32767)
         :=    ''SELECT * FROM '
                  || :c_qual_errlog_table_name
                  || ' WHERE ( ora_err_number$ LIKE :ora_err_number$_in
              OR :ora_err_number$_in IS NULL');
         EXECUTE PROCEDURE add_line(') AND (   ora_err_optyp$ LIKE :ora_err_optyp$_in
              OR :ora_err_optyp$_in IS NULL )');
         EXECUTE PROCEDURE add_line('AND (ora_err_tag$ LIKE :ora_err_tag$_in OR :ora_err_tag$_in IS NULL)''
            || CASE WHEN where_in IS NULL');
         EXECUTE PROCEDURE add_line('THEN NULL ELSE '' AND '' || REPLACE (where_in, '''''''', '''''''''''') END;
      l_log_rows   error_log_tc;');
         EXECUTE PROCEDURE add_line (
            'BEGIN EXECUTE IMMEDIATE l_query BULK COLLECT INTO l_log_rows'
         );
         EXECUTE PROCEDURE add_line('USING ORA_ERR_NUMBER$_IN, ORA_ERR_NUMBER$_IN,
               ORA_ERR_OPTYP$_IN, ORA_ERR_OPTYP$_IN,
               ORA_ERR_TAG$_IN, ORA_ERR_TAG$_IN; RETURN l_log_rows;');
         EXECUTE PROCEDURE add_line ('IF NOT preserve_log_in THEN clear_error_log(); END IF;');
         EXECUTE PROCEDURE add_line('EXCEPTION WHEN OTHERS THEN
         DBMS_OUTPUT.put_line (''Error retrieving log contents for :'');
         DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_stack);
         DBMS_OUTPUT.put_line (l_query);
         RAISE;');
         EXECUTE PROCEDURE add_line ('END error_log_contents; END ' || :c_package_name || ';');
         code_out = :l_body;
CODE_OUT_OUT = CODE_OUT;
SUSPEND;
END /*generate_body*/
BEGIN
      IN AUTONOMOUS TRANSACTION DO BEGIN
EXECUTE PROCEDURE create_error_log;
      EXECUTE PROCEDURE generate_spec (:c_package_name, :err_log_package_spec);
      EXECUTE PROCEDURE generate_body (:c_package_name, :err_log_package_body);
	END
ERR_LOG_PACKAGE_SPEC_OUT = ERR_LOG_PACKAGE_SPEC;
ERR_LOG_PACKAGE_BODY_OUT = ERR_LOG_PACKAGE_BODY;
SUSPEND;
END /*create_objects*/  

   PROCEDURE create_objects (dml_table_name           VARCHAR(32000)
                           , err_log_table_name       VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner      VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space      VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported         BOOLEAN DEFAULT FALSE
                           , overwrite_log_table      BOOLEAN DEFAULT TRUE
                           , err_log_package_name     VARCHAR(32000) DEFAULT NULL
                           , err_log_package_spec  VARCHAR(32000)
                           , err_log_package_body  VARCHAR(32000)
                            )
RETURNS( ERR_LOG_PACKAGE_SPEC_OUT VARCHAR(32000), 
ERR_LOG_PACKAGE_BODY_OUT VARCHAR(32000))

AS
      DECLARE l_spec          DBMS_SQL.varchar2s;
      DECLARE l_body          DBMS_SQL.varchar2s;
      DECLARE l_spec_string   maxvarchar2_t;
      DECLARE l_body_string   maxvarchar2_t;

  DECLARE VARIABLE indx INTEGER;
BEGIN
      EXECUTE PROCEDURE create_objects (:dml_table_name         => :dml_table_name
                    , :err_log_table_name     => :err_log_table_name
                    , :err_log_table_owner    => :err_log_table_owner
                    , :err_log_table_space    => :err_log_table_space
                    , :skip_unsupported       => :skip_unsupported
                    , :overwrite_log_table    => :overwrite_log_table
                    , :err_log_package_name   => :err_log_package_name
                    , :err_log_package_spec   => :l_spec
                    , :err_log_package_body   => :l_body
                     );

indx = 1;
WHILE ( indx <= l_spec.COUNT) DO
BEGIN
         l_spec_string =
            CASE
               WHEN :indx = 1 THEN :l_spec (:indx)
               ELSE :l_spec_string || CHR (10) || :l_spec (:indx)
END;
indx = indx + 1;
END

indx = 1;
WHILE ( indx <= l_body.COUNT) DO
BEGIN
         l_body_string =
            CASE
               WHEN :indx = 1 THEN :l_body (:indx)
               ELSE :l_body_string || CHR (10) || :l_body (:indx)
END;
indx = indx + 1;
END

      err_log_package_spec = :l_spec_string;
      err_log_package_body = :l_body_string;
ERR_LOG_PACKAGE_SPEC_OUT = ERR_LOG_PACKAGE_SPEC;
ERR_LOG_PACKAGE_BODY_OUT = ERR_LOG_PACKAGE_BODY;
SUSPEND;
END /*create_objects*/  

   PROCEDURE create_objects (dml_table_name        VARCHAR(32000)
                           , err_log_table_name    VARCHAR(32000) DEFAULT NULL
                           , err_log_table_owner   VARCHAR(32000) DEFAULT NULL
                           , err_log_table_space   VARCHAR(32000) DEFAULT NULL
                           , skip_unsupported      BOOLEAN DEFAULT FALSE
                           , overwrite_log_table   BOOLEAN DEFAULT TRUE
                           , err_log_package_name  VARCHAR(32000) DEFAULT NULL
                            )
AS
      
      DECLARE l_spec   DBMS_SQL.varchar2s;
      DECLARE l_body   DBMS_SQL.varchar2s;

      PROCEDURE compile_statement (array_in  DBMS_SQL.varchar2s)
AS
         DECLARE l_cur   PLS_INTEGER = DBMS_SQL.open_cursor;
BEGIN
         DBMS_SQL.parse (:l_cur
                       , :array_in
                       , 1
                       , array_in.COUNT
                       , TRUE
                       , DBMS_SQL.native
                        );
         DBMS_SQL.close_cursor (:l_cur);
END /*compile_statement*/
BEGIN
      IN AUTONOMOUS TRANSACTION DO BEGIN
EXECUTE PROCEDURE create_objects (:dml_table_name         => :dml_table_name
                    , :err_log_table_name     => :err_log_table_name
                    , :err_log_table_owner    => :err_log_table_owner
                    , :err_log_table_space    => :err_log_table_space
                    , :skip_unsupported       => :skip_unsupported
                    , :overwrite_log_table    => :overwrite_log_table
                    , :err_log_package_name   => :err_log_package_name
                    , err_log_package_spec   => :l_spec
                    , err_log_package_body   => :l_body
                     );
      EXECUTE PROCEDURE compile_statement (:l_spec);
      EXECUTE PROCEDURE compile_statement (:l_body);
	END
/*EXCEPTION*/
      WHEN OTHERS DOBEGIN
	 dbms_output.put_line (dbms_utility.format_error_backtrace); raise;
 ENDEND /*create_objects*/  
  END ;

SET TERM ; ^
