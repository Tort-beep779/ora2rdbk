/*SELECT id,
       code,
       bin_value,
       [-unconvertible bit_or_agg(bin_value)] OVER (PARTITION BY code ORDER BY id
                      RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS rows_avg
from   t1;*/