SELECT id,
       code,
       bin_value,
       bit_and_agg(bin_value) OVER (PARTITION BY code ORDER BY id
                      RANGE 1 PRECEDING EXCLUDE CURRENT ROW)  AS rows_avg
from   t1;