SELECT id,
       code,
       bin_value,
       bit_xor_agg(bin_value) OVER (PARTITION BY code ORDER BY id
                      ROWS 1 PRECEDING) AS rows_avg
from   t1;