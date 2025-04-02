/*SELECT id,
       code,
       bin_value,
       [-unconvertible bit_or_agg(bin_value)] OVER (PARTITION BY code ORDER BY id
                      [-unconvertible GROUPS between 1 preceding and current row]) AS rows_avg
from   t1;*/