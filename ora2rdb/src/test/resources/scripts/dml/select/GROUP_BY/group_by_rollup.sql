SELECT
    owner,
    COUNT(*) ownerobj#    -- сколько объектов у каждого владельца
FROM the_objects
GROUP BY ROLLUP(owner);