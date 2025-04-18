SELECT id,
       code,
       bin_value,
       bit_or_agg(bin_value) OVER (PARTITION BY code ORDER BY id
                      RANGE CURRENT ROW) AS rows_avg
from   t1;