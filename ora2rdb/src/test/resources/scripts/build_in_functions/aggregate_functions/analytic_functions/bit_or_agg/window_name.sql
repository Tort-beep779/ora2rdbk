SELECT id,
       code,
       bin_value,
       bit_or_agg(bin_value) OVER w1  AS rows_avg
from   t1
window w1 as (PARTITION BY code ORDER BY id
                     RANGE 1 PRECEDING EXCLUDE CURRENT ROW);