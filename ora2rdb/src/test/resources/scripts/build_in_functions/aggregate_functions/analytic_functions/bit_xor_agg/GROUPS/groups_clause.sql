SELECT id,
       code,
       bin_value,
       bit_xor_agg(bin_value) OVER (PARTITION BY code ORDER BY id
                      GROUPS between 1 preceding and current row) AS rows_avg
from  t1;