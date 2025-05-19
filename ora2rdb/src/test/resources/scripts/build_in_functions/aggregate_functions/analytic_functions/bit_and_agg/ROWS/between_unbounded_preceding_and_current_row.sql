SELECT id,
       code,
       bin_value,
       bit_and_agg(bin_value) OVER (PARTITION BY code ORDER BY id
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
from   t1;