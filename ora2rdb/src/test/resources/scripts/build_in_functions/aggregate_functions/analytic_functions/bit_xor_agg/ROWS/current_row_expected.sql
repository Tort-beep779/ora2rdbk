/*SELECT id,
       code,
       bin_value,
       [-unconvertible bit_xor_agg(bin_value)] OVER (PARTITION BY code ORDER BY id
                      ROWS CURRENT ROW) AS rows_avg
from   t1;*/