SELECT id,
       code,
       bin_value,
       bit_or_agg(bin_value) OVER (PARTITION BY code ORDER BY id
                      ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING) AS rows_avg
from   t1;
