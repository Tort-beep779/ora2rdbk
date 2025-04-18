CREATE EXCEPTION CUSTOM_EXCEPTION 'error';

CREATE FUNCTION DIV (m NUMERIC(34,10), n NUMERIC(34,10))
RETURNS NUMERIC(34,10)
AS
BEGIN
  RETURN cast(m as NUMERIC(34,10))/cast(n as NUMERIC(34,10));
END;

CREATE FUNCTION WIDTH_BUCKET(
    p_value NUMERIC(34,8),
    p_min_value NUMERIC(34,8),
    p_max_value NUMERIC(34,8),
    p_num_buckets NUMERIC(34,8) ) 
RETURNS NUMERIC(34,8) 
AS
    DECLARE bucket_size NUMERIC(34,8) ;
BEGIN
    -- Проверяем, что количество корзин положительное
    IF (p_num_buckets <= 0) THEN
        EXCEPTION CUSTOM_EXCEPTION('An invalid value was specified for the WIDTH_BUCKET function.');
    IF (p_min_value >= p_max_value) THEN
        EXCEPTION CUSTOM_EXCEPTION('MIN value more or equal than MAX value.');
    
    -- Рассчитываем размер каждой корзины
    bucket_size = DIV(p_max_value - p_min_value, p_num_buckets);

    -- Проверяем, в какую корзину попадает значение
    IF (p_value < p_min_value) THEN
        RETURN 0; -- Значение меньше минимального, корзина 0
    ELSE
      IF (p_value >= p_max_value) THEN
        RETURN p_num_buckets + 1; -- Значение больше или равно максимальному, корзина p_num_buckets + 1
      ELSE
        -- Рассчитываем номер корзины для значения
        RETURN FLOOR((p_value - p_min_value) / bucket_size) + 1;
END;

SELECT WIDTH_BUCKET(40, 0, 100, 5) FROM RDB$DATABASE;
SELECT WIDTH_BUCKET(3.7, 1, 9, 3) FROM RDB$DATABASE;

SELECT WIDTH_BUCKET(-3.7, 1, 9, 3) FROM RDB$DATABASE;
SELECT WIDTH_BUCKET(37, 1, 9, 3) FROM RDB$DATABASE;

SELECT WIDTH_BUCKET(-3.7, -9, -1, 3) FROM RDB$DATABASE;