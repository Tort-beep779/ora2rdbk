### [connect_by_prior.sql](connect_by_prior.sql)

Конструкция CONNECT BY используется для построения иерархии данных. В данном случае она связывает строки таблицы employees по принципу:

employee_id текущей строки (дочерний элемент) связан с manager_id (родительский элемент).

Ключевое слово PRIOR указывает, что значение employee_id из предыдущей строки иерархии должно быть равно manager_id текущей строки.

Пример вывода для запроса из теста 

    EMPLOYEE_ID LAST_NAME                 MANAGER_ID
    ----------- ------------------------- ----------
        101 Kochhar                          100
        108 Greenberg                        101
        109 Faviet                           108
        110 Chen                             108
        111 Sciarra                          108
        112 Urman                            108
        113 Popp                             108
        200 Whalen                           101
        203 Mavris                           101
        204 Baer                             101

---------------------------------------------------------

### [connect_by_prior_with_LEVEL.sql](connect_by_prior_with_LEVEL.sql)

Пример использует псевдоколонку LEVEL для отображения родительских и дочерних строк:

Пример вывода 

    EMPLOYEE_ID LAST_NAME                 MANAGER_ID      LEVEL
    ----------- ------------------------- ---------- ----------
        101 Kochhar                          100          1
        108 Greenberg                        101          2
        109 Faviet                           108          3
        110 Chen                             108          3
        111 Sciarra                          108          3
        112 Urman                            108          3
        113 Popp                             108          3
        200 Whalen                           101          2
        203 Mavris                           101          2
        204 Baer                             101          2
        205 Higgins                          101          2
        206 Gietz                            205          3
        102 De Haan                          100          1

---------------------------------------------------------

### [connect_by_isleaf.sql](connect_by_isleaf.sql)

Псевдоколонка CONNECT_BY_ISCYCLE возвращает 1, если у текущей строки есть дочерний элемент, который также является ее предком. В противном случае он возвращает 0.

---------------------------------------------------------

### [connect_by_root.sql](connect_by_root.sql)

CONNECT_BY_ROOT - это унарный оператор, который допустим только в иерархических запросах. Когда вы определяете столбец с помощью этого оператора, Oracle возвращает значение столбца, используя данные из корневой строки. Этот оператор расширяет функциональность иерархических запросов для CONNECT BY [PRIOR]  условия.

Пример

    SELECT last_name "Employee", CONNECT_BY_ROOT last_name "Manager",
    LEVEL-1 "Pathlen", SYS_CONNECT_BY_PATH(last_name, '/') "Path"
    FROM employees
    WHERE LEVEL > 1 and department_id = 110
    CONNECT BY PRIOR employee_id = manager_id
    ORDER BY "Employee", "Manager", "Pathlen", "Path";
    
    Employee        Manager            Pathlen Path
    --------------- --------------- ---------- ------------------------------
    Gietz           Higgins                  1 /Higgins/Gietz
    Gietz           King                     3 /King/Kochhar/Higgins/Gietz
    Gietz           Kochhar                  2 /Kochhar/Higgins/Gietz
    Higgins         King                     2 /King/Kochhar/Higgins
    Higgins         Kochhar                  1 /Kochhar/Higgins

Для сортрудника выводиться его менежер (CONNECT_BY_ROOT last_name)

---------------------------------------------------------




























