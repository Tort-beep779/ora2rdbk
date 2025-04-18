select row_number () over (order by sal) as row_order,
       sal,
       STDDEV_SAMP(sal) over w1 as avg_rows
from emp
window w1 as (order by sal nulls last rows between 1 preceding and current row);