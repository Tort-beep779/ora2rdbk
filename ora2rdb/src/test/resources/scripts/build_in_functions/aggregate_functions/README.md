[Официальная документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/Aggregate-Functions.html)

------------------------------------------------

### [any_value.sql](any_value.sql)

    ANY_VALUE( [ DISTINCT | ALL ] expr )

[статься](https://db-oriented.com/2020/12/20/any_value/), описывающая проблему, из-за которой
и была добавлена агрегатная функция ANY_VALUE

Результат работы оператора select из теста 

    CUST_ID  ANY_VALUE(CUST_LAST_NAME) SUM(AMOUNT_SOLD)
    ------- -------------------------- ----------------
    6950 Sandburg                                 78
    17920 Oliver                                 3201
    66800 Case                                   2024
    37280 Edwards                                2256
    109850 Lindegreen                              757
    3910 Oddell                                  185
    84700 Marker                                164.4
    26380 Remler                                  118
    11600 Oppy                                    158
    23030 Rothrock                                533
    42780 Zanis                                   182

------------------------------------------------

### [approx_count.sql](approx_count.sql)

    APPROX_COUNT ( ( * | expr ) [ , 'MAX_ERROR' ] )

Функция **APPROX_COUNT** в Oracle используется для приблизительного подсчёта количества уникальных значений в большом наборе данных. 
Она предназначена для работы с большими объёмами информации, где точный подсчёт с использованием стандартной функции COUNT(DISTINCT ...) может быть слишком затратным по времени и ресурсам.

------------------------------------------------

### [approx_count_distinct.sql](approx_count_distinct.sql)

    APPROX_COUNT_DISTINCT(expr)

**APPROX_COUNT_DISTINCT** - APPROX_COUNT_DISTINCT возвращает приблизительное количество строк, содержащих неповторяющиеся значение для выражения.

------------------------------------------------

### [approx_count_distinct_agg.sql](approx_count_distinct_agg.sql)

    APPROX_COUNT_DISTINCT_AGG( detail )

**APPROX_COUNT_DISTINCT_AGG** - Агрегирует результаты приблизительного подсчёта уникальных значений.

------------------------------------------------

### [approx_count_distinct_detail.sql](approx_count_distinct_detail.sql)

    APPROX_COUNT_DISTINCT_DETAIL( expr )

**APPROX_COUNT_DISTINCT_DETAIL** - Возвращает детализированные данные для приблизительного подсчёта уникальных значений.

------------------------------------------------

### [approx_median.sql](approx_median.sql)

    APPROX_MEDIAN( expr [ DETERMINISTIC ] [, { 'ERROR_RATE' | 'CONFIDENCE' } ] )

**APPROX_MEDIAN**  - Возвращает приблизительное медианное значение.

------------------------------------------------
### [approx_percentile.sql](approx_percentile.sql)

    APPROX_PERCENTILE( expr [ DETERMINISTIC ] [, { 'ERROR_RATE' | 'CONFIDENCE' } ] )
    WITHIN GROUP ( ORDER BY expr [ DESC | ASC ] )

**APPROX_PERCENTILE** - Возвращает значение по указанному проценту

------------------------------------------------

### [approx_percentile_agg.sql](approx_percentile_agg.sql)

    APPROX_PERCENTILE_AGG(expr)

**APPROX_PERCENTILE_AGG** - Принимает BLOB значение и вовзращает агрегированные данные

------------------------------------------------

### [approx_percentile_detail.sql](approx_percentile_detail.sql)
    
    APPROX_PERCENTILE_DETAIL( expr [ DETERMINISTIC ] )

**APPROX_PERCENTILE_DETAIL** - конвертирует BLOB значение в число

------------------------------------------------

### [approx_rank.sql](approx_rank.sql)

    APPROX_RANK ( expr [ PARTITION BY partition_by_clause ] [ ORDER BY order_by_clause DESC] )

**APPROX_RANK** – returns the rank values in an approximate top-n attribute values.

------------------------------------------------

### [approx_sum.sql](approx_sum.sql)

    APPROX_SUM (  ( * | expr )[ , 'MAX_ERROR' ] )

**APPROX_SUM** – returns the approximate sum in an approximate top-n attribute values.


------------------------------------------------

### [avg.sql](avg/avg.sql)

    AVG([ DISTINCT | ALL ] expr) [ OVER(analytic_clause) ]

Вычисляет среднее значение для переданного выражения (expr)

Ключевое слово **ALL** - означает, что в подсчете должны принимать участие все непустые значения, полученные оператором
SELECT 

Ключевое слово **DISTINCT** указывает, что из исходных значений для подсчета среднего значения должны исключаться дублирующие значения

------------------------------------------------


### [bit_and_agg.sql](bit_and_agg.sql)

    BIT_AND_AGG ( [DISTINCT | ALL | UNIQUE]  expr )

**BIT_AND_AGG** is a bitwise aggregation function that returns the result of a bitwise AND operation.

You can use BIT_AND_AGG as part of a GROUP BY query, window function, or as an analytical function. The return type of BIT_AND_AGG is always a number.


------------------------------------------------

### [bit_or_agg.sql](bit_or_agg.sql)

    BIT_OR_AGG ( [DISTINCT | ALL | UNIQUE]  expr )


**BIT_OR_AGG** is a bitwise aggregation function that returns the result of a bitwise OR operation.

You can use BIT_OR_AGG as part of a GROUP BY query, window function, or as an analytical function. The return type of BIT_OR_AGG is always a number.
 
------------------------------------------------

### [bit_xor_agg.sql](bit_xor_agg.sql)

    BIT_XOR_AGG ( [DISTINCT | ALL | UNIQUE] expr )

**BIT_XOR_AGG** is a bitwise aggregation function that returns the result of a bitwise XOR operation.

You can use BIT_XOR_AGG as part of a GROUP BY query, window function, or as an analytical function. 
The return type of BIT_XOR_AGG is always a number.

------------------------------------------------

### [checksum.sql](checksum.sql)
    
    CHECKSUM "(" [ DISTINCT | ALL ] expr ")" [ OVER "(" analytic_clause ")" ]

**CHECKSUM** - Возвращает чек сумму, по которой можно опеределить, поменялось ли содержимое таблицы


------------------------------------------------

### [collect.sql](collect.sql)

    COLLECT( [ DISTINCT | UNIQUE ] column [ ORDER BY expr ] )

COLLECT - функция агрегирования, которая принимает столбец любого типа и создает коллекцию типа **nested table** 


------------------------------------------------

### [corr.sql](corr.sql)


    CORR(expr1, expr2) [ OVER (analytic_clause) ]

**CORR** - возвращает коэффициент корреляции между двумя числами

Вычисление происходит по формуле 

    COVAR_POP(expr1, expr2) / (STDDEV_POP(expr1) * STDDEV_POP(expr2))

Функции [covar_pop.sql](covar_pop.sql) и [stddev_pop.sql](stddev_pop.sql)

------------------------------------------------

### [corr_k_and_corr_s.sql](corr_k_and_corr_s.sql)

    { CORR_K | CORR_S }
        (expr1, expr2
            [, { COEFFICIENT
                | ONE_SIDED_SIG
                | ONE_SIDED_SIG_POS
                | ONE_SIDED_SIG_NEG
                | TWO_SIDED_SIG
            }
        ]
    )

The CORR function (see [corr.sql](corr.sql)) calculates the Pearson's correlation coefficient and requires numeric expressions as input. 
The **CORR_*** functions support nonparametric or rank correlation. They let you find correlations between expressions that are ordinal scaled (where ranking of the values is possible). 
Correlation coefficients take on a value ranging from -1 to 1, where 1 indicates a perfect relationship, -1 a perfect inverse relationship (when one variable increases as the other decreases), and a value close to 0 means no relationship.

| Return Value       | Meaning                                      |
|--------------------|----------------------------------------------|
| COEFFICIENT        | Coefficient of correlation                  |
| ONE_SIDED_SIG      | Positive one-tailed significance of the correlation |
| ONE_SIDED_SIG_POS  | Same as ONE_SIDED_SIG                        |
| ONE_SIDED_SIG_NEG  | Negative one-tailed significance of the correlation |
| TWO_SIDED_SIG      | Two-tailed significance of the correlation  |


**CORR_S** calculates the Spearman's rho correlation coefficient. 

**CORR_K** calculates the Kendall's tau-b correlation coefficient.

------------------------------------------------

### [count.sql](count/count.sql)

    COUNT({ * | [ DISTINCT | ALL ] expr }) [ OVER (analytic_clause) ]

**COUNT** - возвращает количество записей в выборке

------------------------------------------------

### [covar_pop.sql](covar_pop.sql)


    COVAR_POP(expr1, expr2)
        [ OVER (analytic_clause) ]


Функция **COVAR_POP** возвращает ковариацию совокупности пар выражений с числовыми зна-чениями.

Формула вычисления у этой функции

    (SUM(expr1 * expr2) - SUM(expr2) * SUM(expr1) / n) / n

где n - количество пар (expr1 * expr2), где expr1 и expr2 не равны нулю

------------------------------------------------


### [covar_samp.sql](covar_samp.sql)

    COVAR_SAMP(expr1, expr2) [ OVER (analytic_clause) ]

Функция **COVAR_SAMP** возвращает выборочную ковариацию пары выражений с числовыми зна-чениями

Формула вычисления у этой функции

    (SUM(expr1 * expr2) - SUM(expr1) * SUM(expr2) / n) / (n-1)

------------------------------------------------

### [cume_dist.sql](cume_dist.sql)

    cume_dist_aggregate::=
        CUME_DIST(expr[,expr ]...) WITHIN GROUP
          (ORDER BY expr [ DESC | ASC ]
                         [ NULLS { FIRST | LAST } ] 
                    [, expr [ DESC | ASC ]
                            [ NULLS { FIRST | LAST } ]
                    ]...
          )

    cume_dist_analytic::=
        CUME_DIST() OVER ([ query_partition_clause ] order_by_clause)

**CUME_DIST** - Функция вычисляет кумулятивное распределение значений внутри группы

------------------------------------------------

### [dense_rank.sql](dense_rank.sql)

    dense_rank_aggregate::=
        DENSE_RANK(expr [, expr ]...) WITHIN GROUP
            (ORDER BY expr [ DESC | ASC ]
                [ NULLS { FIRST | LAST } ]
                [,expr [ DESC | ASC ]
                [ NULLS { FIRST | LAST } ]
            ]...
        )

    dense_rank_analytic::=

        DENSE_RANK( ) OVER([ query_partition_clause ] order_by_clause)


**DENSE_RANK** вычисляет ранг строки в упорядоченной группе строк и возвращает ранг в виде числа 

------------------------------------------------


### [first.sql](first.sql)

    aggregate_function KEEP
    ( DENSE_RANK FIRST ORDER BY
        expr [ DESC | ASC ]
        [ NULLS { FIRST | LAST } ]
        [, expr [ DESC | ASC ]
        [ NULLS { FIRST | LAST } ]
        ]...
    )
    [ OVER ( [query_partition_clause] ) ]


**FIRST** и **LAST** - очень похожие функции. Обе они являются агрегатными и аналитическими функциями, которые обрабатывают набор значений из набора строк, которые считаются ПЕРВЫМИ или ПОСЛЕДНИМИ в соответствии с заданной спецификацией сортировки. 
Если только одна строка имеет ранг ПЕРВОЙ или ПОСЛЕДНЕЙ, то агрегат работает с набором только с одним элементом.
Если вы опустите предложение OVER, то ПЕРВАЯ и ПОСЛЕДНЯЯ функции будут рассматриваться как агрегатные функции. Вы можете использовать эти функции как аналитические, указав предложение OVER. Условие query_partition_clause - единственная часть предложения OVER, допустимая для этих функций. 
Если вы включаете предложение OVER, но опускаете query_partition_clause, то функция рассматривается как аналитическая функция, но окно, определенное для анализа, - это вся таблица.

------------------------------------------------

### [group_id.sql](group_id.sql)

    GROUP_ID( )

**GROUP_ID** распознает повторяющиеся группы, полученные из спецификации GROUP BY. Это полезно для фильтрации повторяющихся групп из результата запроса. Возвращает тип данных NUMBER в Oracle для уникальной идентификации повторяющихся групп. 
Эта функция применима только в инструкции SELECT, которая содержит предложение GROUP BY.

Если для определенной группы существуют дубликаты, то GROUP_ID возвращает числа в диапазоне от 0 до n

------------------------------------------------

### [grouping.sql](grouping.sql)

    GROUPING(expr)

Функция принимает один столбец в качестве параметра и возвращает "1", если столбец содержит нулевое значение, 
сгенерированное как часть промежуточного итога с помощью операции ROLLUP или CUBE, или "0" для любого другого значения, включая сохраненные нулевые значения.

[Статья](https://oracle-base.com/articles/misc/rollup-cube-grouping-functions-and-grouping-sets#grouping_functions)


------------------------------------------------

### [grouping_id.sql](grouping_id.sql)

Функция **GROUPING_ID** предоставляет альтернативный и более компактный способ идентификации строк промежуточных итогов. 
Передавая столбцы измерений в качестве аргументов, она возвращает число, указывающее на уровень гркппировки (GROUP BY).

------------------------------------------------

### [last.sql](last.sql)

    aggregate_function KEEP
    (DENSE_RANK LAST ORDER BY
        expr [ DESC | ASC ]
            [ NULLS { FIRST | LAST } ]
        [, expr [ DESC | ASC ]
            [ NULLS { FIRST | LAST } ]
        ]...
    )
    [ OVER ( [query_partition_clause] ) ]


Смотри функцию [first.sql](first.sql)

------------------------------------------------

### [listagg.sql](listagg.sql)

    LISTAGG( [ ALL | DISTINCT ] measure_expr [, ' delimiter ' ] [ listagg_overflow_clause ] )
    
        [ WITHIN GROUP ( order_by_clause )  ]
    
        [ OVER ( [ query_partition_clause ] ) ]

    { ON OVERFLOW ERROR }
    |
    { ON OVERFLOW TRUNCATE [ 'truncation-indicator' ] [ { WITH | WITHOUT } COUNT ] }

------------------------------------------------

### [max.sql](max.sql)

    MAX([ DISTINCT | ALL ] expr) [ OVER (analytic_clause) ]

Возвращает масимальное значение у переданного выражения (expr)

------------------------------------------------

### [median.sql](median.sql)

    MEDIAN(expr) [ OVER ( [ query_partition_clause ] ) ]

Вычисляет медианное значение у переданного выражения (expr)

------------------------------------------------

### [min.sql](min.sql)

    MIN([ DISTINCT | ALL ] expr) [ OVER (analytic_clause) ]

Вовзращает минимальное значение у переданного выражения (expr)

------------------------------------------------

### [percent_rank_analytic.sql](analytic_functions/percent_rank/percent_rank_analytic.sql) и [percent_rank_aggregate.sql](percent_rank_aggregate.sql)

    percent_rank_aggregate::=
        PERCENT_RANK(expr [, expr ]...) WITHIN GROUP
            (ORDER BY
            expr [ DESC | ASC ]
                    [NULLS { FIRST | LAST } ]
            [, expr [ DESC | ASC ]
                    [NULLS { FIRST | LAST } ]
            ]...
        )

    percent_rank_analytic::=
        PERCENT_RANK( )
        OVER ([ query_partition_clause ] order_by_clause)

Возвращает относительный ранг текущей строки в группе строк

Формула вычисления (из докумнетации РБД)

    PERCENT_RANK = (RANK-1)/(<число строк в секции> - 1)

------------------------------------------------

### [percentile_cont.sql](percentile_cont.sql)


    PERCENTILE_CONT(expr) WITHIN GROUP
        (ORDER BY expr [ DESC | ASC ])
        [ OVER (query_partition_clause) ]

**PERCENTILE_CONT** is an inverse distribution function that assumes a continuous distribution model. It takes a percentile value and a sort specification, and returns an interpolated value that would fall into that percentile value with respect to the sort specification. Nulls are ignored in the calculation.

This function takes as an argument any numeric data type or any nonnumeric data type that can be implicitly converted to a numeric data type. The function returns the same data type as the numeric data type of the argument.

------------------------------------------------

### [percentile_disc.sql](percentile_disc.sql)

    PERCENTILE_DISC(expr) WITHIN GROUP
    (ORDER BY expr [ DESC | ASC ])
    [ OVER (query_partition_clause) ]

**PERCENTILE_DISC** is an inverse distribution function that assumes a discrete distribution model. It takes a percentile value and a sort specification and returns an element from the set. Nulls are ignored in the calculation.

This function takes as an argument any numeric data type or any nonnumeric data type that can be implicitly converted to a numeric data type. The function returns the same data type as the numeric data type of the argument.

------------------------------------------------

### [stats_binomial_test.sql](stats_binomial_test.sql)

    STATS_BINOMIAL_TEST(expr1, expr2, p
                        [, { 'TWO_SIDED_PROB'
                            | 'EXACT_PROB'
                            | 'ONE_SIDED_PROB_OR_MORE'
                            | 'ONE_SIDED_PROB_OR_LESS'
                            }
                        ]
                )

**STATS_BINOMIAL_TEST** is an exact probability test used for dichotomous variables, where only two possible values exist. It tests the difference between a sample proportion and a given proportion. The sample size in such tests is usually small.

------------------------------------------------

### [stats_crosstab.sql](stats_crosstab.sql)

    STATS_CROSSTAB(expr1, expr2
                    [, { 'CHISQ_OBS'
                    | 'CHISQ_SIG'
                    | 'CHISQ_DF'
                    | 'PHI_COEFFICIENT'
                    | 'CRAMERS_V'
                    | 'CONT_COEFFICIENT'
                    | 'COHENS_K'
                    }
                    ]
            )

Crosstabulation (commonly called crosstab) is a method used to analyze two nominal variables. The **STATS_CROSSTAB** function takes two required arguments: expr1 and expr2 are the two variables being analyzed. The optional third argument lets you specify the meaning of the NUMBER value returned by this function


------------------------------------------------

### [stats_f_test.sql](stats_f_test.sql)

    STATS_F_TEST(expr1, expr2
                    [, { { 'STATISTIC'
                    | 'DF_NUM'
                    | 'DF_DEN'
                    | 'ONE_SIDED_SIG'
                    } , expr3
                    | 'TWO_SIDED_SIG'
                    }
                    ]
            )

**STATS_F_TEST** tests whether two variances are significantly different. The observed value of f is the ratio of one variance to the other, so values very different from 1 usually indicate significant differences.


------------------------------------------------

### [stats_ks_test.sql](stats_ks_test.sql)


    STATS_KS_TEST(expr1, expr2
            [, { 'STATISTIC' | 'SIG' } ]
            )

**STATS_KS_TEST** is a Kolmogorov-Smirnov function that compares two samples to test whether they are from the same population or from populations that have the same distribution. It does not assume that the population from which the samples were taken is normally distributed.


------------------------------------------------

### [stats_mode.sql](stats_mode.sql)

    STATS_MODE(expr)

**STATS_MODE** принимает в качестве аргумента набор значений и возвращает значение, которое встречается с наибольшей частотой

------------------------------------------------

### [stats_mw_test.sql](stats_mw_test.sql)

    STATS_MW_TEST(expr1, expr2
                [, { 'STATISTIC'
                | 'U_STATISTIC'
                | 'ONE_SIDED_SIG' , expr3
                | 'TWO_SIDED_SIG'
                }
                ]
                )

**U-критерий Манна — Уитни** (англ. Mann–Whitney U test) — статистический критерий, используемый для оценки различий между двумя независимыми выборками по уровню какого-либо признака, измеренного количественно. Позволяет выявлять различия в значении параметра между малыми выборками

------------------------------------------------

### [stats_one_way_anova.sql](stats_one_way_anova.sql)

    STATS_ONE_WAY_ANOVA(expr1, expr2
                    [, { 'SUM_SQUARES_BETWEEN'
                    | 'SUM_SQUARES_WITHIN'
                    | 'DF_BETWEEN'
                    | 'DF_WITHIN'
                    | 'MEAN_SQUARES_BETWEEN'
                    | 'MEAN_SQUARES_WITHIN'
                    | 'F_RATIO'
                    | 'SIG'
                    }
                    ]
                    )

------------------------------------------------

### [stats_wsr_test.sql](stats_wsr_test.sql)

    STATS_WSR_TEST(expr1, expr2
                [, { 'STATISTIC'
                | 'ONE_SIDED_SIG'
                | 'TWO_SIDED_SIG'
                }
                ]
                )

------------------------------------------------

### [stddev.sql](stddev.sql)

    STDDEV([ DISTINCT | ALL ] expr)
        [ OVER (analytic_clause) ]


Функция **STDDEV** возвращает стандартное отклонение списка чисел.
Функцию STDDEV можно использовать двумя способами - в качестве агрегатной функции или в качестве аналитической функции.

------------------------------------------------

### [stddev_pop.sql](stddev_pop.sql)

    STDDEV_POP(expr)
    [ OVER (analytic_clause) ]

Функция **STDDEV_POP** возвращает среднеквадратичное отклонение для группы

------------------------------------------------

### [stddev_samp.sql](stddev_samp.sql)

Функция **STDDEV_SAMP** возвращает стандартное отклонение для группы

------------------------------------------------

### [sum.sql](sum/sum.sql)

    SUM([ DISTINCT | ALL ] expr)
    [ OVER (analytic_clause) ]

Функция возвращает сумму элементов выборки, которые не равны NULL

------------------------------------------------

### [sys_op_zone_id.sql](sys_op_zone_id.sql)

    SYS_OP_ZONE_ID( [ [ schema. ] table. | t_alias. ] rowid [, scale ] )

**SYS_OP_ZONE_ID** takes as its argument a rowid and returns a zone ID. The rowid identifies a row in a table. 
The zone ID identifies the set of contiguous disk blocks, called the zone, that contains the row. The function returns a NUMBER value

------------------------------------------------

### [sys_xmlagg.sql](sys_xmlagg.sql)

    SYS_XMLAGG(expr [, fmt ])

**SYS_XMLAgg** aggregates all of the XML documents or fragments represented by expr and produces a single XML document. It adds a new enclosing element with a default name ROWSET. If you want to format the XML document differently, then specify fmt, which is an instance of the XMLFormat object.

------------------------------------------------

### [to_approx_count_distinct.sql](to_approx_count_distinct.sql)

    TO_APPROX_COUNT_DISTINCT(detail)

------------------------------------------------
### [to_approx_percentile.sql](to_approx_percentile.sql)

    TO_APPROX_PERCENTILE(detail, expr, 'datatype'
    [, { 'DESC' | 'ASC' | 'ERROR_RATE' | 'CONFIDENCE' } ])
 
------------------------------------------------

### [var_pop.sql](var_pop.sql)

    VAR_POP(expr) [ OVER (analytic_clause) ]

Функция **VAR_POP** возвращает выборочную дисперсию для группы

------------------------------------------------

### [var_samp.sql](var_samp.sql)

    VAR_SAMP(expr) [ OVER (analytic_clause) ]
Функция **VAR_SAMP** возвращает несмещённую выборочную дисперсию для групп

------------------------------------------------

### [variance.sql](variance.sql)

    VARIANCE([ DISTINCT | ALL ] expr)
        [ OVER (analytic_clause) ]

**VARIANCE** returns the variance of expr. You can use it as an aggregate or analytic function.

Oracle Database calculates the variance of expr as follows:

* 0 if the number of rows in expr = 1
* VAR_SAMP if the number of rows in expr > 1

------------------------------------------------

### [xmlagg.sql](xmlagg.sql)

    XMLAGG(XMLType_instance [ order_by_clause ])

